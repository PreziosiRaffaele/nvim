return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make'
    }
  },
  config = function()
    require("telescope").setup({
      pickers = {
        find_files = {
          theme = "ivy",
        },
        live_grep = {
          theme = "ivy",
        },
        grep_string = {
          theme = "ivy",
        },
        git_commits = {
          theme = "ivy",
        },
        git_bcommits = {
          theme = "ivy",
        },
        git_status = {
          theme = "ivy",
        },
        help_tags = {
          theme = "ivy",
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,               -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case",
        },
      },
    })
    require("telescope").load_extension("fzf")
    -- Set keymaps
    vim.keymap.set("n", "<leader>fv", "<cmd>Telescope git_bcommits<cr>", { desc = "Git BCommits" })
    vim.keymap.set("n", "<leader>fc", "<cmd>Telescope git_commits<cr>", { desc = "Git Commits" })
    vim.keymap.set("n", "<leader>fs", "<cmd>Telescope git_status<cr>", { desc = "Git Status" })
    vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
    vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
    vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
    vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })
    vim.keymap.set("n", "<leader>faf", "<cmd>Telescope find_files hidden=true no_ignore=true<cr>", { desc = "Find all files" })
    vim.keymap.set("n", "<leader>fn", function()
      require("telescope.builtin").find_files {
        cwd = vim.fn.stdpath("config"),
      }
    end, { desc = "Find files in nvim config" })
  end,
}
