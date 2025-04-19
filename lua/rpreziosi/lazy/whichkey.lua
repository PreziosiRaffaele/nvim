return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts_extend = { "spec" },
    opts = {
        icons = {
            mappings = false
        },
        spec = {
            -- { "<leader>s", group = "Salesforce", icon = { icon = "󰅟", hl = "", color = "blue" } },
            { "<leader>gs", group = "Git Stash" },
            { "<leader>gr", group = "Git Restore/Reset" },
            { "<leader>g",  group = "Git" },
            { "<leader>s",  group = "Salesforce" },
            { "<leader>a",  group = "Avante" },
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
