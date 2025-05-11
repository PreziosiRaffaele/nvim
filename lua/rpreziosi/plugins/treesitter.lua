return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
        'nvim-treesitter/nvim-treesitter-context'
    },
    build = ':TSUpdate',
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = { "apex", "bash", "haskell", "nix", "rust", "soql", "sosl", "javascript", "typescript", "lua", "vim", "vimdoc", "markdown", "json", "jsonc", "html" },
            auto_install = true,

            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                },

                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                                 },

                swap = {
                    enable = true,

                },
            },
        })
    end,
}
