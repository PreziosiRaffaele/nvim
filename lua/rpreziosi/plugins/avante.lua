return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = {
        provider = "copilot",
        copilot = {
            endpoint = 'https://api.githubcopilot.com/',
            model = 'gemini-2.5-pro',
            proxy = nil,
            allow_insecure = false,
            timeout = 60000,
            temperature = 0.1,
            max_tokens = 30000,
        },
        openai = {
            endpoint = "https://api.openai.com/v1",
            model = "o3-2025-04-16",
            timeout = 60000,
            temperature = 0,
            reasoning_effort = 'high',
            disable_tools = true,
        },
        windows = {
            ---@type "right" | "left" | "top" | "bottom"
            position = "right", -- the position of the sidebar
            wrap = true, -- similar to vim.o.wrap
            width = 30, -- default % based on available width
            sidebar_header = {
                enabled = false, -- true, false to enable/disable the header
                align = "center", -- left, center, right for title
                rounded = true,
            },
            input = {
                prefix = "> ",
                height = 8, -- Height of the input window in vertical layout
            },
            edit = {
                border = "rounded",
                start_insert = true, -- Start insert mode when opening the edit window
            },
            ask = {
                floating = false, -- Open the 'AvanteAsk' prompt in a floating window
                start_insert = false, -- Start insert mode when opening the ask window
                border = "rounded",
                ---@type "ours" | "theirs"
                focus_on_apply = "ours", -- which diff to focus after applying
            },
        },
        claude = {
            endpoint = "https://api.anthropic.com",
            model = "claude-3-7-sonnet-20250219",
            timeout = 30000,
            temperature = 0,
            max_tokens = 10000,
            disable_tools = true,
        },
        dual_boost = {
            enabled = false,
            first_provider = "copilot",
            second_provider = "openai",
            prompt =
            "Based on the two reference outputs below, generate a response that incorporates elements from both but reflects your own judgment and unique perspective. Do not provide any explanation, just give the response directly. Reference Output 1: [{{provider1_output}}], Reference Output 2: [{{provider2_output}}]",
            timeout = 90000,
        },
        behaviour = {
            auto_suggestions = false, -- Experimental stage
            auto_set_highlight_group = true,
            auto_set_keymaps = true,
            auto_apply_diff_after_generation = false,
            support_paste_from_clipboard = false,
            minimize_diff = true,                       -- Whether to remove unchanged lines when applying a code block
            enable_token_counting = false,               -- Whether to enable token counting. Default to true.
            enable_cursor_planning_mode = false,        -- Whether to enable Cursor Planning Mode. Default to false.
            enable_claude_text_editor_tool_mode = true, -- Whether to enable Claude Text Editor Tool Mode.
            -- use_cwd_as_project_root = true
        },
        vendors = {
            copilot_gpt4o = {
                __inherited_from = "copilot",
                model = "gpt-4o",
                max_tokens = 20000,
                disable_tools = false,
            },
            copilot_claudeThought = {
                __inherited_from = "copilot",
                model = "claude-3.7-sonnet-thought",
                max_tokens = 20000,
                disable_tools = false,
            },
        },
    },
    keys = {
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- The below dependencies are optional,
        "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
        "hrsh7th/nvim-cmp",              -- autocompletion for avante commands and mentions
        "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
        "zbirenbaum/copilot.lua",        -- for providers='copilot'
        {
            -- support for image pasting
            "HakonHarnes/img-clip.nvim",
            event = "VeryLazy",
            opts = {
                -- recommended settings
                default = {
                    embed_image_as_base64 = false,
                    prompt_for_file_name = false,
                    drag_and_drop = {
                        insert_mode = true,
                    },
                    -- required for Windows users
                    use_absolute_path = true,
                },
            },
        },
        {
            -- Make sure to set this up properly if you have lazy=true
            'MeanderingProgrammer/render-markdown.nvim',
            opts = {
                file_types = { "markdown", "Avante" },
            },
            ft = { "markdown", "Avante" },
        },
    },
}
