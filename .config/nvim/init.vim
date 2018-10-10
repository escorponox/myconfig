set nocompatible

call plug#begin('~/.local/share/nvim/plugged')

Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'w0rp/ale'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'airblade/vim-gitgutter'
Plug 'mattn/emmet-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'styled-components/vim-styled-components'
Plug 'elzr/vim-json'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
" if has('nvim')
"   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" endif

Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-path'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

call plug#end()

autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect

let g:ncm2_path#cwdpath_source_override = {'enable': 0}
let g:ncm2_path#rootpath_source_override = {'enable': 0}

let g:ale_linters = {'javascript': ['eslint'], 'jsx': ['eslint'] }
let g:ale_sign_column_always = 1
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier', 'eslint']
let g:ale_fixers['json'] = ['prettier']
let g:ale_fixers['scss'] = ['prettier']
let g:ale_fixers['css'] = ['prettier']
let g:ale_fix_on_save = 1
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_sign_error = '!!'
let g:ale_sign_warning = '--'

let g:LanguageClient_serverCommands = {
  \ 'typescript': ['javascript-typescript-stdio'],
  \ 'javascript': ['javascript-typescript-stdio'],
  \ 'javascript.jsx': ['javascript-typescript-stdio']
  \ }

highlight ALEErrorSign ctermfg=DarkMagenta ctermbg=15
highlight ALEWarningSign ctermfg=26 ctermbg=15

" if !exists("g:gui_oni")
"   let g:deoplete#enable_at_startup = 1
" endif

filetype plugin indent on
syntax on

let g:user_emmet_leader_key='<C-E>'

"================color====================
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" ============================== FZF/RIPGREP
" ========== files
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'

" ========== words
command! -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --ignore-case --color=always --glob "!yarn.lock" '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview('right:50%', '?'))

" ============================== SETTINGS ==============================

" colorscheme
" let g:gruvbox_contrast_dark="hard"
" let g:gruvbox_contrast_light="hard"
colorscheme gruvbox
" colorscheme onedark

let g:airline_theme='onedark'
let g:airline#extensions#tabline#enabled = 0

let g:airline#extensions#tabline#left_sep = '=='
let g:airline#extensions#tabline#left_alt_sep = '|'

let g:airline_powerline_fonts = 0

let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeShowHidden=1
let g:NERDTreeWinSize=60

set autoindent
set autoread
set background=dark
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
set list!
set updatetime=100
set shortmess+=c

" reload changed file on focus, buffer enter
" helps if file was changed externally.
augroup ReloadGroup
  autocmd!
  autocmd! FocusGained,BufEnter * checktime
augroup END

" =========== cursorline
hi CursorLine ctermfg=NONE ctermbg=NONE
hi CursorLineNR ctermfg=black ctermbg=yellow
set cursorline

" ======= duplicate line command ======
command! -count=0 DuplicateLine :-<count>,-0t.

" ============================== MAPPINGS ==============================
let mapleader = " "

" find and replace word
nnoremap ,rr :%s//cg<Left><Left><Left>
nnoremap ,rg :%s//g<Left><Left>

" find file
nnoremap ,ff :GFiles<CR>
" find fuzzy
nnoremap ,fg :Rg 
" find buffer
nnoremap ,e :Buffers<CR>

" close buffer
nnoremap ,d :bd<CR>
" close buffer not window
" nnoremap ,d :bp\|bd #<CR>
" close all buffers
nnoremap ,D :bufdo bd<CR>

" vert split
nnoremap ,v :vs<CR>

" session save/open/remove
nnoremap ,ss :mksession! ~/.config/nvim/sessions/
nnoremap ,so :source ~/.config/nvim/sessions/
nnoremap ,sr :!rm ~/.config/nvim/sessions/

" edit/save .vimrc
"nnoremap ,ev :e ~/.config/nvim/init.vim<CR>
"nnoremap ,sv :so ~/.config/nvim/init.vim<CR>

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

" info windows
nnoremap ,o :lopen<CR>
nnoremap ,p :lclose<CR>:cclose<CR>:pclose<CR>

" buffers
nnoremap ,bb :b#<CR>
nnoremap ,bj :bprev<CR>
nnoremap ,bk :bnext<CR>
" nnoremap ,e :buffers<CR>:buffer<Space>

" windows
nnoremap ,z <C-W>x
nnoremap ,h <C-W>h
nnoremap ,j <C-W>j
nnoremap ,k <C-W>k
nnoremap ,l <C-W>l
nnoremap ,= <C-W>=
" kill all windows but current
nnoremap ,x :only<CR>

" tabs
nnoremap ,tg :tabnew<CR>
nnoremap ,tt :tabn<CR>
nnoremap ,tr :tabc<CR>
nnoremap ,tp :tabp<CR>

" hunks
nmap <Leader>hj <Plug>GitGutterNextHunk
nmap <Leader>hk <Plug>GitGutterPrevHunk
nmap <Leader>hu <Plug>GitGutterUndoHunk
nmap <Leader>hi <Plug>GitGutterPreviewHunk

"duplicate
nnoremap ,a :DuplicateLine<space>

"complete on enter, fuck auto new line?
inoremap <expr> <CR> (pumvisible() ? "\<c-y>" : "\<CR>")

nnoremap <silent> K :call LanguageClient#textDocument_references()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
