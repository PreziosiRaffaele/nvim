return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("nvim-treesitter.configs").setup({
      -- A list of parser names, or "all" (the installed parsers)
      ensure_installed = { 
        "lua", "vim", "vimdoc", "query",
        "javascript", "typescript", "python", "bash",
        "markdown", "markdown_inline", "json", "yaml", 
        "java", -- Add Java parser for Apex files
      },
      
      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,
      
      -- Automatically install missing parsers when entering buffer
      auto_install = true,
      
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      
      indent = { enable = true },
      
      -- Incremental selection based on the named nodes from the grammar
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = "<C-s>",
          node_decremental = "<M-space>",
        },
      },
    })
    
    -- Set filetype detection for Apex files to use Java parser
    vim.filetype.add({
      extension = {
        cls = "java", -- Treat .cls files as Java for syntax highlighting
        trigger = "java",
        apex = "java",
      },
    })
  end,
}
