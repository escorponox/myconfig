require('gitsigns').setup({
  keymaps = {
    ['n <leader>hj'] = '<cmd>lua require"gitsigns.actions".next_hunk()<CR>',
    ['n <leader>hk'] = '<cmd>lua require"gitsigns.actions".prev_hunk()<CR>',
    ['n <leader>hu'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ['n <leader>hi'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
  }
})
