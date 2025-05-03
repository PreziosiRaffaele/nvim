return {
  'mfussenegger/nvim-lint',
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require('lint')
    -- Define the PMD linter for Apex files
    lint.linters.pmd = {
      cmd = 'pmd',
      stdin = false,
      args = {
        "check",
        "--format", "json",
        "--rulesets", 'rules/RandstadPMDRules.xml',
        "--dir", "%filepath",
      },
      ignore_exitcode = true,
      parser = function(output, linter_bufnr)
        local diagnostics = {}
        if not output then
          return diagnostics
        end
        local decoded = vim.json.decode(output) or {}
        local files = decoded.files or {}
        for _, file in ipairs(files) do
          local file_path = file.filename
          -- Convert relative path to absolute if needed
          if not file_path:match("^/") then
            file_path = vim.fn.fnamemodify(file_path, ":p")
          end
          local file_bufnr = vim.uri_to_bufnr(vim.uri_from_fname(file_path))
          if linter_bufnr == file_bufnr then
            for _, violation in ipairs(file.violations) do
              print(violation)
              local code = violation.ruleset .. "/" .. violation.rule
              table.insert(diagnostics, {
                source = "pmd",
                lnum = violation.beginline - 1,
                col = violation.begincolumn - 1,
                end_lnum = violation.end_lnum and violation.end_lnum - 1,
                end_col = violation.endcolumn and violation.endcolumn - 1,
                code = code,
                message = violation.description,
                severity = violation.priority and math.max(1, violation.priority - 1),
                bufnr = file_bufnr,
                user_data = {
                  lsp = {
                    code = code,
                  },
                  url = violation.externalInfoUrl,
                },
              })
            end
          end
        end

        return diagnostics
      end,
    }

    -- Assign the linter to filetypes
    lint.linters_by_ft = {
      apex = { 'pmd' },
    }

    -- Auto-run linting
    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
      group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
