return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        bigfile = { enabled = true },
        dashboard = { enabled = false },
        explorer = { enabled = false },
        indent = { enabled = true, scope = { enabled = false } },
        input = { enabled = true },
        picker = {
            enabled = true,
            layout = { preset = 'vertical', cycle = false },
            layouts = {
                vertical = {
                    layout = {
                        backdrop = false,
                        width = 0.9,
                        min_width = 80,
                        height = 0.9,
                        min_height = 30,
                        box = 'vertical',
                        border = 'rounded',
                        title = '{title} {live} {flags}',
                        title_pos = 'center',
                        { win = 'preview', title = '{preview}', height = 0.6, border = 'none' },
                        { win = 'list', border = 'top' },
                        { win = 'input', height = 1, border = 'top' },
                    },
                },
            },
            matcher = { frecency = true },
            win = {
                input = {
                    keys = {
                        ['<C-j>'] = { 'preview_scroll_down', mode = { 'i', 'n' } },
                        ['<C-k>'] = { 'preview_scroll_up', mode = { 'i', 'n' } },
                        ['<C-h>'] = { 'preview_scroll_left', mode = { 'i', 'n' } },
                        ['<C-l>'] = { 'preview_scroll_right', mode = { 'i', 'n' } },
                    },
                },
            },
            previewers = {
                git = {
                    builtin = false,
                    args = {},
                },
                diff = {
                    builtin = false,
                    cmd = { 'delta' },
                },
            },
        },
        notifier = { enabled = false },
        quickfile = { enabled = false },
        scope = { enabled = false },
        scroll = { enabled = false },
        statuscolumn = { enabled = false },
        words = { enabled = false },
    },
    keys = {
        {
            '<leader>fF',
            function()
                Snacks.picker.files()
            end,
            desc = 'Smart Find Files',
        },
        {
            '<leader>ff',
            function()
                Snacks.picker.smart()
            end,
            desc = 'Find Files',
        },
        {
            '<leader>fg',
            function()
                Snacks.picker.grep()
            end,
            desc = 'Grep',
        },
        {
            '<leader>fh',
            function()
                Snacks.picker.help()
            end,
            desc = 'Help',
        },
        {
            '<leader>bl',
            function()
                Snacks.picker.buffers({
                    layout = 'select',
                })
            end,
            desc = 'Buffers',
        },
        {
            '<leader>gl',
            function()
                Snacks.picker.git_log()
            end,
            desc = 'Git Log',
        },
        {
            '<leader>gL',
            function()
                Snacks.picker.git_log_file()
            end,
            desc = 'Git Log File',
        },
        {
            '<leader>fc',
            function()
                Snacks.picker.colorschemes({
                    layout = 'ivy',
                })
            end,
            desc = 'Colorscheme',
        },
        {
            '<leader>gsl',
            function()
                Snacks.picker.git_stash()
            end,
            desc = 'Git Stash',
        },
        {
            '<leader>fa',
            function()
                Snacks.picker.files({
                    hidden = true,
                    ignored = true,
                })
            end,
            desc = 'Find All Files',
        },
        {
            '<leader>gb',
            function()
                Snacks.picker.git_branches({
                    layout = 'select',
                })
            end,
            desc = 'Git Branches',
        },
        {
            '<leader>fD',
            function()
                local cwd = vim.fn.getcwd()
                vim.ui.input({
                    prompt = 'Grep in directory (relative to ' .. vim.fn.fnamemodify(cwd, ':t') .. '): ',
                    default = '',
                    completion = 'dir',
                }, function(input)
                    if input and input ~= '' then
                        local search_dir = vim.fn.resolve(vim.fn.expand(input))
                        if vim.fn.isdirectory(search_dir) == 1 then
                            Snacks.picker.grep({
                                dirs = { search_dir },
                                hidden = true,
                                ignored = true,
                            })
                        else
                            vim.notify('Directory does not exist: ' .. search_dir, vim.log.levels.ERROR)
                        end
                    end
                end)
            end,
            desc = 'Grep in Directory',
        },
    },
}
