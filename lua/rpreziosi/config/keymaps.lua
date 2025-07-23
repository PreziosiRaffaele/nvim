-- Keymap definitions
local function setup()
    -- Shortcuts for quickfix navigation
    vim.keymap.set('n', '<C-n>', '<cmd>cnext<CR>', { desc = 'Next quickfix item' })
    vim.keymap.set('n', '<C-p>', '<cmd>cprev<CR>', { desc = 'Previous quickfix item' })

    -- Ensure ESC works normally no remap
    vim.keymap.set('i', '<Esc>', '<Esc>', { noremap = true, silent = true })

    -- Copy filename to cliboard (Example: "EndAssignment.flow-meta.xml" -> "EndAssignment")
    vim.keymap.set('n', '<leader>cn', function()
        local filename = vim.fn.expand('%:t')
        local base = filename:match('^[^%.]+')
        vim.fn.setreg('+', base)
        print('Copied to clipboard: ' .. base)
    end, { desc = 'Copy filename in the clipboard' })

    -- Additional buffer 
    vim.keymap.set('n', '<Tab>', '<cmd>bnext<CR>', { desc = 'Next buffer' })
    vim.keymap.set('n', '<S-Tab>', '<cmd>bprevious<CR>', { desc = 'Previous buffer' })
    vim.keymap.set('n', '<leader>bs', '<cmd>w<CR>', { desc = 'Save buffer' })
    vim.keymap.set('n', '<leader>bd', '<cmd>bd<CR>', { desc = 'Delete buffer' })
    vim.keymap.set('n', '<leader>bD', '<cmd>bd!<CR>', { desc = 'Force delete buffer' })

    -- Quit nvim
    vim.keymap.set('n', '<leader>qq', '<cmd>qa<CR>', { desc = 'Quit all' })
    vim.keymap.set('n', '<leader>qQ', '<cmd>qa!<CR>', { desc = 'Force quit all' })

    -- Go back to normal mode
    vim.keymap.set('i', 'jj', '<Esc>', { desc = 'Go back to normal mode' })
    vim.keymap.set('t', 'jj', '<C-\\><C-n>', { desc = 'Enter normal mode' })

    -- Delete all buffers with confirmation
    vim.keymap.set('n', '<leader>bA', function()
        local choice = vim.fn.confirm('Delete all buffers (including unsaved)?', '&Yes\n&No', 2)
        if choice == 1 then
            vim.cmd('%bd!')
        end
    end, { desc = 'Delete all buffers with confirmation' })

    -- Clear search highlighting
    vim.keymap.set('n', '<leader>/', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })

    -- JIRA update custom field
    vim.keymap.set('n', '<leader>jd', '<cmd>JiraUpdateSolutionDesign<CR>', { desc = 'Update Jira Solution Design' })

    -- Show nvim messages in a new buffer
    vim.api.nvim_create_user_command('MessagesInBuffer', function()
        vim.cmd('enew')
        vim.cmd('setlocal buftype=nofile bufhidden=wipe noswapfile')
        vim.api.nvim_buf_set_name(0, 'NVIM Messages')
        local messages = vim.fn.execute('messages')
        -- The result of execute('messages') can start with a newline
        if messages:sub(1, 1) == '\n' then
            messages = messages:sub(2)
        end
        vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(messages, '\n'))
    end, {})

    -- Reload buffer
    vim.keymap.set('n', '<leader>rb', '<cmd>e!<CR>', { desc = 'Reload buffer' })

end

return { setup = setup }
