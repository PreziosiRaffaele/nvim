return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("codecompanion").setup({
            prompt_library = {
                ["Review the code"] = {
                    strategy = "chat",
                    description = "Review the code and suggest improvements",
                    prompts = {
                        {
                            role = "system",
                            content =
                            "Review the provided code for readability, efficiency, and best practices. Identify potential bugs, security vulnerabilities, and areas for optimization. Suggest improvements for maintainability and scalability.",
                        },
                        {
                            role = "user",
                            content = "Review the following code: "
                        }
                    },
                }
            },
            display = {
                chat = {
                    render_headers = false,
                    show_settings = true,
                },
            },
            strategies = {
                chat = {
                    adapter = "copilot",
                    slash_commands = {
                        ["file"] = {
                            opts = {
                                provider = "telescope",
                            },
                        },
                        ["buffer"] = {
                            opts = {
                                provider = "telescope",
                            },
                        },
                    },
                },
                inline = {
                    adapter = "copilot",
                },
            },
            adapters = {
                copilot = function()
                    return require("codecompanion.adapters").extend("copilot", {
                        schema = {
                            model = {
                                order = 1,
                                mapping = "parameters",
                                type = "enum",
                                desc = "ID of the model to use. See the model endpoint compatibility table for details on which models work with the Chat API.",
                                ---@type string|fun(): string
                                default = "claude-3.7-sonnet",
                                choices = {
                                    ["o3-mini-2025-01-31"] = { opts = { can_reason = true } },
                                    ["o1-2024-12-17"] = { opts = { can_reason = true } },
                                    ["o1-mini-2024-09-12"] = { opts = { can_reason = true } },
                                    "claude-3.5-sonnet",
                                    "claude-3.7-sonnet",
                                    "claude-3.7-sonnet-thought",
                                    "gpt-4o-2024-08-06",
                                    "gemini-2.0-flash-001",
                                },
                            },
                        },
                    })
                end,
            },
        })
        vim.keymap.set("n", "<leader>cc", ':CodeCompanionChat toggle<CR>', { desc = "CodeCompanion: Toggle chat" })
        vim.keymap.set("v", "<leader>cl", ':CodeCompanionAction<CR>', { desc = "CodeCompanion: List actions" })
    end,
}
