return {
    {
        "zbirenbaum/copilot.lua",
        event = "InsertEnter",
        opts = {
            suggestion = {
                enabled = true,
                auto_trigger = true,
                keymap = {
                    -- Mac-friendly keybindings using Ctrl instead of Alt/Option
                    accept = "<C-j>",      -- Ctrl+Enter to accept suggestion
                    accept_word = "<C-k>", -- Ctrl+K to accept word
                    next = "<C-]>",        -- Ctrl+N for next suggestion
                    prev = "<C-[>",        -- Ctrl+P for previous suggestion
                    dismiss = "<C-\\>",     -- Ctrl+E to dismiss suggestion
                },
            },
            panel = {
                enabled = true, -- disable the Copilot panel
            },
        },
    },
}
