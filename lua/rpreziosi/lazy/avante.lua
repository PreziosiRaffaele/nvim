return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = {
        provider = "copilot",
        copilot = {
            endpoint = 'https://api.githubcopilot.com/',
            model = 'claude-3.7-sonnet',
            proxy = nil,            -- [protocol://]host[:port] Use this proxy
            allow_insecure = false, -- Do not allow insecure server connections
            timeout = 30000,        -- Timeout in milliseconds
            temperature = 0.1,
            max_tokens = 20000,     -- kinda creative
        },
        openai = {
            endpoint = "https://api.openai.com/v1",
            model = "o3-mini", -- your desired model 
            timeout = 30000,  -- Timeout in milliseconds, increase this for reasoning models
            temperature = 0,
            reasoning_effort = 'high'
        },
        claude = {
            endpoint = "https://api.anthropic.com",
            model = "claude-3-7-sonnet-20250219",
            timeout = 30000, -- Timeout in milliseconds
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
            timeout = 90000, -- Timeout in milliseconds
        },
        behaviour = {
            auto_suggestions = false, -- Experimental stage
            auto_set_highlight_group = true,
            auto_set_keymaps = true,
            auto_apply_diff_after_generation = false,
            support_paste_from_clipboard = false,
            minimize_diff = true,                -- Whether to remove unchanged lines when applying a code block
            enable_token_counting = true,        -- Whether to enable token counting. Default to true.
            enable_cursor_planning_mode = false, -- Whether to enable Cursor Planning Mode. Default to false.
            enable_claude_text_editor_tool_mode = false, -- Whether to enable Claude Text Editor Tool Mode.
        },

        vendors = {
            copilot_gpt4o = {
                __inherited_from = "copilot",
                model = "gpt-4o",
                max_tokens = 20000,
                disable_tools = true,
            },
            copilot_claudeThought = {
                __inherited_from = "copilot",
                model = "claude-3.7-sonnet-thought",
                max_tokens = 20000,
                disable_tools = true,
            },
        },
    },
    keys = {
        { '<leader>aC', '<cmd>AvanteClear<cr>', desc = 'Avante - Clear' },
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
