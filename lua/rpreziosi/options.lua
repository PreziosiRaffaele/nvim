-- Set vim options
local function setup()
    -- Set leader key to space
    vim.g.mapleader = " "

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

    -- Persistent undo history
    vim.opt.undofile = true

    -- Shortcuts for quickfix navigation
    vim.keymap.set('n', '<C-n>', '<cmd>cnext<CR>', { desc = 'Next quickfix item' })
    vim.keymap.set('n', '<C-p>', '<cmd>cprev<CR>', { desc = 'Previous quickfix item' })

    -- diagnostics
    vim.diagnostic.config({ virtual_text = true, signs = true })

    -- Ensure ESC works normally no remap
    vim.keymap.set("i", "<Esc>", "<Esc>", { noremap = true, silent = true })

    -- Copy filename to cliboard (Example: "EndAssignment.flow-meta.xml" -> "EndAssignment")
    vim.keymap.set("n", "<leader>cn", function()
        local filename = vim.fn.expand("%:t")
        local base = filename:match("^[^%.]+")
        vim.fn.setreg("+", base)
        print("Copied to clipboard: " .. base)
    end, { desc = "Copy filename in the clipboard" })

    -- Additional buffer management shortcuts
    vim.keymap.set("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Next buffer" })
    vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
    vim.keymap.set("n", "<leader>bs", "<cmd>w<CR>", { desc = "Save buffer" })
    vim.keymap.set("n", "<leader>bd", "<cmd>bd<CR>", { desc = "Delete buffer" })
end

return { setup = setup }
