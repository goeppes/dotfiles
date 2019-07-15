" vim: set foldmethod=marker foldlevel=0:
" ============================================================================
" vim-plug plugins {{{
" ============================================================================

call plug#begin('~/.vim/plugged')

" junegunn's plugins
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/seoul256.vim'

" languages
Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' }
Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'alx741/vim-stylishask', { 'for': 'haskell' }

" git stuff
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" editor
Plug 'altercation/vim-colors-solarized'
Plug 'editorconfig/editorconfig-vim'
Plug 'rdnetto/ycm-generator', { 'branch': 'stable' }
Plug 'w0rp/ale'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }

function! BuildYCM(info)
  if a:info.status == 'installed' || a:info.force
    !./install.py --clang-completer --gocode-completer
  endif
endfunction
Plug 'valloric/youcompleteme', { 'for': ['c', 'cpp', 'go'], 'do': function('BuildYCM') }

call plug#end()

" }}}
" ============================================================================
" basic settings {{{
" ============================================================================

set nocompatible       " has to be explicit to work for some reason
set encoding=utf-8     " set file encodings to utf-8
set undofile           " persistent undo
set hidden             " hides buffers instead of closing

set number             " enable line numbers
set cursorline         " highlight current line
set colorcolumn=80     " highlights column
set foldlevelstart=10  " open most folds by default

set tabstop=2          " tabs are displayed 2 spaces wide
set shiftwidth=2       " reindent ops indent 2 columns
set softtabstop=2      " tab key results in 2 spaces
set expandtab          " tab inserts spaces instead of tabs

set autoindent         " copy indent from previous line
set autowrite          " save on buffer switch
set autoread           " automatically reload file if changed externally
set wildmenu           " visual autocomplete for command menu
set lazyredraw         " redraw only when we need to
set showmatch          " highlight matching parenthesis

set hlsearch           " highlight search terms
set incsearch          " show search matchs as you type

set history=200
set belloff=all

filetype plugin indent on

" local directories
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
set undodir=~/.vim/undo

"colorscheme
set background=dark
colorscheme solarized

" }}}
" ============================================================================
" mappings {{{
" ============================================================================

" easier transitioning between windows
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" unimpaired.vim buffer mappings
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

" edit vimrc quickly
nnoremap <Leader>ev :vsplit $MYVIMRC<CR>
nnoremap <Leader>sv :source $MYVIMRC<CR>
nnoremap <silent> <Leader>n :nohlsearch<CR>

" disable keys to help learn faster
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

" ----------------------------------------------------------------------------
" #!! | shebang
" ----------------------------------------------------------------------------
inoreabbrev <expr> #!! "#!/usr/bin/env" . (empty(&filetype) ? '' : ' '.&filetype)

" ----------------------------------------------------------------------------
" autocommands
" ----------------------------------------------------------------------------
if has("autocmd")
  autocmd BufReadPost fugitive://* set bufhidden=delete
endif

" }}}
" ============================================================================
" plugins {{{
" ============================================================================

" ----------------------------------------------------------------------------
" polyglot
" ----------------------------------------------------------------------------
let g:polyglot_disabled = ['clojure', 'go', 'rust']

" ----------------------------------------------------------------------------
" syntastic.vim
" ----------------------------------------------------------------------------
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_python_python_exec = 'python3'
let g:syntastic_mode_map = {'mode': 'passive'}

" ----------------------------------------------------------------------------
" ale
" ----------------------------------------------------------------------------
let g:ale_completion_enabled = 1
let g:ale_fix_on_save = 1
let g:ale_sign_warning = '▲'
let g:ale_sign_error = '✗'
highlight link ALEWarningSign String
highlight link ALEErrorSign Title

" }}}
" ============================================================================
