" Enable default settings.
filetype plugin indent on
set ruler
set textwidth=80
set wildmode=longest,list,full
set wildmenu
set t_Co=256

" Don't polute working directory with swap files.
set backupdir=$HOME/.vim/swapfiles/
set directory=$HOME/.vim/backups/

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
Plugin 'fatih/vim-go'

" Ack to search files
Plugin 'mileszs/ack.vim'

" CtrlP for fuzzy finding files
" Plugin 'ctrlpvim/ctrlp.vim'

Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'

Plugin 'jremmen/vim-ripgrep'

" Use tab for insert complete
" Plugin 'ervandew/supertab'

" Swift
Plugin 'keith/swift.vim'

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

" Yank to clipboard
map <Leader>c :w !pbcopy<CR><CR>

set clipboard=unnamed

" Display line numbers
set number

" Set color scheme
let g:solarized_termcolors=256
let g:solarized_termtrans = 16
let g:solarized_bold = 1
let g:solarized_underline = 1 
let g:solarized_italic = 1
let g:solarized_contrast = "high"
let g:solarized_visibility= "high" 
syntax enable
set background=dark
let g:solarized_termtrans = 1 " This gets rid of the grey background
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

" Use ripgrep
if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif


command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)

set grepprg=rg\ --vimgrep

nnoremap <C-p> :Files<Cr>

" Automatically toggle paste/nopaste
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

if argc() == 0
  autocmd VimEnter * call Start()
endif
