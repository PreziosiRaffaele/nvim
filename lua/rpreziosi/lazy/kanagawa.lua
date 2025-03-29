return {
  "rebelot/kanagawa.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("kanagawa").setup({
      -- You can customize the theme here
    })
    vim.cmd([[colorscheme kanagawa-wave]])
  end,
}
