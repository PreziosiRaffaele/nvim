return {
    'projekt0n/github-nvim-theme',
    name = 'github-theme',
    lazy = false,
    priority = 1000,
    config = function()
        require('github-theme').setup({
            options = {
                -- Your preferences here
                styles = {
                    comments = 'italic',
                    keywords = 'bold',
                    types = 'italic',
                }
            }
        })
        vim.cmd('colorscheme github_dark_default')
    end,
}
