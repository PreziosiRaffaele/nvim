return {
    'Funk66/jira.nvim',
    cmd = { 'JiraView', 'JiraOpen' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
        key = { 'DFMOS', 'CITATS', 'CITSP', 'CRMA', 'CITSCO', 'CITSCRM', 'CITREP', 'CITTM1', 'MONE', 'DFMC', 'MCMT', 'DFMTM', 'MTMT', 'RORT', 'CITBPM', 'CITTCE' },
        api_version = '2',
        auth_type = 'Bearer',
    },
    keys = {
        { '<leader>jv', ':JiraView<cr>', desc = 'View Jira issue', silent = true },
        { '<leader>jo', ':JiraOpen<cr>', desc = 'Open Jira issue in browser', silent = true },
    },
}
