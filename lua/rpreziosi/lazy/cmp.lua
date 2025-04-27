return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
    "hrsh7th/cmp-buffer",   -- Buffer source for nvim-cmp
    "hrsh7th/cmp-path",     -- Path source for nvim-cmp
    "hrsh7th/cmp-cmdline",  -- Command-line source for nvim-cmp
    "L3MON4D3/LuaSnip",     -- Snippet engine
    "saadparwaiz1/cmp_luasnip", -- Snippet source for nvim-cmp
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-a>"] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
      }, {
        { name = "buffer" },
        { name = "path" },
      }),
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
    })
    -- Use buffer source for `/` and `?`
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    -- Use cmdline & path source for `:`
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
    })
  end,
}
