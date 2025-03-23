return {
  'xixiaofinland/sf.nvim',

  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'ibhagwan/fzf-lua', -- no need if you don't use listing metadata feature
  },

  config = function()
    require('sf').setup({
      code_sign_highlight = {
        covered = { fg = "#b7f071" },   -- set `fg = ""` to disable this sign icon
        uncovered = { fg = "#f07178" }, -- set `fg = ""` to disable this sign icon
      },
      hotkeys_in_filetypes = {
        "apex", "sosl", "soql", "javascript", "html"
      },
      types_to_retrieve = {
        "ApexClass",
        "ApexTrigger",
        "StaticResource",
        "LightningComponentBundle"
      },
      -- the folder this plugin uses to store intermediate data. It's under the sf project root directory.
      plugin_folder_name = '/sf_cache/',

      -- after the test running with code coverage completes, display uncovered line sign automatically.
      -- you can set it to `false`, then manually run toggle_sign command.
      auto_display_code_sign = true,
    }) -- Important to call setup() to initialize the plugin!


    -- Set keymaps
    local Sf = require('sf')
    vim.keymap.set("n", "<leader><leader>", Sf.toggle_term, { desc = "terminal toggle" })
    vim.keymap.set("n", "<leader>ss", Sf.set_target_org, { desc = "set target_org" })
    vim.keymap.set("n", "<leader>sd", Sf.diff_in_target_org, { desc = "diff in target_org" })
    vim.keymap.set("n", "<leader>sD", Sf.diff_in_org, { desc = "diff in org..." })
    vim.keymap.set("n", "<leader>sp", Sf.save_and_push, { desc = "push current file" })
    vim.keymap.set("n", "<leader>sfp", function() require('sf').run('sf project deploy start --ignore-conflicts -d ' .. vim.fn.expand('%:p')) end,
      { desc = "push current file ignore conflicts" })
    vim.keymap.set("n", "<leader>sr", Sf.retrieve, { desc = "retrieve current file" })
    vim.keymap.set("n", "<leader>so", Sf.org_open, { desc = "open org" })
    -- Test related keymaps
    vim.keymap.set("n", "<leader>ts", Sf.toggle_sign, { desc = "toggle signs for code coverage" })
    vim.keymap.set("n", "<leader>ta", Sf.run_all_tests_in_this_file, { desc = "run all tests in this file" })
    vim.keymap.set("n", "<leader>tA", Sf.run_all_tests_in_this_file_with_coverage,
      { desc = "run all test in this file with coverage" })
    vim.keymap.set("n", "<leader>tt", Sf.run_current_test, { desc = "test this under cursor" })
    vim.keymap.set("n", "<leader>tT", Sf.run_current_test_with_coverage,
      { desc = "test this under cursor with coverage info" })
    vim.keymap.set('n', '<leader>sg', function() require('sf').run('sf meta open -f ' .. vim.fn.expand('%:p')) end,
      { noremap = true, silent = true, desc = 'run meta open with current file' })
    vim.keymap.set('n', '<leader>se', function() require('sf').run('sf apex run -f ' .. vim.fn.expand('%:p')) end,
      { noremap = true, silent = true, desc = 'execute apex script' })
    --PMD issues
    vim.keymap.set('n', '<leader>si', function() require('sf').run('sf scanner run -f table --pmdconfig ./rules/RandstadPMDRules.xml -t ' .. vim.fn.expand('%:p')) end,
      { noremap = true, silent = true, desc = 'run pmd scanner with current file' })


    end
}
