" Vundle
if !isdirectory(expand("~/.vim/bundle/vundle"))
    !mkdir -p ~/.vim/bundle
    !git clone git://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
    let s:bootstrap=1
endif
set nocompatible               " be iMproved
filetype off                   " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

source ~/.ideavimrc
noremap <C-L> :cn<CR>
map <silent> <F2> :NERDTreeToggle<CR>
map <silent> <C-N> :NERDTreeToggle<CR>

noremap  <silent> <C-u> :call NERDComment('ci', 'Invert')<CR>
inoremap <silent> <C-u> :call NERDComment('ci', 'Invert')<CR>

Bundle 'gmarik/vundle'

Bundle 'mileszs/ack.vim'
Bundle 'Lokaltog/vim-powerline'
Bundle 'scrooloose/nerdtree'

Bundle 'junegunn/seoul256.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-eunuch'
Bundle 'tikhomirov/vim-glsl'
Bundle 'junegunn/fzf'
Bundle 'junegunn/fzf.vim'

if exists("s:bootstrap") && s:bootstrap
    unlet s:bootstrap
    BundleInstall
endif

syntax on
filetype plugin indent on

set encoding=utf-8
set laststatus=2

set virtualedit=onemore
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab

"set smarttab
set autoindent copyindent
set smartindent         " let's try
set shiftround

"set nobackup nowritebackup noswapfile  " defaults
set autoread            " let's try
"set hidden             " maybe later

set title
"set numberwidth=2  " necessary?
"set shortmess=atI  " ???
set ruler
set showmatch
set matchtime=0
set matchpairs+=<:>

set list listchars=tab:»·,trail:.
if has("wildmenu")
    set wildignore+=*.a,*.o,*.d,*.out,*.beam
    set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
    set wildignore+=.DS_Store,.git,.hg,.svn,deps,ebin
    set wildignore+=*~,*.swp,*.tmp
    set wildignore+=*.pyc
    set wildignore+=*.pdf,*.aux,*.toc,*.blg,*.bbl,*.cls,*.log
    set wildmenu
    set wildmode=longest,list
endif

set backspace=indent,eol,start
set showcmd
if has('mouse')
    set mouse=a
endif

set guifont=Monospace\ 7

set t_Co=256
set background=dark
let g:seoul256_background=233
colorscheme seoul256

" Trailing whitespace - https://vim.fandom.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=red guibg=red
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/

set timeoutlen=20
set so=16
au BufRead,BufNewFile *.rb set expandtab
au BufRead,BufNewFile *.rb setlocal sw=2 ts=2 sts=2
set updatetime=200
" set clipboard=unnamed,autoselect

let g:NERDTreeMapOpenInTab = '<Nop>'
let g:NERDTreeMapOpenInTabSilent = '<Nop>'
let g:NERDTreeMapOpenVSplit = '<Nop>'
let g:NERDTreeMapHelp = '<Nop>'

" noremap  <silent> <C-i> :call NERDComment('cc', 'Comment')<CR>
" inoremap <silent> <C-i> :call NERDComment('cc', 'Comment')<CR>
let g:NERDSpaceDelims=1

if executable('ag')
  let g:ackprg = 'ag --vimgrep --smart-case'
endif

" Navigation in insert mode
" Alt-{dhtn, bw}: as usual
" Alt-{0^}: ^ and $
inoremap <Esc>d <Left>
inoremap <Esc>h <Down>
inoremap <Esc>t <Up>
inoremap <Esc>n <Right>
inoremap <Esc>b <C-Left>
inoremap <Esc>w <C-Right>
inoremap <Esc>^ <Home>
inoremap <Esc>$ <End>

" And command-line mode as well.
cnoremap <Esc>d <Left>
cnoremap <Esc>h <Down>
cnoremap <Esc>t <Up>
cnoremap <Esc>n <Right>
cnoremap <Esc>b <C-Left>
cnoremap <Esc>w <C-Right>
cnoremap <Esc>^ <Home>
cnoremap <Esc>$ <End>

" Ctrl-Backspace and Alt-Backspace
inoremap <Esc><Backspace> <C-W>
cnoremap <Esc><Backspace> <C-W>
inoremap <C-H> <C-W>
cnoremap <C-H> <C-W>

" https://vim.fandom.com/wiki/Prevent_escape_from_moving_the_cursor_one_character_to_the_left
let CursorColumnI = 0
autocmd InsertEnter * let CursorColumnI = col('.')
autocmd CursorMovedI * let CursorColumnI = col('.')
autocmd InsertLeave * if col('.') != CursorColumnI | call cursor(0, col('.')+1) | endif
