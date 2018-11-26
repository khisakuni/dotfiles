" Enable default settings.
filetype plugin indent on
set ruler
set textwidth=80
set wildmode=longest,list,full
set wildmenu
set t_Co=256

" Reload the current buffer if changed externally.
set autoread

" Write content of file automatically
set autowrite

" Chars to show for invisible characters
:set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣

" Auto indent with 2 spaces.
set smartindent
set shiftwidth=2
set tabstop=2
set expandtab

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'w0rp/ale'

" Go auto complete
" Plugin 'mdempsky/gocode', {'rtp': 'vim/'}

" NerdTree
Plugin 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" ES6 highlighting
Plugin 'isRuslan/vim-es6'

" Go development environment
Plugin 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

" Ack to search files
Plugin 'mileszs/ack.vim'

" CtrlP for fuzzy finding files
Plugin 'ctrlpvim/ctrlp.vim'

" Color theme
Plugin 'altercation/vim-colors-solarized'

" Use tab for insert complete
Plugin 'ervandew/supertab'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Ale Configs
let g:ale_linters = {
  \'go': ['go vet', 'golint']
\}
let g:ale_fixers = {
  \'go': ['goimports', 'gofmt'],
\}
let g:ale_fix_on_save = 1
let g:ale_go_metalinter_options = 'fast'

" Vim-Go config
" let g:go_fmt_command = "goimports"
" let g:go_fmt_fail_silently = 1
" let g:go_auto_type_info = 1
let g:go_info_mode = 'gocode'
let g:go_gocode_autobuild = 1

" Use omni complete with supertab
" let g:SuperTabDefaultCompletionType = "<C-X><C-O>"

" Don't show preview window
set completeopt-=preview

" Change leader form \ to ;
let mapleader=";"

" Mappings
map <Leader>\ :NERDTreeToggle<CR>

set clipboard=unnamed

" Display line numbers
set number

" Set color scheme
syntax enable
set background=dark
colorscheme solarized

" Highlight search matches
set hlsearch

" Disable <c-f> because it's the tmux cmd
map <c-f> <Nop>

" Make backspace work
set backspace=indent,eol,start

fun! Start()
  enew
  setlocal
      \ bufhidden=wipe
      \ buftype=nofile
      \ nobuflisted
      \ nocursorcolumn
      \ nocursorline
      \ nolist
      \ nonumber
      \ noswapfile
      \ norelativenumber

  exec ":r ~/.quote.txt"
  exec ":r ~/.splash.txt"

  setlocal
      \ nomodifiable
      \ nomodified

  " Just like with the default start page, when we switch to insert
  " mode a new buffer should be opened which we can then later save.
  nnoremap <buffer><silent> e :enew<CR>
  nnoremap <buffer><silent> i :enew <bar> startinsert<CR>
  nnoremap <buffer><silent> o :enew <bar> startinsert<CR>
endfun

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

if argc() == 0
  autocmd VimEnter * call Start()
endif
