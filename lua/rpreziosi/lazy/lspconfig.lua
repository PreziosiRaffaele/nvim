return {
  "neovim/nvim-lspconfig",
  dependencies = { "hrsh7th/cmp-nvim-lsp" },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    -- Enable LSP capabilities for autocompletion
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Apex Language Server configuration
    lspconfig.apex_ls.setup({ 
      cmd = { "apex-jorje-lsp" }, -- Path to the Apex Language Server executable
      filetypes = { "apex", "soql", "trigger" },     -- Filetypes to associate with the server
      root_dir = lspconfig.util.root_pattern(".git", "sfdx-project.json"), -- Root directory
      settings = {},              -- Additional settings if needed
      capabilities = capabilities, -- Add capabilities for autocompletion
    })

    -- General LSP keybindings
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
    vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Find references" })
    vim.keymap.set("n", "<leader>f", function()
      vim.lsp.buf.format({ async = true })
    end, { desc = "Format document" })
  end,
}
