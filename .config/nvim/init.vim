set nocompatible

call plug#begin('~/.local/share/nvim/plugged')

Plug 'gruvbox-community/gruvbox'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'scrooloose/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'wincent/ferret'
Plug 'jiangmiao/auto-pairs'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'windwp/nvim-ts-autotag'
Plug 'fannheyward/telescope-coc.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'ThePrimeagen/harpoon'

Plug 'github/copilot.vim'

call plug#end()

call coc#add_extension('coc-json', 'coc-highlight', 'coc-tsserver', 'coc-eslint', 'coc-prettier', 'coc-yank', 'coc-lists', 'coc-calc', 'coc-styled-components', 'coc-webpack')

filetype plugin indent on
syntax on

"================color====================
if (has("termguicolors"))
  set termguicolors
endif

" ============================== SETTINGS ==============================

" colorscheme
set background=dark
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox

let g:airline_theme='gruvbox'

" =========== cursorline
hi CursorLineNR ctermfg=black ctermbg=yellow
set cursorline

" ======= duplicate line command ======
command! -count=0 DuplicateLine :-<count>,-0t.
command! -count=0 CopyLine :-<count>,-<count>.
command! -nargs=+ CopyLines execute '-' . split(<q-args>, ' ')[0] . ',-' . split(<q-args>, ' ')[1] . 't.'

autocmd CursorHold * silent call CocActionAsync('highlight')

let g:airline#extensions#tabline#enabled = 0

let g:airline#extensions#tabline#left_sep = '='
let g:airline#extensions#tabline#left_alt_sep = '|'

let g:airline_powerline_fonts = 1

let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeShowHidden=1
let g:NERDTreeWinSize=60

let g:AutoPairsMultilineClose=0

let g:FerretQFHandler = ''

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
" set cmdheight=2
set showtabline=2
set pumheight=10
set scl=yes
set backupcopy=yes

" reload changed file on focus, buffer enter
" helps if file was changed externally.
augroup ReloadGroup
  autocmd!
  autocmd! FocusGained,BufEnter * checktime
augroup END

au BufRead,BufNewFile *.graphql,*.graphqls,*.gql setfiletype graphql

" ============================== MAPPINGS ==============================
let mapleader = " "

inoremap jj <Esc>

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
nnoremap <silent> ,fr :Telescope coc mru<CR>
nnoremap <silent> K :Telescope coc references<CR>
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
nnoremap ,ss :mksession! ~/.config/nvim/sessions/
nnoremap ,so :source ~/.config/nvim/sessions/
nnoremap ,sr :!rm ~/.config/nvim/sessions/

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

" explore project dir
nnoremap - :NERDTree .<CR>
" explore ditree toogle
nnoremap ,, :NERDTree %<CR>
" tree toggle
nnoremap ,m :NERDTreeToggle<CR>
" nnoremap ,m :CocCommand explorer<CR>

" info windows
nnoremap ,o :lopen<CR>
nnoremap ,p :lclose<CR>:cclose<CR>:pclose<CR>

" buffers
nnoremap ,bb :b#<CR>
nnoremap ,bp :bp<CR>
nnoremap ,bn :bn<CR>
" nnoremap ,e :buffers<CR>:buffer<Space>

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
" this two are disabled to test copilot
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <c-space> coc#refresh()

" LSP
nmap <silent> gd :call CocActionAsync('jumpDefinition', v:false)<CR>
nmap <silent> gt :call CocActionAsync('jumpTypeDefinition', v:false)<CR>
nmap <silent> gr <Plug>(coc-rename)
nmap <silent> ga <Plug>(coc-codeaction)
nmap <silent> gl <Plug>(coc-codelens-action)
nmap <silent> gb :Git blame<CR>

" error navigation
nmap <silent> <C-k> <Plug>(coc-diagnostic-prev)
nmap <silent> <C-j> <Plug>(coc-diagnostic-next)

" harpoon
nnoremap ,ta :lua require("harpoon.mark").add_file()<CR>
nnoremap ,tm :lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap ,tj :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap ,tk :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap ,tl :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap ,t; :lua require("harpoon.ui").nav_file(4)<CR>


" coc float scroll
nnoremap <expr><C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <expr><C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

:lua require('treesitter-config')
:lua require('telescope-config')
:lua require('git-signs-config')

