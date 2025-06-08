return {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
    config = function()
        local lspconfig = require("lspconfig")
        local blink_cmp = require("blink.cmp")
        -- Enable LSP capabilities for autocompletion
        local capabilities = blink_cmp.get_lsp_capabilities()

        -- Apex Language Server configuration
        lspconfig.apex_ls.setup({
            cmd = { "apex-jorje-lsp" },
            filetypes = { "apex", "soql", "trigger" },
            root_dir = lspconfig.util.root_pattern(".git", "sfdx-project.json"),
            settings = {},
            apex_enable_semantic_errors = false,
            apex_enable_completion_statistics = false,
            capabilities = capabilities,
        })

        -- Javascript/Typescript Language Server configuration
        lspconfig.ts_ls.setup({
            filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
            root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
            capabilities = capabilities,
        })

        -- EsLint Language Server configuration
        lspconfig.eslint.setup({
            filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
            root_dir = lspconfig.util.root_pattern(".eslintrc", ".eslintrc.js", ".eslintrc.json", ".eslintrc.cjs"),
            capabilities = capabilities,
        })

        -- HTML Language Server configuration
        lspconfig.html.setup({
            filetypes = { "html" },
            capabilities = capabilities,
        })

        -- LUA Language Server configuration
        lspconfig.lua_ls.setup {
            capabilities = capabilities,
            filetypes = { "lua" },
        }

        -- CSS Language Server configuration
        lspconfig.cssls.setup({
            filetypes = { "css", "scss", "less" },
            capabilities = capabilities,
        })

        -- JSON Language Server configuration
        lspconfig.jsonls.setup({
            filetypes = { "json", "jsonc" },
            capabilities = capabilities,
        })

        -- C Language Server configuration (clangd)
        lspconfig.clangd.setup({
            filetypes = { "c", "cpp", "objc", "objcpp" },
            cmd = { "clangd", "--background-index" },
            capabilities = capabilities,
        })

        -- General LSP keybindings
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
        vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Find references" })
        vim.keymap.set("n", "<leader>fd", vim.lsp.buf.format, { desc = "Format document" })
    end,
}
