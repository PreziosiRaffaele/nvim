return {
    'yetone/avante.nvim',
    cmd = { 'AvanteToggle', 'AvanteAsk' },
    keys = {
        { '<leader>at', '<cmd>AvanteToggle<cr>', desc = 'Avante' },
        { '<leader>aa', '<cmd>AvanteAsk<cr>', desc = 'Avante Ask' },
    },
    version = false, -- Never set this value to "*"! Never!
    opts = {
        provider = 'openai',
        providers = {
            openai = {
                endpoint = 'https://api.openai.com/v1',
                model = 'o3-2025-04-16',
                extra_request_body = {
                    max_completion_tokens = 100000
                },
            },
            openai_o3pro = {
                __inherited_from = 'openai',
                model = 'o3-pro-2023-05-03',
                extra_request_body = {
                    max_completion_tokens = 100000
                },
            },
            openai_04mini = {
                __inherited_from = 'openai',
                model = 'o4-mini-2025-04-16',
                extra_request_body = {
                    max_completion_tokens = 100000
                },

            }
        },
        windows = {
            ---@type "right" | "left" | "top" | "bottom"
            position = 'right', -- the position of the sidebar
            wrap = true, -- similar to vim.o.wrap
            width = 30, -- default % based on available width
            sidebar_header = {
                enabled = false, -- true, false to enable/disable the header
                align = 'center', -- left, center, right for title
                rounded = true,
            },
            input = {
                prefix = '> ',
                height = 8, -- Height of the input window in vertical layout
            },
            edit = {
                border = 'rounded',
                start_insert = true, -- Start insert mode when opening the edit window
            },
            ask = {
                floating = false, -- Open the 'AvanteAsk' prompt in a floating window
                start_insert = false, -- Start insert mode when opening the ask window
                border = 'rounded',
                ---@type "ours" | "theirs"
                focus_on_apply = 'ours', -- which diff to focus after applying
            },
        },
        behaviour = {
            auto_suggestions = false, -- Experimental stage
            auto_set_highlight_group = true,
            auto_set_keymaps = true,
            auto_apply_diff_after_generation = false,
            support_paste_from_clipboard = false,
            minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
            enable_token_counting = false, -- Whether to enable token counting. Default to true.
            enable_cursor_planning_mode = false, -- Whether to enable Cursor Planning Mode. Default to false.
            enable_claude_text_editor_tool_mode = true, -- Whether to enable Claude Text Editor Tool Mode.
        },
        tools = {
            disabled_tools = { 'git_commit' },
        },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = 'make',
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'stevearc/dressing.nvim',
        'nvim-lua/plenary.nvim',
        'MunifTanjim/nui.nvim',
        --- The below dependencies are optional,
        'ibhagwan/fzf-lua',
        'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
        {
            -- Make sure to set this up properly if you have lazy=true
            'MeanderingProgrammer/render-markdown.nvim',
            opts = {
                file_types = { 'markdown', 'Avante' },
            },
            ft = { 'markdown', 'Avante' },
        },
    },
}
