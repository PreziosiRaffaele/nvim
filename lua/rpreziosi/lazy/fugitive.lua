return {
  "tpope/vim-fugitive",
  cmd = { "Git", "Gstatus", "Gblame", "Gpush", "Gpull" },
  keys = {
    { "<leader>gs", "<cmd>Git<cr>", desc = "Git status" },
    { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git blame" },
    { "<leader>gd", "<cmd>Gvdiffsplit<cr>", desc = "Git diff" },
  },
}