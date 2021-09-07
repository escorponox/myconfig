require'nvim-treesitter.configs'.setup {
  -- ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "c", "rust", "bash"},  -- list of language that will be disabled
    custom_captures = {
      ["tag.close"] = "TSCloseTag",
    }
  },
  autotag = {
    enable = true
  }
}