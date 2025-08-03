return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },

    config = function()
        local function sf_status()
            -- Cache the sf module to avoid multiple require calls
            local sf = require('sf')
            local status = ''

            -- Protected call to get target organization
            local ok, target_org = pcall(sf.get_target_org)
            if not ok or not target_org or target_org == '' then
                return ''
            end

            -- Add organization to status
            status = target_org

            -- Protected call to get coverage percentage
            local ok2, covered_percent = pcall(sf.covered_percent)
            if ok2 and covered_percent and covered_percent ~= '' then
                -- Format with proper spacing and more visible brackets
                status = status .. '(' .. covered_percent .. ')'
            end

            return status
        end

        local gstatus = { ahead = 0, behind = 0 }
        local function update_gstatus()
            local Job = require('plenary.job')
            Job:new({
                command = 'git',
                args = { 'rev-list', '--left-right', '--count', 'HEAD...@{upstream}' },
                on_exit = function(job, _)
                    local res = job:result()[1]
                    if type(res) ~= 'string' then
                        gstatus = { ahead = 0, behind = 0 }
                        return
                    end
                    local ahead, behind = res:match('(%d+)%s*(%d+)')
                    if not ahead or not behind then
                        ahead, behind = 0, 0
                    end
                    gstatus = { ahead = tonumber(ahead), behind = tonumber(behind) }
                    -- Force lualine refresh
                    vim.schedule(function()
                        require('lualine').refresh()
                    end)
                end,
            }):start()
        end

        if _G.Gstatus_timer == nil then
            _G.Gstatus_timer = vim.loop.new_timer()
        else
            _G.Gstatus_timer:stop()
        end
        _G.Gstatus_timer:start(0, 2000, vim.schedule_wrap(update_gstatus))


        -- stylua: ignore
        local colors = {
            blue       = '#32748e',
            cyan       = '#79dac8',
            black      = '#15191e',
            white      = '#c6c6c6',
            red        = '#ff5189',
            yellow     = '#f5c175',
            grey       = '#262339',
            background = '#191724',
            pink       = '#ebbcba',
            coral     = '#3788af',
        }

        local bubbles_theme = {
            normal = {
                a = { fg = colors.black, bg = colors.yellow, gui = 'bold' },
                b = { fg = colors.white, bg = colors.grey },
                c = { fg = colors.white, bg = colors.background },
            },
            terminal = {
                a = { fg = colors.black, bg = colors.coral, gui = 'bold' },
            },
            insert = { a = { fg = colors.black, bg = colors.blue, gui = 'bold' } },
            visual = { a = { fg = colors.black, bg = colors.cyan, gui = 'bold' } },
            replace = { a = { fg = colors.black, bg = colors.red, gui = 'bold' } },
            inactive = {
                a = { fg = colors.white, bg = colors.black },
                b = { fg = colors.white, bg = colors.black },
                c = { fg = colors.white },
            },
        }

        require('lualine').setup({
            options = {
                icons_enabled = false,
                theme = bubbles_theme,
                section_separators = { left = '', right = '' },
                component_separators = '',
                globalstatus = true,
                refresh = {
                    statusline = 100,
                    tabline = 100,
                    winbar = 100,
                },
            },
            sections = {
                lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
                lualine_b = {
                    'filename',
                    'diagnostics',
                },
                lualine_c = {
                    {
                        'branch',
                        icons_enabled = true,
                        icon = '',
                    },
                    {
                        function()
                            if gstatus.ahead > 0 then
                                return '↑' .. tostring(gstatus.ahead)
                            end
                            return ''
                        end,
                    },
                    {
                        function()
                            if gstatus.behind > 0 then
                                return '↓' .. tostring(gstatus.behind)
                            end
                            return ''
                        end,

                    },
                    {
                        'diff',
                    },
                },
                lualine_x = {
                    'searchcount',
                    {
                        sf_status,
                        icons_enabled = true,
                        icon = '󰢎',
                    },
                },
                lualine_y = { 'filetype' },
                lualine_z = {
                    { 'location', separator = { right = '' }, left_padding = 2 },
                },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            ns = {},
        })
    end,
}
