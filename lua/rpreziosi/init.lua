local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Setup options first
require('rpreziosi.config.options').setup()
-- Setup keymaps
require('rpreziosi.config.keymaps').setup()

require('lazy').setup({
    spec = 'rpreziosi.plugins', 
    change_detection = { notify = false },
    rocks = { enabled = false }, -- Disable luarocks
})

-- Setup custom commands and functionality
require('rpreziosi.core.gitlab').setup()
