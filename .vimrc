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

Bundle 'Lokaltog/vim-powerline'
Bundle 'scrooloose/nerdtree'
Bundle 'kien/ctrlp.vim'

Bundle 'junegunn/seoul256.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-eunuch'
Bundle 'tikhomirov/vim-glsl'

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
set list listchars=tab:\ \ ,trail:.

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

set expandtab
set sw=4
set guifont=Monospace\ 7

set t_Co=256
set background=dark
let g:seoul256_background=233
colorscheme seoul256

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

" Navigation in insert mode, depends on urxvt hacks (also in inputrc)
" Alt-{dhtn, bw}: as usual
" Alt-{ie}: ^ and $
inoremap <F5> <Left>
inoremap <F6> <Down>
inoremap <F7> <Up>
inoremap <F8> <Right>
inoremap <F9> <C-Left>
inoremap <F10> <C-Right>
inoremap <F11> <Home>
inoremap <F12> <End>

" Do it for normal mode too.
noremap <F5> <Left>
noremap <F6> <Down>
noremap <F7> <Up>
noremap <F8> <Right>
noremap <F9> b
noremap <F10> w
noremap <F11> ^
noremap <F12> $

" And command-line mode as well.
cnoremap <F5> <Left>
cnoremap <F6> <Down>
cnoremap <F7> <Up>
cnoremap <F8> <Right>
cnoremap <F9> <C-Left>
cnoremap <F10> <C-Right>
cnoremap <F11> <Home>
cnoremap <F12> <End>

" Ctrl-Backspace
imap <Esc>[33~ <C-W>
cmap <Esc>[33~ <C-W>

" https://vim.fandom.com/wiki/Prevent_escape_from_moving_the_cursor_one_character_to_the_left
let CursorColumnI = 0
autocmd InsertEnter * let CursorColumnI = col('.')
autocmd CursorMovedI * let CursorColumnI = col('.')
autocmd InsertLeave * if col('.') != CursorColumnI | call cursor(0, col('.')+1) | endif
