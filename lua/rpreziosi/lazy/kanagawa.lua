return {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("kanagawa").setup({
            overrides = function(colors)
                return {
                    DiffChange = { bg = "#2e2f28" },       -- muted yellow-brown
                }
            end                                            -- You can customize the theme here
        })
        vim.cmd([[colorscheme kanagawa-wave]])
    end,
}
