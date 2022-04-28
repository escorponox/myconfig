local actions = require('telescope.actions')
require('telescope').setup {
  defaults = {
    layout_config = {
      horizontal = {
        prompt_position = 'top',
        preview_width = 0.4
      }
    },
    sorting_strategy = "ascending",
    mappings = {
      i = {
        ["<C-q>"] = actions.send_to_qflist,
        ["<C-s>"] = actions.send_selected_to_qflist
      },
      n = {
        ["<C-q>"] = actions.send_to_qflist,
        ["<C-s>"] = actions.send_selected_to_qflist
      },
    },
  },
  extensions = {
    fzf = {
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    },
  }
}

require('telescope').load_extension('fzf')
require('telescope').load_extension('coc')
