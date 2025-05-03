return {
  config = function()
    -- Function to format files using Prettier (only if a Prettier config exists)
    local function format_with_prettier()
      local bufnr = vim.api.nvim_get_current_buf()
      local filepath = vim.api.nvim_buf_get_name(bufnr)
      local root_dir = require("lspconfig.util").root_pattern(
      ".prettierrc",
      ".prettierrc.js",
      ".prettierrc.json",
      ".prettierrc.yml",
      ".prettierrc.yaml",
      "prettier.config.js",
      "prettier.config.cjs",
      "package.json"
      )(filepath)

      if not root_dir then
        print("Prettier: No configuration file found in the project root")
        return
      end

      local cmd = string.format("prettier --write %s", filepath)

      vim.fn.jobstart(cmd, {
        stdout_buffered = true,
        stderr_buffered = true, -- Capture error output
        on_stdout = function(_, data)
          if data then
            print("Prettier stdout: " .. table.concat(data, "\n"))
          end
        end,
        on_stderr = function(_, data)
          if data then
            print("Prettier stderr: " .. table.concat(data, "\n"))
          end
        end,
        on_exit = function(_, code)
          if code == 0 then
            print("Prettier: File formatted successfully")
            vim.cmd("edit!") -- Reload the buffer to reflect changes
          else
            print("Prettier: Failed to format file. Check stderr for details.")
          end
        end,
      })
    end    -- Keybinding to format with Prettier
    
    vim.keymap.set("n", "<leader>p", format_with_prettier, { desc = "Format with Prettier" })
  end,
}

