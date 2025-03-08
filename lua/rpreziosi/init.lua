vim.g.mapleader = " " -- Set leader key before Lazy

-- Basic editor settings
vim.opt.number = true        -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.cursorline = true    -- Highlight current line
vim.opt.wrap = false         -- Don't wrap lines
vim.opt.expandtab = true     -- Use spaces instead of tabs
vim.opt.tabstop = 2          -- Number of spaces tabs count for
vim.opt.shiftwidth = 2       -- Size of an indent
vim.opt.smartindent = true   -- Insert indents automatically
vim.opt.termguicolors = true -- True color support
vim.opt.signcolumn = "yes"   -- Always show sign column

require("rpreziosi.lazy_init")
