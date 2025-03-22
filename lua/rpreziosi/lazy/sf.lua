return {
  'PreziosiRaffaele/sf.nvim',

  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'ibhagwan/fzf-lua', -- no need if you don't use listing metadata feature
  },

  config = function()
    require('sf').setup()  -- Important to call setup() to initialize the plugin!


    -- Set keymaps
    local Sf = require('sf')
    vim.keymap.set("n", "<leader><leader>", Sf.toggle_term, { desc = "terminal toggle" })
    vim.keymap.set("n", "<leader>ss", Sf.set_target_org, { desc = "set target_org" })
    vim.keymap.set("n", "<leader>sd", Sf.diff_in_target_org, { desc = "diff in target_org" })
    vim.keymap.set("n", "<leader>sD", Sf.diff_in_org, { desc = "diff in org..." })
    vim.keymap.set("n", "<leader>sp", Sf.save_and_push, { desc = "push current file" })
    vim.keymap.set("n", "<leader>sr", Sf.retrieve, { desc = "retrieve current file" })
    vim.keymap.set("n", "<leader>so", Sf.org_open, { desc = "open org" })
    -- Test related keymaps
    vim.keymap.set("n", "<leader>ts", Sf.toggle_sign, { desc = "toggle signs for code coverage" })
    vim.keymap.set("n", "<leader>ta", Sf.run_all_tests_in_this_file, { desc = "run all tests in this file" })
    vim.keymap.set("n", "<leader>tA", Sf.run_all_tests_in_this_file_with_coverage, { desc = "run all test in this file with coverage" })
    vim.keymap.set("n", "<leader>tt", Sf.run_current_test, { desc = "test this under cursor" })
    vim.keymap.set("n", "<leader>tT", Sf.run_current_test_with_coverage, { desc = "test this under cursor with coverage info" })
  end
}
