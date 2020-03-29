" vim: set foldmethod=marker foldlevel=0:
" ============================================================================
" vim-plug plugins {{{
" ============================================================================
call plug#begin('~/.vim/plugged')

" junegunn's plugins
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"Plug 'junegunn/seoul256.vim'

" languages
"Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' }
"Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
"Plug 'rust-lang/rust.vim', { 'for': 'rust' }
"Plug 'sheerun/vim-polyglot'
"Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

"Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
"Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
"Plug 'alx741/vim-stylishask', { 'for': 'haskell' }
"Plug 'mpickering/hlint-refactor-vim', { 'for': 'haskell' }

" git stuff
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" editor
"Plug 'altercation/vim-colors-solarized'
Plug 'editorconfig/editorconfig-vim'
"Plug 'rdnetto/ycm-generator', { 'branch': 'stable' }
Plug 'w0rp/ale'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
"Plug 'tmux-plugins/vim-tmux-focus-events'

function! BuildYCM(info)
  if a:info.status == 'installed' || a:info.force
    !./install.py --clang-completer --gocode-completer
  endif
endfunction
"Plug 'valloric/youcompleteme', { 'for': ['c', 'cpp', 'go'], 'do': function('BuildYCM') }

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
syntax on

" local directories
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
set undodir=~/.vim/undo

"colorscheme
"set background=dark
"colorscheme solarized

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

" ----------------------------------------------------------------------------
" coc
" ----------------------------------------------------------------------------
"
"" if hidden is not set, TextEdit might fail.
"set hidden
"
"" Some servers have issues with backup files, see #649
"set nobackup
"set nowritebackup
"
"" Better display for messages
"set cmdheight=2
"
"" You will have bad experience for diagnostic messages when it's default 4000.
"set updatetime=300
"
"" don't give |ins-completion-menu| messages.
"set shortmess+=c
"
"" always show signcolumns
"set signcolumn=yes
""
"" Use tab for trigger completion with characters ahead and navigate.
"" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<TAB>" :
"      \ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"
"function! s:check_back_space() abort
"  let col = col('.') - 1
"  return !col || getline('.')[col - 1]  =~# '\s'
"endfunction
"
"" Use <c-space> to trigger completion.
"inoremap <silent><expr> <c-space> coc#refresh()
"
"" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
"" Coc only does snippet and additional edit on confirm.
"inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"
"" Use `[c` and `]c` to navigate diagnostics
"nmap <silent> [c <Plug>(coc-diagnostic-prev)
"nmap <silent> ]c <Plug>(coc-diagnostic-next)
"
"" Remap keys for gotos
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)
"
"" Use K to show documentation in preview window
"nnoremap <silent> K :call <SID>show_documentation()<CR>
"
"function! s:show_documentation()
"  if (index(['vim','help'], &filetype) >= 0)
"    execute 'h '.expand('<cword>')
"  else
"    call CocAction('doHover')
"  endif
"endfunction
"
"" Highlight symbol under cursor on CursorHold
"autocmd CursorHold * silent call CocActionAsync('highlight')
"
"" Remap for rename current word
"nmap <leader>rn <Plug>(coc-rename)
"
"" Remap for format selected region
"xmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)
"
"augroup mygroup
"  autocmd!
"  " Setup formatexpr specified filetype(s).
"  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"  " Update signature help on jump placeholder
"  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
"augroup end
"
"" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
"xmap <leader>a  <Plug>(coc-codeaction-selected)
"nmap <leader>a  <Plug>(coc-codeaction-selected)
"
"" Remap for do codeAction of current line
"nmap <leader>ac  <Plug>(coc-codeaction)
"" Fix autofix problem of current line
"nmap <leader>qf  <Plug>(coc-fix-current)
"
"" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
"nmap <silent> <TAB> <Plug>(coc-range-select)
"xmap <silent> <TAB> <Plug>(coc-range-select)
"xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)
"
"" Use `:Format` to format current buffer
"command! -nargs=0 Format :call CocAction('format')
"
"" Use `:Fold` to fold current buffer
"command! -nargs=? Fold :call     CocAction('fold', <f-args>)
"
"" use `:OR` for organize import of current buffer
"command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
"
"" Add status line support, for integration with other plugin, checkout `:h coc-status`
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
"
"" Using CocList
"" Show all diagnostics
"nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
"" Manage extensions
"nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
"" Show commands
"nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
"" Find symbol of current document
"nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
"" Search workspace symbols
"nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
"" Do default action for next item.
"nnoremap <silent> <space>j  :<C-u>CocNext<CR>
"" Do default action for previous item.
"nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
"" Resume latest coc list
"nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
"
" }}}
" ============================================================================
