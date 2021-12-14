require'lualine'.setup {
  options = {
    theme = 'gruvbox'
  },
  sections = {
    lualine_a = {
      {
        'mode',
        fmt = function(str) return str:sub(1,1) end
      }
    },
    lualine_b = {
      { 'branch' },
      { 'diff', colored = true },
    },
    lualine_x = {
      'filetype',
      {
        'diagnostics',
        colored = true,
        sources = { 'coc' },
        sections = {'error', 'warn'},
        diagnostics_color = {
          -- Same values like general color option can be used here.
          error = { fg = 167 }, -- changes diagnostic's error color
          warn  = { fg = 208 },  -- changes diagnostic's warn color
        },
        symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' },
      },
    },
    lualine_y = { 'progress' },
  }
}

require'tabline'.setup {
  enable = true,
  options = {
    show_tabs_always = true,
    show_filename_only = true,
  }
}

local function setTablineShowBuffers()
  local data = vim.fn.json_decode(vim.g.tabline_tab_data)[vim.fn.tabpagenr()]
  if(data and data.show_all_buffers) then
    vim.cmd('TablineToggleShowAllBuffers')
  end
end

return {
  setTablineShowBuffers = setTablineShowBuffers
}
