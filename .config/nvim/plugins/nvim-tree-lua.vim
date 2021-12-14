
let g:nvim_tree_show_icons = {
    \ 'git': 0,
    \ 'folders': 1,
    \ 'files': 0,
    \ 'folder_arrows': 1,
    \ }
let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★",
    \   'deleted': "",
    \   'ignored': "◌"
    \   },
    \ 'folder': {
    \   'arrow_open': "▾",
    \   'arrow_closed': "▸",
    \   'default': "",
    \   'open': "",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "",
    \   'symlink_open': ""
    \   }
    \ }
let g:nvim_tree_icon_padding = ''
let g:nvim_tree_quit_on_open = 1

let g:nvim_tree_special_files = { 'package.json': 1, '.env': 1 }

:lua require('lua-tree-config')


nnoremap ,, :NvimTreeFindFile<CR>
nnoremap ,m :NvimTreeToggle<CR>
