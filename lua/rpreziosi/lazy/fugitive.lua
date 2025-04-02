return {
    'tpope/vim-fugitive',
    config = function()
        vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = "Git status" })
        vim.keymap.set('n', '<leader>gc', ':Git commit<CR>', { desc = "Git commit" })
        vim.keymap.set('n', '<leader>gp', ':Git push<CR>', { desc = "Git push" })
        vim.keymap.set('n', '<leader>gP', ':Git pull --quiet<CR>', { desc = "Git pull" })
        vim.keymap.set('n', '<leader>gf', ':Git fetch <CR>', { desc = "Git fetch" })
        vim.keymap.set('n', '<leader>grs', ':Git reset --soft HEAD~1<CR>', { desc = "Git reset soft (keep staged)" })
        vim.keymap.set('n', '<leader>gF', ':Git push --force<CR>', { desc = "Git force push" })
        vim.keymap.set('n', '<leader>gA', ':Git commit --amend<CR>', { desc = "Git amend commit" })
        vim.keymap.set('n', '<leader>gC', ':Git checkout -b ', { desc = "Create new branch" }) -- Type new branch name
    end
}
