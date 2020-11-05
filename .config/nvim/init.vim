set nocompatible

call plug#begin('~/.local/share/nvim/plugged')

Plug 'morhetz/gruvbox'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'airblade/vim-gitgutter'
Plug 'mattn/emmet-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'escorponox/css.vim'
Plug 'jparise/vim-graphql'
Plug 'jxnblk/vim-mdx-js'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'scrooloose/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'wincent/ferret'
" Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }

call plug#end()

call coc#add_extension('coc-json', 'coc-highlight', 'coc-tsserver', 'coc-eslint', 'coc-prettier', 'coc-yank', 'coc-lists', 'coc-calc', 'coc-styled-components', 'coc-webpack', 'coc-explorer', 'coc-actions', 'coc-react-refactor', 'coc-fzf-preview')

filetype plugin indent on
syntax on

let g:user_emmet_leader_key='<C-B>'
let g:user_emmet_mode='a'

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

let g:vim_jsx_pretty_colorful_config = 0
let g:vim_jsx_pretty_highlight_close_tag = 1

hi link jsxTag GruvboxBlue
hi link jsxCloseString GruvboxRed
hi link jsDestructuringBlock GruvboxBlue
hi link jsDestructuringProperty GruvboxBlue
hi link jsDestructuringBraces GruvboxPurple
hi link jsFuncArgs GruvboxPurple
hi link jsObjectKey GruvboxBlue
hi link jsObjectBraces GruvboxPurple
hi link jsTemplateString GruvboxPurple

" =========== cursorline
hi CursorLineNR ctermfg=black ctermbg=yellow
set cursorline

" ======= duplicate line command ======
command! -count=0 DuplicateLine :-<count>,-0t.
command! -count=0 CopyLine :-<count>,-<count>.
command! -nargs=+ CopyLines execute '-' . split(<q-args>, ' ')[0] . ',-' . split(<q-args>, ' ')[1] . 't.'

" ====== COC highlights =====
" hi CocErrorHighlight ctermbg=124 guibg=#990026
" hi CocWarningHighlight ctermbg=166 guibg=#6b2e5c
" hi CocInfoHighlight ctermbg=227 guibg=#3d6b2e
" hi CocHintHighlight ctermbg=74 guibg=#5c6b2e

" hi CursorColumn ctermbg=223 guibg=#2e3d6b

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

let g:fzf_preview_filelist_command = 'rg --files --hidden --no-ignore --no-messages -g \!node_modules/ -g \!.git/'
let g:fzf_preview_command = 'bat --color=always --plain {-1}'
let g:fzf_preview_grep_cmd = 'rg --column --line-number --no-heading --ignore-case --color=always --glob "!yarn.lock" --glob "!package-lock.json"'
let g:fzf_preview_use_dev_icons = 1
let g:fzf_preview_fzf_color_option = 'fg:#ebdbb2,bg:#282828,hl:#fabd2f,fg+:#ebdbb2,bg+:#3c3836,hl+:#fabd2f,info:#83a598,prompt:#bdae93,spinner:#fabd2f,pointer:#83a598,marker:#fe8019,header:#665c54'

let $FZF_PREVIEW_PREVIEW_BAT_THEME = 'gruvbox'

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
function! SearchInProject()
   call inputsave()
   let search = input("Search in projecto: ")
   call inputrestore()
   if search !=? ""
     execute "normal! :CocCommand fzf-preview.ProjectGrep\<Space>\"".search."\"\<CR>"
   endif
endfunction

nnoremap <silent> ,ff :CocCommand fzf-preview.ProjectFiles<CR>
nnoremap <silent> ,fg :call SearchInProject()<CR>
nnoremap <silent> ,fe :CocCommand fzf-preview.Buffers<CR>
nnoremap <silent> ,fs :CocCommand fzf-preview.GitStatus<CR>
nnoremap <silent> ,fr :CocCommand fzf-preview.ProjectMruFiles<CR>
nnoremap <silent> ,fd :CocCommand fzf-preview.CocCurrentDiagnostics<CR>
nnoremap <silent> K :CocCommand fzf-preview.CocReferences<CR>
nnoremap <silent> ,fq :CocCommand fzf-preview.QuickFix<CR>
nnoremap <silent> ,fa :CocCommand fzf-preview.GitActions<CR>
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
nnoremap ,j <C-W>j
nnoremap ,k <C-W>k
nnoremap ,l <C-W>l
nnoremap ,= <C-W>=
nnoremap ,x <C-W>x
nnoremap ,c :close<CR>

" tabs
nnoremap ,tg :tabnew<CR>
nnoremap ,tt :tabn<CR>
nnoremap ,tr :tabc<CR>
nnoremap ,tp :tabp<CR>

" hunks
nmap <Leader>hj <Plug>(GitGutterNextHunk)
nmap <Leader>hk <Plug>(GitGutterPrevHunk)
nmap <Leader>hu <Plug>(GitGutterUndoHunk)
nmap <Leader>hi <Plug>(GitGutterPreviewHunk)

"duplicate
nnoremap ,aa :DuplicateLine<space>
nnoremap ,as :CopyLine<space>
nnoremap ,ar :CopyLines<space>

"complete
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" language server protocol
" nmap <silent> K <Plug>(coc-references)
" nmap <silent> gd :vs<CR><Plug>(coc-definition)
nmap <silent> gd :call CocActionAsync('jumpDefinition', v:false)<CR>
nmap <silent> gr <Plug>(coc-rename)
nmap <silent> ga <Plug>(coc-codeaction)
nmap <silent> gl <Plug>(coc-codelens-action)

" error navigation
nmap <silent> <C-k> <Plug>(coc-diagnostic-prev)
nmap <silent> <C-j> <Plug>(coc-diagnostic-next)

" float scroll
nnoremap <expr><C-f> coc#util#has_float() ? coc#util#float_scroll(1) : "\<C-f>"
nnoremap <expr><C-b> coc#util#has_float() ? coc#util#float_scroll(0) : "\<C-b>"

" coc-actions
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
nmap <leader>c :CocCommand actions.open<CR>
xmap <leader>v :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>

" Syntax highlight debug
" function! SynStack()
"   if !exists("*synstack")
"     return
"   endif
"   echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
" endfunc
