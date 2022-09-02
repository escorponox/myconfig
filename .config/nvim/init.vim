set nocompatible

call plug#begin('~/.local/share/nvim/plugged')

Plug 'gruvbox-community/gruvbox'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'antoinemadec/FixCursorHold.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'nvim-treesitter/playground'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'windwp/nvim-ts-autotag'
Plug 'escorponox/telescope-coc.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'windwp/nvim-autopairs'

Plug 'escorponox/nvim-tree.lua'

call plug#end()

call coc#add_extension('coc-json', 'coc-highlight', 'coc-tsserver', 'coc-eslint', 'coc-prettier', 'coc-yank', 'coc-lists', 'coc-calc', 'coc-styled-components', 'coc-webpack', 'coc-sumneko-lua', 'coc-emoji', 'coc-jest', 'coc-git')

" ============================== SETTINGS ==============================

set background=dark
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox

hi CursorLineNR ctermfg=black ctermbg=yellow
set cursorline
hi CocMenuSel ctermbg=66 guibg=#458588
hi link CocPumSearch GruvboxOrange

autocmd CursorHold * silent call CocActionAsync('highlight')

let g:AutoPairsMultilineClose=0
let g:cursorhold_updatetime = 100

filetype plugin indent on
syntax on

set termguicolors
set autoindent
set autoread
set backspace=indent,eol,start
set clipboard+=unnamedplus
set expandtab
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set linebreak
set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:✗,space:·
set nobackup
set noswapfile
set noshowmode
set number
set relativenumber
set path+=src
set shiftwidth=2
set softtabstop=2
set tabstop=2
set splitright
set timeoutlen=2000
set ttimeoutlen=0
set wildmenu
set nolist
set updatetime=100
set shortmess+=c
set showtabline=2
set scl=yes
set backupcopy=yes
set scrolloff=8

" ======= duplicate line command ======
command! -count=0 DuplicateLine :-<count>,-0t.
command! -count=0 CopyLine :-<count>,-<count>.
command! -nargs=+ CopyLines execute '-' . split(<q-args>, ' ')[0] . ',-' . split(<q-args>, ' ')[1] . 't.'

" reload changed file on focus, buffer enter
" helps if file was changed externally.
augroup ReloadGroup
  autocmd!
  autocmd! FocusGained,BufEnter * checktime
augroup END

augroup GraphQLFiletype
  autocmd!au! BufRead,BufNewFile *.graphql,*.graphqls,*.gql setfiletype graphqlaugroup END

" ============================== MAPPINGS ==============================
let mapleader = " "

inoremap jj <Esc>
nnoremap = ,

" visual movement
nnoremap j gj
nnoremap k gk

" find and replace word
nnoremap ,rr :%s//cg<Left><Left><Left>
nnoremap ,rg :%s//g<Left><Left>

" fuzzy find
nnoremap <silent> ,ff :Telescope find_files find_command=rg,--files,--hidden,--no-ignore,--no-messages,-g,!node_modules/,-g,!.git/,-g,!yarn.lock,-g,!package-lock.json<CR>
nnoremap ,fg :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Search for > "), vimgrep_arguments = {"rg","--column","--line-number","--no-heading","--ignore-case","--color=never","--glob","!yarn.lock","--glob","!package-lock.json"}})<CR>
nnoremap <silent> ,ft :Telescope grep_string find_command=rg,--column,--line-number,--no-heading,--ignore-case,--color=always,--glob,"!yarn.lock",--glob,"!package-lock.json"<CR>
nnoremap <silent> ,fe :Telescope buffers<CR>
nnoremap <silent> ,fs :Telescope git_status<CR>
nnoremap <silent> ,fm :Telescope coc mru<CR>
nnoremap <silent> ,fr :Telescope coc references<CR>
nnoremap <silent> ,fq :Telescope quickfix<CR>
nnoremap <silent> ,fy :CocList yank<CR>
nnoremap <silent> ,fh :call CocActionAsync('doHover')<CR>

" close buffer
nnoremap ,d :bd<CR>
" close all buffers
nnoremap ,D :bufdo bd<CR>

"split
nnoremap ,v :vs<CR>
nnoremap ,g :sp<CR>

" session save/open/remove
nnoremap ,ss :CocCommand session.save<CR>
nnoremap ,so :CocCommand session.load<CR>

" edit/save .vimrc
nnoremap ,sc :e ~/.config/nvim/init.vim<CR>
nnoremap ,sv :so ~/.config/nvim/init.vim<CR>

" show invisible chars
nnoremap ,sh :set list!<CR>

" no highlights
nnoremap ,y :noh<CR>

" select all
nnoremap ,sa ggVG

" quit/save all
nnoremap ,q :qa<CR>
nnoremap ,w :wall<CR>

" these only get hit by accident
nnoremap Q <Nop>
nnoremap q: <Nop>

" 0 is easier. ^ is more useful.
nnoremap 0 ^
nnoremap ^ 0

" info windows
nnoremap ,o :lopen<CR>
nnoremap ,p :lclose<CR>:cclose<CR>:pclose<CR>

" buffers
nnoremap ,bb :b#<CR>
nnoremap ,bp :bp<CR>
nnoremap ,bn :bn<CR>

" windows
nnoremap ,z <C-W>\|
nnoremap ,h <C-W>h
nnoremap ,l <C-W>l
nnoremap ,= <C-W>=
nnoremap ,x <C-W>x
nnoremap ,c :close<CR>

" quickfix
nnoremap ,j :cn<CR>
nnoremap ,k :cp<CR>

" tabs
nnoremap ,tg :tabnew<CR>
nnoremap ,tt :tabn<CR>
nnoremap ,tr :tabc<CR>
nnoremap ,tp :tabp<CR>

"duplicate
nnoremap ,aa :DuplicateLine<space>
nnoremap ,as :CopyLine<space>
nnoremap ,ar :CopyLines<space>

"complete
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <expr> <c-space> coc#refresh()

" LSP
nmap <silent> gd :call CocActionAsync('jumpDefinition', v:false)<CR>
nmap <silent> gt :call CocActionAsync('jumpTypeDefinition', v:false)<CR>
nmap <silent> gr <Plug>(coc-rename)
nmap <silent> ga <Plug>(coc-codeaction-cursor)
nmap <silent> gl <Plug>(coc-codeaction)
nmap <silent> gb :Git blame<CR>

" error navigation
nmap <silent> <C-k> <Plug>(coc-diagnostic-prev)
nmap <silent> <C-j> <Plug>(coc-diagnostic-next)

" coc float scroll
nnoremap <expr><C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <expr><C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

" coc git
nnoremap <silent> <leader>hj <Plug>(coc-git-nextchunk)
nnoremap <silent> <leader>hk <Plug>(coc-git-prevchunk)
nnoremap <silent> <leader>hi :CocCommand git.chunkInfo<CR>
nnoremap <silent> <leader>hu :CocCommand git.chunkUndo<CR>

:lua require('treesitter-config')
:lua require('telescope-config')
:lua require('lualine-config')
:lua require('nvim-autopairs').setup{}

" nvim-tree
:lua require('lua-tree-config')
nnoremap ,, :NvimTreeFindFile<CR>
nnoremap ,m :NvimTreeToggle<CR>

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
