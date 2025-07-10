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
        input = { enabled = false },
        picker = {
            enabled = true,
            layout = { preset = 'sidebar', cycle = false },
            layouts = {
                vertical = {
                    layout = {
                        backdrop = false,
                        width = 0.8,
                        min_width = 80,
                        height = 0.9,
                        min_height = 30,
                        box = 'vertical',
                        border = 'rounded',
                        title = '{title} {live} {flags}',
                        title_pos = 'center',
                        { win = 'input', height = 1, border = 'bottom' },
                        { win = 'list', border = 'none' },
                        { win = 'preview', title = '{preview}', height = 0.6, border = 'top' },
                    },
                },
            },
            matcher = { frecency = true },
            win = {
                input = {
                    keys = {
                        ['J'] = { 'preview_scroll_down', mode = { 'i', 'n' } },
                        ['K'] = { 'preview_scroll_up', mode = { 'i', 'n' } },
                        ['H'] = { 'preview_scroll_left', mode = { 'i', 'n' } },
                        ['L'] = { 'preview_scroll_right', mode = { 'i', 'n' } },
                    },
                },
            },
            formatters = {
                file = {
                    filename_first = true, -- display filename before the file path
                    truncate = 80,
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
            desc = 'Smart Find Files',
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
                Snacks.picker.buffers()
            end,
            desc = 'Buffers',
        },
        {
            '<leader>gl',
            function()
                Snacks.picker.git_log({
                    layout = 'vertical',
                })
            end,
            desc = 'Git Log',
        },
        {
            '<leader>gL',
            function()
                Snacks.picker.git_log_file({
                    layout = 'vertical',
                })
            end,
            desc = 'Git Log File',
        },
    },
}
