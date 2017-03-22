" vim: set foldmethod=marker foldlevel=0:
" ============================================================================
" vim-plug plugins {{{
" ============================================================================

call plug#begin('~/.vim/plugged')

" junegunn's plugins
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" languages
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" editor
Plug 'airblade/vim-gitgutter'
Plug 'altercation/vim-colors-solarized'
Plug 'editorconfig/editorconfig-vim'
Plug 'rdnetto/ycm-generator', { 'branch': 'stable' }
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-fugitive'

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
set hidden             " hides buffers instead of closing
set number             " enable line numbers
set undofile           " persistent undo
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
set backspace=indent,eol,start

" local directories
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
set undodir=~/.vim/undo

"colorscheme
colorscheme solarized
set background=dark
set t_Co=256

" }}}
" ============================================================================
" mappings {{{
" ============================================================================

let mapleader      = ","
let maplocalleader = "\\"

nnoremap H ^
nnoremap L $
nnoremap ; :
nnoremap : ;

inoremap jk <esc>
vnoremap jk <esc>  

" easier transitioning between windows
noremap <c-h> <c-w>h
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-l> <c-w>l

" edit vimrc quickly
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <silent> <leader>n :nohlsearch<cr>

" disable keys to help learn faster
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" ----------------------------------------------------------------------------
" #!! | shebang
" ----------------------------------------------------------------------------
inoreabbrev <expr> #!! "#!/usr/bin/env" . (empty(&filetype) ? '' : ' '.&filetype)

" }}}
" ============================================================================
" plugins {{{
" ============================================================================

" ----------------------------------------------------------------------------
" syntastic.vim
" ----------------------------------------------------------------------------
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1

" }}}
" ============================================================================
