-- Keymap definitions
local function setup()
    -- Shortcuts for quickfix navigation
    vim.keymap.set('n', '<C-n>', '<cmd>cnext<CR>', { desc = 'Next quickfix item' })
    vim.keymap.set('n', '<C-p>', '<cmd>cprev<CR>', { desc = 'Previous quickfix item' })

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
    vim.keymap.set("n", "<leader>bD", "<cmd>bd!<CR>", { desc = "Force delete buffer" })

    -- Quit nvim
    vim.keymap.set("n", "<leader>qq", "<cmd>qa<CR>", { desc = "Quit all" })

    -- Go back to normal mode
    vim.keymap.set("i", "jj", "<Esc>", { desc = "Go back to normal mode" })

    -- Delete all buffers with confirmation
    vim.keymap.set("n", "<leader>bA", function()
        local choice = vim.fn.confirm("Delete all buffers (including unsaved)?", "&Yes\n&No", 2)
        if choice == 1 then
            vim.cmd("%bd!")
        end
    end, { desc = "Delete all buffers with confirmation" })

    -- Clear search highlighting
    vim.keymap.set('n', '<leader>/', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })
end

return { setup = setup }

