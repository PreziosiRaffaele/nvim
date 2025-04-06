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
            temperature = 0.1,      -- kinda creative
            max_tokens = 10000,
        },
        openai = {
            endpoint = "https://api.openai.com/v1",
            model = "gpt-4o",  -- your desired model (or use gpt-4o, etc.)
            timeout = 30000,   -- Timeout in milliseconds, increase this for reasoning models
            temperature = 0,
            max_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
            --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
        },
        claude = {
            endpoint = "https://api.anthropic.com",
            model = "claude-3-7-sonnet-20250219",
            timeout = 30000, -- Timeout in milliseconds
            temperature = 0,
            max_tokens = 10000,
        },
        dual_boost = {
            enabled = false,
            first_provider = "copilot",
            second_provider = "openai",
            prompt =
            "Based on the two reference outputs below, generate a response that incorporates elements from both but reflects your own judgment and unique perspective. Do not provide any explanation, just give the response directly. Reference Output 1: [{{provider1_output}}], Reference Output 2: [{{provider2_output}}]",
            timeout = 60000, -- Timeout in milliseconds
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
