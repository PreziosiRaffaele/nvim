return {
    'ibhagwan/fzf-lua',
    config = function()
        local actions = require('fzf-lua.actions')
        require('fzf-lua').setup({
            winopts = {
                fullscreen = true,
            },
            keymap = {
                builtin = {
                    true,
                    ['<C-d>'] = 'preview-page-down',
                    ['<C-u>'] = 'preview-page-up',
                },
                fzf = {
                    true,
                    ['ctrl-d'] = 'preview-page-down',
                    ['ctrl-u'] = 'preview-page-up',
                    ['ctrl-q'] = 'select-all+accept',
                },
            },
            actions = {
                files = {
                    ['enter'] = actions.file_edit_or_qf,
                    ['ctrl-x'] = actions.file_split,
                    ['ctrl-v'] = actions.file_vsplit,
                    ['ctrl-t'] = actions.file_tabedit,
                    ['alt-q'] = actions.file_sel_to_qf,
                },
            },
            buffers = {
                keymap = { builtin = { ['<C-d>'] = false } },
                actions = { ['ctrl-x'] = false, ['ctrl-d'] = { actions.buf_del, actions.resume } },
            },
            git = {
                -- Ignore merge commits by default
                commits = {
                    cmd = [[git log --color --no-merges --pretty=format:"%C(yellow)%h%Creset ]]
                        .. [[%Cgreen(%><(12)%cr%><|(12))%Creset %s %C(blue)<%an>%Creset"]],
                },
                -- Ignore merge commits by default
                bcommits = {
                    cmd = [[git log --color --no-merges --pretty=format:"%C(yellow)%h%Creset ]]
                        .. [[%Cgreen(%><(12)%cr%><|(12))%Creset %s %C(blue)<%an>%Creset" {file}]],
                },
            },
            grep = {
                -- Ignore case by default
                rg_opts = '--column --line-number --no-heading --color=always --ignore-case --max-columns=4096 -e',
            },
        })
        local fzf = require('fzf-lua')
        vim.keymap.set('n', '<leader>ff', fzf.files, { desc = 'Find files' })

        -- Find files in the nvim config directory
        vim.keymap.set(
            'n',
            '<leader>fn',
            function()
                fzf.files({ cwd = vim.fn.stdpath('config') })
            end,
            { desc = 'Find nvim config files' }
        )

        vim.keymap.set('n', '<leader>fg', fzf.live_grep, { desc = 'Live grep' })
        vim.keymap.set('n', '<leader>gS', fzf.git_status, { desc = 'Git status' })
        vim.keymap.set('n', '<leader>gl', fzf.git_commits, { desc = 'Git logs' })
        vim.keymap.set('n', '<leader>glf', fzf.git_bcommits, { desc = 'Git logs (buffer)' })
        vim.keymap.set('n', '<leader>fh', fzf.help_tags, { desc = 'Help tags' })
    end,
}
