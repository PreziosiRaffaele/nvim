return {
    'nvimtools/none-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' }, -- Load early enough for format on save
    dependencies = { 'nvim-lua/plenary.nvim' },

    config = function()
        local null_ls = require('null-ls')
        local formatting = null_ls.builtins.formatting
        null_ls.setup({
            debug = false, -- Set to true for debugging
            sources = {
                formatting.prettier.with({
                    filetypes = {
                        'apex',
                        'trigger',
                        'xml',
                        'html',
                        'lwc',
                    },
                }),
                formatting.stylua,
            },
        })
    end,
}
