return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local function sf_status()
            -- Cache the sf module to avoid multiple require calls
            local sf = require('sf')
            local status = ""

            -- Protected call to get target organization
            local ok, target_org = pcall(sf.get_target_org)
            if not ok or not target_org or target_org == "" then
                return ""
            end

            -- Add organization to status
            status = target_org

            -- Protected call to get coverage percentage
            local ok2, covered_percent = pcall(sf.covered_percent)
            if ok2 and covered_percent and covered_percent ~= "" then
                -- Format with proper spacing and more visible brackets
                status = status .. "(".. covered_percent .. ")"
            end

            return status
        end

        local gstatus = { ahead = 0, behind = 0 }
        local function update_gstatus()
            local Job = require 'plenary.job'
            Job:new({
                command = 'git',
                args = { 'rev-list', '--left-right', '--count', 'HEAD...@{upstream}' },
                on_exit = function(job, _)
                    local res = job:result()[1]
                    if type(res) ~= 'string' then
                        gstatus = { ahead = 0, behind = 0 }; return
                    end
                    local ahead, behind = res:match("(%d+)%s*(%d+)")
                    if not ahead or not behind then ahead, behind = 0, 0 end
                    gstatus = { ahead = tonumber(ahead), behind = tonumber(behind) }
                    -- Force lualine refresh
                    vim.schedule(function() require('lualine').refresh() end)
                end,
            }):start()
        end

        if _G.Gstatus_timer == nil then
            _G.Gstatus_timer = vim.loop.new_timer()
        else
            _G.Gstatus_timer:stop()
        end
        _G.Gstatus_timer:start(0, 2000, vim.schedule_wrap(update_gstatus))

        require('lualine').setup {
            options = {
                icons_enabled = true,
                theme = 'auto',
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                always_show_tabline = true,
                globalstatus = true,
                refresh = {
                    statusline = 100,
                    tabline = 100,
                    winbar = 100,
                }
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', function()
                    if gstatus.ahead > 0 then
                        return '↑' .. tostring(gstatus.ahead)
                    end
                    return ''
                end, function()
                    if gstatus.behind > 0 then
                        return '↓' .. tostring(gstatus.behind)
                    end
                    return ''
                end },
                lualine_c = { 'filename', 'diff', 'diagnostics' },
                lualine_x = { sf_status, 'fileformat', 'filetype' },
                lualine_y = { 'progress' },
                lualine_z = { 'location' }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            ns = {}
        }
    end,
}
