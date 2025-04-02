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
                                default = "claude-3.7-sonnet",
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
