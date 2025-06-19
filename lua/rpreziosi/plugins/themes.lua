return {
    {
        'projekt0n/github-nvim-theme',
        name = 'github-theme',
        lazy = true,
        priority = 900,
        config = function()
            require('github-theme').setup({
                options = {
                    -- Your preferences here
                    styles = {
                        comments = 'italic',
                        keywords = 'bold',
                        types = 'italic',
                    },
                },
            })
            -- vim.cmd('colorscheme github_dark_default')
        end,
    },
    {
        'rebelot/kanagawa.nvim',
        lazy = true, -- Changed from false to true to disable auto-loading
        priority = 900, -- Lower priority than github theme
        config = function()
            require('kanagawa').setup({
                overrides = function(colors)
                    return {
                        DiffChange = { bg = '#2e2f28' },
                    }
                end,
            })
            -- vim.cmd([[colorscheme kanagawa-wave]])
        end,
    },
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd('colorscheme rose-pine')
        end,
    },
}
