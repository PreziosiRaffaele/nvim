-- Configuration for GitLab CLI commands and keybindings
local M = {}
M.setup = function()
    -- Command to create a GitLab merge request from current branch to specified target branch
    vim.api.nvim_create_user_command('GitlabCreateMR', function()
        -- Get the current branch
        local source_branch = vim.fn.trim(vim.fn.system("git branch --show-current"))
        if vim.v.shell_error ~= 0 then
            vim.notify("Failed to get current branch", vim.log.levels.ERROR)
            return
        end

        -- Get list of available branches
        local branches = vim.fn.systemlist("git branch --format='%(refname:short)'")

        -- Make sure we have branches
        if vim.v.shell_error ~= 0 or #branches == 0 then
            vim.notify("Failed to get available branches", vim.log.levels.ERROR)
            return
        end

        -- Add 'main' to the top if it's not already there (common default)
        local has_main = false
        for _, branch in ipairs(branches) do
            if branch == "main" then
                has_main = true
                break
            end
        end

        if not has_main then
            table.insert(branches, 1, "main")
        else
            -- Move main to the top if it exists elsewhere in the list
            local main_index
            for i, branch in ipairs(branches) do
                if branch == "main" then
                    main_index = i
                    break
                end
            end
            if main_index and main_index > 1 then
                table.remove(branches, main_index)
                table.insert(branches, 1, "main")
            end
        end

        -- Present selection menu to user
        vim.ui.select(branches, {
            prompt = "Select target branch:",
            format_item = function(item)
                return item
            end
        }, function(selected)
            if not selected then
                vim.notify("No target branch selected", vim.log.levels.ERROR)
                return
            end
            
            local target_branch = selected
            print("Selected target branch: " .. target_branch)
            
            -- Create the MR using glab CLI with source branch name as the title
            local cmd = string.format(
                'glab mr create -w --fill -t "%s" -b %s -s %s',
                source_branch,
                target_branch,
                source_branch
            )

            -- Execute command in a job to avoid blocking the UI
            vim.fn.jobstart(cmd, {
                on_stdout = function(_, data)
                    if data and #data > 1 then
                        local output = table.concat(data, "\n")
                        vim.schedule(function()
                            vim.notify("Merge request created: \n" .. output, vim.log.levels.INFO)
                        end)
                    end
                end,
                on_stderr = function(_, data)
                    if data and #data > 1 then
                        local error_msg = table.concat(data, "\n")
                        -- Check if this is actually a non-error status message
                        if error_msg:match("Everything up%-to%-date") then
                            vim.schedule(function()
                                vim.notify("Merge request created successfully", vim.log.levels.INFO)
                            end)
                        else
                            vim.schedule(function()
                                vim.notify("Failed to create MR: \n" .. error_msg, vim.log.levels.ERROR)
                            end)
                        end
                    end
                end,
                stdout_buffered = true,
                stderr_buffered = true,
            })
        end)
    end, {
        nargs = 0,
        desc = "Create GitLab merge request from current branch"
    })

    -- Keymapping to create MR
    vim.keymap.set('n', '<leader>lm', function()
        vim.cmd('GitlabCreateMR')
    end, { desc = "Create GitLab merge request" })
end

return M
