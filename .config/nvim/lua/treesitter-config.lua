require'nvim-treesitter.configs'.setup {
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "c", "rust", "bash"},  -- list of language that will be disabled
  },
  autotag = {
    enable = true
  },
  indent = {
    enable = true
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "Z", -- mapping to init the node/scope selection
      node_incremental = "gu", -- mapping to navigate nodes in current file
      node_decremental = "gd", -- mapping to navigate nodes in current file
    },
  },
}
