return {
    'tpope/vim-fugitive',
    config = function()
        vim.keymap.set('n', '<leader>gc', ':Git commit<CR>', { desc = "Git commit" })
        vim.keymap.set('n', '<leader>gP', ':Git push<CR>', { desc = "Git push" })
        vim.keymap.set('n', '<leader>gp', ':Git pull --quiet<CR>', { desc = "Git pull" })
        vim.keymap.set('n', '<leader>gf', ':Git fetch <CR>', { desc = "Git fetch" })
        vim.keymap.set('n', '<leader>grs', ':Git reset --soft HEAD~1<CR>', { desc = "Git reset soft (keep staged)" })
        vim.keymap.set('n', '<leader>gF', ':Git push --force<CR>', { desc = "Git force push" })
        vim.keymap.set('n', '<leader>gA', ':Git commit --amend<CR>', { desc = "Git amend commit" })
        vim.keymap.set('n', '<leader>gC', ':Git checkout -b ', { desc = "Create new branch" }) -- Type new branch name
        vim.keymap.set('n', '<leader>ra', function()
            vim.ui.select({ 'Yes', 'No' }, {
                prompt = 'Are you sure you want to restore all files?',
            }, function(choice)
                if choice == 'Yes' then
                    vim.cmd('Git restore .')
                end
            end)
        end, { desc = "Git restore all (with confirmation)" })
        vim.keymap.set('n', '<leader>rf', function()
            vim.ui.select({ 'Yes', 'No' }, {
                prompt = 'Are you sure you want to restore the current file?',
            }, function(choice)
                if choice == 'Yes' then
                    vim.cmd('Git restore %')
                end
            end)
        end, { desc = "Git restore current file (with confirmation)" })
        vim.keymap.set('n', '<leader>gx', function()
            vim.ui.select({ 'Yes', 'No' }, {
                prompt = 'Are you sure you want to clean untracked files?',
            }, function(choice)
                if choice == 'Yes' then
                    vim.cmd('Git clean -fd')
                end
            end)
        end, { desc = "Git clean (with confirmation)" })
        -- Custom command to find the first merge of a commit SHA into a branch
        vim.api.nvim_create_user_command('GitFirstMerge', function(opts)
            local sha = opts.fargs[1]
            -- If no branch is specified, get the current branch
            local branch
            if opts.fargs[2] then
                branch = opts.fargs[2]
            else
                branch = vim.fn.trim(vim.fn.system("git branch --show-current"))
                if vim.v.shell_error ~= 0 then
                    branch = "main" -- Fallback to main if current branch detection fails
                    vim.notify("Couldn't detect current branch, using 'main'", vim.log.levels.WARN)
                end
            end

            local cmd = string.format(
                "git log %s --merges --ancestry-path --reverse --pretty=format:'%%h %%as %%an: %%s' %s^..%s | head -n 1",
                branch, sha, branch
            )

            -- Execute command and show result
            local output = vim.fn.system(cmd)
            if output and output ~= "" then
                vim.notify("First merge into " .. branch .. ":\n" .. output, vim.log.levels.INFO)
            else
                vim.notify("No merge found in " .. branch, vim.log.levels.WARN)
            end
        end, {
            nargs = "+",
            complete = function(ArgLead, CmdLine, CursorPos)
                -- Return recent commit SHAs for auto-completion
                local commits = vim.fn.systemlist("git log --pretty=format:'%h' -n 30")
                local results = {}
                for _, commit in ipairs(commits) do
                    if commit:find(ArgLead) == 1 then
                        table.insert(results, commit)
                    end
                end
                return results
            end,
            desc = "Find the first merge of a commit SHA into a branch"
        })

        -- Manual input for commit SHA for GitFirstMerge
        vim.keymap.set('n', '<leader>dF', function()
            vim.ui.input({
                prompt = 'Enter commit SHA: ',
                completion = 'custom,v:lua.GitFirstMergeCommitComplete',
            }, function(sha)
                if sha and sha ~= "" then
                    vim.cmd('GitFirstMerge ' .. sha)
                end
            end)
        end, { desc = "Find first merge of commit SHA (manual input)" })

        -- Make commit completion function available globally
        _G.GitFirstMergeCommitComplete = function()
            return table.concat(vim.fn.systemlist("git log --pretty=format:'%h' -n 30"), "\n")
        end
    end
}
