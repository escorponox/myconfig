require'lualine'.setup {
  options = {
    theme = 'gruvbox'
  },
  sections = {
    lualine_a = {},
    lualine_b = {
      { 'diff', colored = true }
    },
    lualine_c = { 'filename' },
    lualine_x = {
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
      }
    }
  },
  tabline = {
    lualine_a = {
      {
        'mode',
        fmt = function(str) return str:sub(1,1) end
      }
    },
    lualine_b = {'branch'},
    lualine_c = {
      {
        'filename',
        path = 1,
        shorting_target = 10,
      }
    },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {
      {
        'tabs',
        mode = 2, -- 0: Shows tab_nr 1: Shows tab_name 2: Shows tab_nr + tab_name
      }
    },
  }
}

