vim.g.mapleader = " " -- Set leader key before Lazy

-- Basic editor settings
vim.opt.number = true        -- Show line numbers
vim.opt.relativenumber = false -- Don't show relative line numbers, only absolute
vim.opt.cursorline = true    -- Highlight current line
vim.opt.wrap = false         -- Don't wrap lines
vim.opt.expandtab = true     -- Use spaces instead of tabs
vim.opt.tabstop = 2          -- Number of spaces tabs count for
vim.opt.shiftwidth = 2       -- Size of an indent
vim.opt.smartindent = true   -- Insert indents automatically
vim.opt.termguicolors = true -- True color support
vim.opt.signcolumn = "yes"   -- Always show sign column

-- Command-line history and completion
vim.opt.history = 1000       -- Store more command history
vim.opt.wildmenu = true      -- Show command-line completion
vim.opt.wildmode = "longest:full,full" -- Complete longest common string, then each full match
vim.opt.inccommand = "split" -- Show incremental effects of commands
vim.opt.ignorecase = true    -- Ignore case when searching
vim.opt.smartcase = true     -- Override ignorecase when search has uppercase

-- Enhanced tab completion for commands
vim.cmd[[
  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
  endfunction

  function! s:show_command_history() abort
    call feedkeys(":\<Up>", 'n')
    return ''
  endfunction
  
  cnoremap <expr> <Tab> wildmenumode() ? "\<C-n>" : "\<Tab>"
  cnoremap <expr> <S-Tab> wildmenumode() ? "\<C-p>" : "\<S-Tab>"
  cnoremap <C-p> <Up>
  cnoremap <C-n> <Down>
]]

require("rpreziosi.lazy_init")
