return {
    'PreziosiRaffaele/apex-log-analyzer.nvim',
    -- Dependencies required by the plugin
    dependencies = { 'nvim-lua/plenary.nvim' },

    -- Lazy-load the plugin when the ApexLogTree command is executed
    cmd = 'ApexLogTree',
    keys = {
        { '<leader>lt', '<cmd>ApexLogTree<cr>', desc = 'Apex Log Tree' },
    },

    -- This function runs after the plugin is loaded
    config = function()
        -- This calls the setup function in your plugin, which creates the command
        require('apex-log-analyzer').setup()
    end,
}
