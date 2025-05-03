return {
    'xixiaofinland/sf.nvim',

    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'ibhagwan/fzf-lua', -- no need if you don't use listing metadata feature
    },

    -- Optional: lazy load this plugin when you open a file in a Salesforce project
    cond = function()
        local sf_project_files = vim.fs.find({ 'sfdx-project.json' }, { upward = true, type = 'file', limit = 1 })
        return #sf_project_files > 0
    end,

    config = function()
        require('sf').setup({
            code_sign_highlight = {
                covered = { fg = "#b7f071" }, -- set `fg = ""` to disable this sign icon
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
            plugin_folder_name = '.sfdx/sf_cache/',

            -- after the test running with code coverage completes, display uncovered line sign automatically.
            -- you can set it to `false`, then manually run toggle_sign command.
            auto_display_code_sign = false,
        }) -- Important to call setup() to initialize the plugin!


        -- Set keymaps
        local Sf = require('sf')
        vim.keymap.set("n", "<leader><leader>", Sf.toggle_term, { desc = "Terminal toggle" })
        vim.keymap.set("n", "<leader>ss", Sf.set_target_org, { desc = "Set target_org" })
        vim.keymap.set("n", "<leader>sd", Sf.diff_in_target_org, { desc = "Diff in target_org" })
        vim.keymap.set("n", "<leader>sD", Sf.diff_in_org, { desc = "Diff in org..." })
        vim.keymap.set("n", "<leader>sp", Sf.save_and_push, { desc = "Push current file" })
        vim.keymap.set("n", "<leader>sP",
            function() require('sf').run('sf project deploy start --ignore-conflicts -d ' .. vim.fn.expand('%:p')) end,
            { desc = "Push current file (Ignore Conflicts)" })
        vim.keymap.set("n", "<leader>sR",
            function() require('sf').run('sf project retrieve start --ignore-conflicts -d ' .. vim.fn.expand('%:p')) end,
            { desc = "Retrieve current file (Ignore Conflicts)" })

        vim.keymap.set("n", "<leader>sr", Sf.retrieve, { desc = "Retrieve current file" })
        vim.keymap.set("n", "<leader>so", Sf.org_open, { desc = "Open org" })
        -- Test related keymaps
        vim.keymap.set("n", "<leader>ta", Sf.run_all_tests_in_this_file, { desc = "Run all tests in this file" })
        vim.keymap.set("n", "<leader>tA", Sf.run_all_tests_in_this_file_with_coverage,
            { desc = "Run all test in this file with coverage" })
        vim.keymap.set("n", "<leader>tt", Sf.run_current_test, { desc = "Test this under cursor" })
        vim.keymap.set("n", "<leader>tT", Sf.run_current_test_with_coverage,
            { desc = "Test this under cursor with coverage info" })
        vim.keymap.set('n', '<leader>sg', function() require('sf').run('sf meta open -f ' .. vim.fn.expand('%:p')) end,
            { noremap = true, silent = true, desc = 'Open current file in UI' })
        vim.keymap.set('n', '<leader>se', function() require('sf').run('sf apex run -f ' .. vim.fn.expand('%:p')) end,
            { noremap = true, silent = true, desc = 'Execute Apex' })
        vim.keymap.set('n', '<leader>sl', Sf.pull_log, { desc = 'Pull logs' })
        --PMD issues
        -- vim.keymap.set('n', '<leader>si',
        --   function() require('sf').run('sf scanner run -f table --pmdconfig ./rules/RandstadPMDRules.xml -t ' ..
        --     vim.fn.expand('%:p')) end,
        --   { noremap = true, silent = true, desc = 'run pmd scanner with current file' })
    end
}
