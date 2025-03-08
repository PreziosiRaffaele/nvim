return {
  "github/copilot.vim",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    -- Basic setup
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true
    vim.g.copilot_tab_fallback = ""
    
    -- Custom keymapping for accepting suggestions
    vim.keymap.set("i", "<C-j>", 'copilot#Accept("<CR>")', {
      expr = true,
      replace_keycodes = false,
      silent = true,
    })
    
    -- Additional keymaps - using keys that won't conflict with Escape
    vim.keymap.set("i", "<C-n>", "<Plug>(copilot-next)", { silent = true })
    vim.keymap.set("i", "<C-p>", "<Plug>(copilot-previous)", { silent = true })
    vim.keymap.set("i", "<C-\\>", "<Plug>(copilot-dismiss)", { silent = true })
    
    -- Ensure ESC works normally
    vim.keymap.set("i", "<Esc>", "<Esc>", { noremap = true, silent = true })
  end,
}