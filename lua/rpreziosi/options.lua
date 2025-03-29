-- Set vim options
local function setup()
  vim.g.mapleader = " " -- Set leader key before Lazy
  
  -- Basic editor settings
  vim.opt.number = true
  vim.opt.relativenumber = true
  vim.opt.cursorline = true    -- Highlight current line
  vim.opt.wrap = false         -- Don't wrap lines
  vim.opt.expandtab = true     -- Use spaces instead of tabs
  vim.opt.tabstop = 4          -- Number of spaces tabs count for
  vim.opt.shiftwidth = 4       -- Size of an indent
  vim.opt.softtabstop = 4      -- Number of spaces a tab counts for when editing
  vim.opt.smartindent = true   -- Insert indents automatically
  vim.opt.termguicolors = true -- True color support
  vim.opt.signcolumn = "yes"   -- Always show sign column
  
  -- Command-line history and completion
  vim.opt.history = 1000       -- Store more command history
  vim.opt.pumheight = 15       -- Maximum number of items to show in popup menu
  vim.opt.inccommand = "split" -- Show incremental effects of commands
  vim.opt.ignorecase = true    -- Ignore case when searching
  vim.opt.smartcase = true     -- Override ignorecase when search has uppercase
  
  -- Use the system clipboard by default for yank and paste
  vim.opt.clipboard = "unnamedplus"
  
  -- Shortcuts for quickfix navigation
  vim.keymap.set('n', '<C-n>', '<cmd>cnext<CR>', { desc = 'Next quickfix item' })
  vim.keymap.set('n', '<C-p>', '<cmd>cprev<CR>', { desc = 'Previous quickfix item' })
end

return { setup = setup }