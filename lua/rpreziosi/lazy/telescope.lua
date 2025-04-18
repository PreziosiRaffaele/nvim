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
                    git_command = { "git", "log", "--pretty=format:%h %s (%an) (%cr)" },
                },
                buffers = {
                    sort_lastused = true,
                    ignore_current_buffer = true,
                    mappings = {
                        i = {
                            ["<C-d>"] = require('telescope.actions').delete_buffer,
                        },
                    },
                },
                git_bcommits = {
                    theme = "ivy",
                    git_command = { "git", "log", "--pretty=format:%h %s (%an) (%cr)" },
                },
                git_status = {
                    theme = "ivy",
                },
                help_tags = {
                    theme = "ivy",
                },
                git_stash = {
                    theme = "ivy",
                    mappings = {
                        i = {
                            ["<cr>"] = function(prompt_bufnr)
                                local actions = require("telescope.actions")
                                local action_state = require("telescope.actions.state")
                                local selection = action_state.get_selected_entry()

                                -- Get the stash index and message for better identification
                                local stash_idx = selection.value
                                local stash_msg = selection.commit_info

                                -- Close Telescope first
                                actions.close(prompt_bufnr)

                                -- Ask user if they want to apply or pop the stash
                                vim.ui.select(
                                    { "Apply", "Apply and remove (Pop)", "Cancel" },
                                    { prompt = "How to apply stash " .. stash_msg .. "?" },
                                    function(choice)
                                        if choice == "Apply" then
                                            -- Apply the stash (keep it in stash list)
                                            vim.fn.system("git stash apply " .. stash_idx)
                                            vim.notify("Applied stash: " .. stash_msg, vim.log.levels.INFO)
                                        elseif choice == "Apply and remove (Pop)" then
                                            -- Pop the stash (remove it from stash list)
                                            vim.fn.system("git stash pop " .. stash_idx)
                                            vim.notify("Popped stash: " .. stash_msg, vim.log.levels.INFO)
                                        else
                                            vim.notify("Stash application cancelled", vim.log.levels.INFO)
                                        end
                                    end
                                )
                            end,
                            ["<C-x>"] = function(prompt_bufnr)
                                local actions = require("telescope.actions")
                                local action_state = require("telescope.actions.state")
                                local selection = action_state.get_selected_entry()

                                -- Get the stash index and message for better identification
                                local stash_idx = selection.value

                                -- Close Telescope first
                                actions.close(prompt_bufnr)

                                local stash_msg = selection.commit_info

                                -- Ask for confirmation before deleting
                                vim.ui.select(
                                    { "Yes", "No" },
                                    { prompt = "Delete stash " .. stash_msg .. "?" },
                                    function(choice)
                                        if choice == "Yes" then
                                            -- Delete the stash
                                            vim.fn.system("git stash drop " .. stash_idx)

                                            -- Notify user
                                            vim.notify("Deleted stash: " .. stash_msg, vim.log.levels.INFO)
                                        else
                                            vim.notify("Stash deletion cancelled", vim.log.levels.INFO)
                                        end

                                        -- Always refresh the picker to update the stash list
                                        vim.defer_fn(function()
                                            require('telescope.builtin').git_stash()
                                        end, 100)
                                    end
                                )
                            end,
                        },
                    },
                },
                diagnostics = {
                    theme = "ivy",
                },
                git_branches = {
                    theme = "dropdown",
                    previewer = false,
                    mappings = {
                        i = {
                            ["<cr>"] = function(prompt_bufnr)
                                local actions = require("telescope.actions")
                                local action_state = require("telescope.actions.state")
                                local selection = action_state.get_selected_entry()

                                -- Close Telescope first
                                actions.close(prompt_bufnr)

                                -- Ensure the selected branch is checked out properly
                                local branch_name = selection.value
                                if branch_name:match("origin/") then
                                    -- It's a remote branch, create a local tracking branch
                                    local local_branch = branch_name:gsub("origin/", "")
                                    vim.cmd("Git checkout -b " .. local_branch .. " " .. branch_name)
                                else
                                    -- Just checkout normally if it's a local branch
                                    vim.cmd("Git checkout " .. branch_name)
                                end
                            end,
                        },
                    },
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,                   -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true,    -- override the file sorter
                    case_mode = "ignore_case",      -- or "smart_case" or "respect_case"
                },
            },
        })
        require("telescope").load_extension("fzf")
        -- Set keymaps
        vim.keymap.set("n", "<leader>fr", "<cmd>Telescope registers<cr>", { desc = "Telescope registers" })
        -- vim.keymap.set("n", "<leader>fc", "<cmd>Telescope git_commits<cr>", { desc = "Git Commits" })
        vim.keymap.set("n", "<leader>gsl", "<cmd>Telescope git_stash<cr>", { desc = "Git Stash List" })
        vim.keymap.set("n", "<leader>td", "<cmd>Telescope diagnostics<cr>", { desc = "Diagnostics" })
        vim.keymap.set("n", "<leader>fs", "<cmd>Telescope git_status<cr>", { desc = "Git Status" })
        vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
        vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
        vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
        vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })
        vim.keymap.set("n", "<leader>gm", "<cmd>Telescope git_branches<cr>", { desc = "Git branches" })
        vim.keymap.set("n", "<leader>ft", "<cmd>Telescope colorscheme<cr>", { desc = "Color scheme" })
        vim.keymap.set("n", "<leader>faf", "<cmd>Telescope find_files hidden=true no_ignore=true<cr>",
            { desc = "Find all files" })
        vim.keymap.set("n", "<leader>fn", function()
            require("telescope.builtin").find_files {
                cwd = vim.fn.stdpath("config"),
            }
        end, { desc = "Find files in nvim config" })
    end,
}
