return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      -- your configuration options here
      style = "storm", -- The theme comes in four styles: storm, moon, night, day
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
      },
    })
    
    -- Set colorscheme
    vim.cmd[[colorscheme tokyonight]]
  end,
}