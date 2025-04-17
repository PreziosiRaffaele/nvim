return {
    "rebelot/kanagawa.nvim",
    lazy = true, -- Changed from false to true to disable auto-loading
    priority = 900, -- Lower priority than github theme
    config = function()
        require("kanagawa").setup({
            overrides = function(colors)
                return {
                    DiffChange = { bg = "#2e2f28" },       -- muted yellow-brown
                }
            end                                            -- You can customize the theme here
        })
        -- vim.cmd([[colorscheme kanagawa-wave]]) -- Commented out to not set as default
    end,
}
