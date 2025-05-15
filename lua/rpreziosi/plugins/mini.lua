return {
    {
        'echasnovski/mini.ai',
        version = '*',
        event = 'VeryLazy',
        dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
        opts = function()
            local ai = require('mini.ai')
            return {
                n_lines = 500,
                custom_textobjects = {
                    B = ai.gen_spec.treesitter({
                        a = { '@block.outer', '@conditional.outer', '@loop.outer' },
                        i = { '@block.inner', '@conditional.inner', '@loop.inner' },
                    }, {}),
                    f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }, {}),
                    C = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }, {}),
                    c = ai.gen_spec.treesitter({ a = '@comment.outer', i = '@comment.inner' }, {}),
                    a = ai.gen_spec.treesitter({ a = '@parameter.outer', i = '@parameter.inner' }),
                },
            }
        end,
        config = function(_, opts)
            require('mini.ai').setup(opts)
        end
    },
    {
        'echasnovski/mini.surround',
        version = '*',
        event = 'VeryLazy',
        config = function()
            require('mini.surround').setup( -- No need to copy this inside `setup()`. Will be used automatically.
                {
                    -- Add custom surroundings to be used on top of builtin ones. For more
                    -- information with examples, see `:h MiniSurround.config`.
                    custom_surroundings = nil,

                    -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
                    highlight_duration = 500,

                    -- Module mappings. Use `''` (empty string) to disable one.
                    mappings = {
                        add = 'ys',            -- Add surrounding in Normal and Visual modes
                        delete = 'yd',         -- Delete surrounding
                        find = 'yf',           -- Find surrounding (to the right)
                        find_left = 'yF',      -- Find surrounding (to the left)
                        highlight = 'yh',      -- Highlight surrounding
                        replace = 'yr',        -- Replace surrounding
                        update_n_lines = 'yn', -- Update `n_lines`

                        suffix_last = 'l', -- Suffix to search with "prev" method
                        suffix_next = 'n', -- Suffix to search with "next" method
                    },

                    -- Number of lines within which surrounding is searched
                    n_lines = 20,

                    -- Whether to respect selection type:
                    -- - Place surroundings on separate lines in linewise mode.
                    -- - Place surroundings on each line in blockwise mode.
                    respect_selection_type = false,

                    -- How to search for surrounding (first inside current line, then inside
                    -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
                    -- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
                    -- see `:h MiniSurround.config`.
                    search_method = 'cover',

                    -- Whether to disable showing non-error feedback
                    -- This also affects (purely informational) helper messages shown after
                    -- idle time if user input is required.
                    silent = false,
                })
        end
    }
}
