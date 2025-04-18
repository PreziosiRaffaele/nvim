return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts_extend = { "spec" },
    opts = {
        spec = {
            { "<leader>gs", group = "Git Stash" },
            { "<leader>g", group = "Git"},
            { "<leader>s", group = "Salesforce"},
            { "<leader>a", group = "Copilot"}
        },
    },
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
}
