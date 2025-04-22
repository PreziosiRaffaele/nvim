return {
    {
        'goolord/alpha-nvim',
        config = function()
            math.randomseed(os.time())

            local alpha = require 'alpha'
            local dashboard = require 'alpha.themes.dashboard'

            -- Function to center quotes
            local function center_quote(quote)
                local max_width = 0
                for _, str in ipairs(quote) do
                    max_width = math.max(max_width, #str)
                end

                local centered_strings = {}
                for _, str in ipairs(quote) do
                    local leading_spaces = math.floor((max_width - #str) / 2)
                    local trailing_spaces = max_width - leading_spaces - #str
                    local centered_str = string.rep(' ', leading_spaces) .. str .. string.rep(' ', trailing_spaces)
                    table.insert(centered_strings, centered_str)
                end

                -- Insert blank strings at start of table yea ik its scuffed
                table.insert(centered_strings, 1, '')
                table.insert(centered_strings, 1, '')
                return centered_strings
            end

            Headers = {
                {
                    [[                                                                     ]],
                    [[       ███████████           █████      ██                     ]],
                    [[      ███████████             █████                             ]],
                    [[      ████████████████ ███████████ ███   ███████     ]],
                    [[     ████████████████ ████████████ █████ ██████████████   ]],
                    [[    █████████████████████████████ █████ █████ ████ █████   ]],
                    [[  ██████████████████████████████████ █████ █████ ████ █████  ]],
                    [[ ██████  ███ █████████████████ ████ █████ █████ ████ ██████ ]],
                    [[ ██████   ██  ███████████████   ██ █████████████████ ]],
                    [[ ██████   ██  ███████████████   ██ █████████████████ ]],
                },
                {
                    "                                                     ",
                    "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
                    "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
                    "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
                    "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
                    "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
                    "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
                    "                                                     ",
                },

                {
                    [[                               __                ]],
                    [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
                    [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
                    [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
                    [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
                    [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
                },
            }

            -- Set header
            dashboard.section.header.val = Headers[2]

            -- Import programming quotes from the quotes file
            local programming_quotes = require('rpreziosi.quotes')

            -- Select a random quote and format it with author
            local random_quote = programming_quotes[math.random(#programming_quotes)]
            local quote_with_author = {
                random_quote.quote,
                "— " .. random_quote.author
            }

            -- Set quote with author as footer
            dashboard.section.footer.val = center_quote(quote_with_author)

            -- Set menu
            dashboard.section.buttons.val = {
                dashboard.button('f', '  > Find file', ':Telescope find_files<CR>'),
                dashboard.button('r', '  > Recent files', ':Telescope oldfiles<CR>'),
                dashboard.button('s', '  > Settings', function()
                    require("telescope.builtin").find_files {
                        cwd = vim.fn.stdpath("config"),
                    }
                end
                ),
                dashboard.button('q', '  > Quit NVIM', ':qa<CR>'),
            }

            -- Send config to alpha
            alpha.setup(dashboard.opts)

            -- Disable folding on alpha buffer
            vim.cmd [[
          autocmd FileType alpha setlocal nofoldenable
      ]]
        end,
    },
}
