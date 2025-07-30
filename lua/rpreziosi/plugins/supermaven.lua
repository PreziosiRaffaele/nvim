return {
    'supermaven-inc/supermaven-nvim',
    config = function()
        require('supermaven-nvim').setup({
            keymaps = {
                accept_suggestion = '<C-j>',
                clear_suggestion = '<C-]>',
                accept_word = '<C-k>',
            },
            ignore_filetypes = { cpp = true, env = true }, -- or { "cpp", }
            color = {
                suggestion_color = '#808080',
                cterm = 244,
            },
            log_level = 'info', -- set to "off" to disable logging completely
            disable_inline_completion = false, -- disables inline completion for use with cmp
            disable_keymaps = false, -- disables built in keymaps for more manual control
            condition = function()
                return false
            end, -- condition to check for stopping supermaven, `true` means to stop supermaven when the condition is true.
        })
    end,
    vim.keymap.set('n', '<leader>st', function()
        vim.cmd('SupermavenToggle')
        vim.defer_fn(function()
            local supermaven_api = require('supermaven-nvim.api')
            local is_running = supermaven_api.is_running()
            local status = is_running and 'ENABLED ✓' or 'DISABLED ✗'
            local color = is_running and vim.log.levels.INFO or vim.log.levels.WARN
            vim.notify('Supermaven: ' .. status, color)
        end, 100)
    end, { desc = 'Supermaven Toggle' }),
}
