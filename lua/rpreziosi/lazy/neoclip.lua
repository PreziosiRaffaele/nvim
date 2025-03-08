return {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
        {"nvim-telescope/telescope.nvim"},
    },
    config = function()
        require('neoclip').setup()
        
        -- Optional telescope extension
        require('telescope').load_extension('neoclip')
    end,
}