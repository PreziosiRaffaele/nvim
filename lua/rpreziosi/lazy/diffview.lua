return {
  "sindrets/diffview.nvim",
  config = function()
    require("diffview").setup({
    })
    vim.api.nvim_set_keymap("n", "<leader>do", ":DiffviewOpen<CR>",  {desc= "Open DiffView"})
    vim.api.nvim_set_keymap("n", "<leader>dc", ":DiffviewClose<CR>", {desc= "Close DiffView"})
  end,
}
