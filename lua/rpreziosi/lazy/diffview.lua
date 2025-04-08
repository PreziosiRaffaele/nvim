return {
  "sindrets/diffview.nvim",
  config = function()
    require("diffview").setup({
    })
    vim.api.nvim_set_keymap("n", "<leader>do", ":DiffviewOpen<CR>", { desc = "Open DiffView" })
    vim.api.nvim_set_keymap("n", "<leader>dc", ":DiffviewClose<CR>", { desc = "Close DiffView" })
    -- File history
    vim.api.nvim_set_keymap("n", "<leader>df", ":DiffviewFileHistory --no-merges --max-count=60 %<CR>",
      { desc = "Git File History (NO MERGES)" })
    vim.api.nvim_set_keymap("n", "<leader>dm", ":DiffviewFileHistory --max-count=60 %<CR>",
      { desc = "Git File History" })
    vim.api.nvim_set_keymap("n", "<leader>dh", ":DiffviewFileHistory --no-merges --max-count=1000<CR>",
      { desc = "Git Current Directory History (NO MERGES)" })
    vim.api.nvim_set_keymap("n", "<leader>dl", ":DiffviewFileHistory --max-count=1000<CR>",
      { desc = "Git Current Directory History" })
    vim.api.nvim_set_keymap("n", "<leader>ds", ":DiffviewFileHistory -g --range=stash<CR>",
      { desc = "Git Stash History" })
  end,
}
