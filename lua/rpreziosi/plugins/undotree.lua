return {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = {
        { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Toggle Undotree" }
    },
    config = function()
        vim.g.undotree_WindowLayout = 3
        vim.g.undotree_DiffAutoOpen = 0
        vim.g.undotree_SetFocusWhenToggle = 1
    end,
}

