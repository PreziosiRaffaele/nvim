return {
  "VVoruganti/today.nvim",
  config = function()
    require("today").setup({
      -- Default configuration
      journal_path = "~/journal",
      template_path = nil,
      date_format = "%Y-%m-%d",
      prompt_title = false,
      open_strategy = "vsplit",
    })
    
    -- Set keymaps
    vim.keymap.set("n", "<leader>td", "<cmd>Today<cr>", { desc = "Open today's journal" })
    vim.keymap.set("n", "<leader>ty", "<cmd>Yesterday<cr>", { desc = "Open yesterday's journal" })
    vim.keymap.set("n", "<leader>tm", "<cmd>Tomorrow<cr>", { desc = "Open tomorrow's journal" })
  end,
}
