return {
  "neoclide/coc.nvim",
  branch = "release",
  build = "yarn install --frozen-lockfile",
  config = function()
    vim.g.coc_global_extensions = {
      'coc-json',
      'coc-tsserver',
      'coc-eslint',
      'coc-prettier'
    }

    -- Some example keymaps for coc
    local keyset = vim.keymap.set
    -- Use Tab for trigger completion with characters ahead and navigate
    local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
    keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
    keyset("i", "<S-TAB>", 'coc#pum#visible() ? coc#pum#prev(1) : "\\<C-h>"', opts)
    
    -- Make <CR> to accept selected completion item or notify coc.nvim to format
    keyset("i", "<cr>", 'coc#pum#visible() ? coc#pum#confirm() : "\\<C-g>u\\<CR>\\<c-r>=coc#on_enter()\\<CR>"', opts)

    -- GoTo code navigation
    keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
    keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
    keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
    keyset("n", "gr", "<Plug>(coc-references)", {silent = true})

    -- Show documentation in preview window
    function _G.show_docs()
      local cw = vim.fn.expand('<cword>')
      if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
      elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
      else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
      end
    end
    keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})

    -- Create check_back_space function
    vim.cmd([[
      function! CheckBackspace() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
      endfunction
    ]])
    _G.check_back_space = function()
      local col = vim.fn.col('.') - 1
      return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
    end
  end
}