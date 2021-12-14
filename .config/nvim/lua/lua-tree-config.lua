local tree_cb = require'nvim-tree.config'.nvim_tree_callback

require'nvim-tree'.setup {
  update_cwd_on_find = true,
  git = {
    enable = false,
    ignore = false
  },
  view = {
    width = 60,
    mappings = {
      list = {
        { key = "s", cb = tree_cb("vsplit") },
        { key = "t", cb = tree_cb("tabnew") },
        { key = "U", cb = tree_cb("dir_up") },
        { key = "c", cb = tree_cb("component")},
        { key = "h", cb = tree_cb("hook")},
      }
    }
  }
}

