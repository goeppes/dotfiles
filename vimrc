" vim:fdm=marker

" local directories {{{
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
set undodir=~/.vim/undo
" }}}

" settings {{{
set autoindent " copy indent from previous line
set expandtab " tab inserts spaces instead of tabs
set foldenable " enable folding
set foldnestmax=1 " folds only go 1 level deep
set nu "enable line numbers
set shiftwidth=2 " reindent ops indent 2 columns
set softtabstop=2 " tab key results in 2 spaces
set tabstop=2 " tabs are displayed 2 spaces wide
set undofile " persistent undo
" }}}

" git commit line wrapping
autocmd Filetype gitcommit setlocal spell textwidth=72

autocmd FileType c   setlocal noet sw=4 sts=4 ts=4
autocmd FileType cpp setlocal noet sw=4 sts=4 ts=4

" vim-indent-guides.vim {{{
augroup vim_indent_guides_config
  autocmd!
  let g:indent_guides_enable_on_vim_startup = 1
  let g:indent_guides_guide_size = 1
  let g:indent_guides_auto_colors = 0
" autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=black
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=black
augroup END
" }}}

" syntastic.vim {{{
augroup syntastic_config
  autocmd!
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*

  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0
augroup END
" }}}

" youcompleteme.vim {{{
augroup ycm_config
  autocmd!
  let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
  let g:ycm_python_binary_path = 'python'
  let g:ycm_rust_src_path = '~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'
augroup END
" }}}

" vim-plug plugins {{{
call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'altercation/vim-colors-solarized'
Plug 'fatih/vim-go'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-fugitive'
Plug 'valloric/youcompleteme'

call plug#end()
" }}}

" syntax highlighting {{{
set t_Co=256
set background=dark
syntax enable
colorscheme solarized
" }}}

