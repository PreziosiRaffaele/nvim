return {
  "sindrets/diffview.nvim",
  config = function()
    require("diffview").setup({
    })
    vim.api.nvim_set_keymap("n", "<leader>do", ":DiffviewOpen<CR>", { desc = "Open DiffView" })
    vim.api.nvim_set_keymap("n", "<leader>dc", ":DiffviewClose<CR>", { desc = "Close DiffView" })
    -- File history
    vim.api.nvim_set_keymap("n", "<leader>df", ":DiffviewFileHistory --no-merges --max-count=60 %<CR>",
      { desc = "Git File History (NO MERGES)" })
    vim.api.nvim_set_keymap("n", "<leader>dr", ":DiffviewFileHistory --max-count=60 %<CR>",
      { desc = "Git File History" })
    vim.api.nvim_set_keymap("n", "<leader>dh", ":DiffviewFileHistory --no-merges --max-count=1000<CR>",
      { desc = "Git Current Directory History (NO MERGES)" })
    vim.api.nvim_set_keymap("n", "<leader>dl", ":DiffviewFileHistory --max-count=1000<CR>",
      { desc = "Git Current Directory History" })
    vim.api.nvim_set_keymap("n", "<leader>ds", ":DiffviewFileHistory -g --range=stash<CR>",
      { desc = "Git Stash History" })

    -- Custom function to list commits by author
    vim.api.nvim_create_user_command('DiffviewFileHistoryByAuthor', function()
      -- Get list of authors from git
      local authors = vim.fn.systemlist("git log --pretty='%an <%ae>' | sort -u")

      -- Remove duplicates
      local unique_authors = {}
      local seen = {}
      for _, author in ipairs(authors) do
        if not seen[author] then
          table.insert(unique_authors, author)
          seen[author] = true
        end
      end

      -- Let user select an author
      vim.ui.select(unique_authors, {
        prompt = "Select author to filter by:",
        format_item = function(item)
          return item
        end
      }, function(author)
        if author then
          -- Extract the email part from "Name <email>" format
          local email = author:match("<%s*(.-)%s*>")
          local name = author:match("^(.-)%s*<")

          local filter
          if email then
            filter = string.format('--author="%s"', email)
          else
            filter = string.format('--author="%s"', author)
          end

          local cmd = string.format(":DiffviewFileHistory %s --no-merges --max-count=200<CR>", filter)
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(cmd, true, false, true), "n", true)

          -- Notify user about the selected author
          vim.notify("Showing commits by " .. (name or author), vim.log.levels.INFO)
        end
      end)
    end, { desc = "Show file history filtered by author" })

    -- Ad keymap for the new command
    vim.api.nvim_set_keymap("n", "<leader>da", ":DiffviewFileHistoryByAuthor<CR>",
      { desc = "Search commits by Author" })
    -- Custom function to filter commits by message content
    vim.api.nvim_create_user_command('DiffviewFileHistoryByMessage', function()
      vim.ui.input({
        prompt = "Enter commit message search term: ",
      }, function(input)
        if input and input ~= "" then
          local cmd = string.format(":DiffviewFileHistory --grep=\"%s\" --no-merges --max-count=200<CR>", input)
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(cmd, true, false, true), "n", true)
          -- Notify user about the search term
          vim.notify("Showing commits containing: " .. input, vim.log.levels.INFO)
        end
      end)
    end, { desc = "Show file history filtered by commit message" })
    -- Add keymap for the commit message search
    vim.api.nvim_set_keymap("n", "<leader>dm", ":DiffviewFileHistoryByMessage<CR>",
      { desc = "Search commits by message" })
  end,
}
