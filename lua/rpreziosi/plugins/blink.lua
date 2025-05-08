return {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',

    version = 'v0.*',

    opts = {
        keymap = { preset = 'default' },
        completion = {
            list = { selection = { preselect = false, auto_insert = false } },
            menu = { border = 'single' },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 500,
                window = { border = 'single' },
            },
        },

        appearance = {
            nerd_font_variant = 'mono',
        },

        signature = { enabled = true },
    },
}
