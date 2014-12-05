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

Bundle 'altercation/vim-colors-solarized'
Bundle 'Lokaltog/vim-powerline'
"Bundle 'airblade/vim-gitgutter' " broken?
Bundle 'scrooloose/nerdtree'
Bundle 'kien/ctrlp.vim'

Bundle 'junegunn/seoul256.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-eunuch'
Bundle 'guns/vim-clojure-static'
Bundle 'derekwyatt/vim-scala'
Bundle 'kchmck/vim-coffee-script'
Bundle 'rosenfeld/conque-term'
Bundle 'wting/rust.vim'

if exists("s:bootstrap") && s:bootstrap
    unlet s:bootstrap
    BundleInstall
endif

syntax on
filetype plugin indent on

set encoding=utf-8
set laststatus=2

set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab
set autoread            " maybe not this?
"set textwidth=79       " legacy

"set smarttab
set autoindent copyindent
set smartindent         " let's try
set shiftround

"set autochdir           " complete crap
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

" Reload changes to .vimrc automatically. XXX: broken
" autocmd BufWritePost ~/.vimrc source ~/.vimrc

set expandtab
set sw=4
set guifont=Monospace\ 7

set t_Co=256
set background=dark
let g:seoul256_background=233
colorscheme seoul256

set so=16
au BufRead,BufNewFile *.rb set expandtab
au BufRead,BufNewFile *.rb setlocal sw=2 ts=2 sts=2
set updatetime=200

let g:NERDTreeMapOpenInTab = '<Nop>'
let g:NERDTreeMapOpenInTabSilent = '<Nop>'
let g:NERDTreeMapOpenVSplit = '<Nop>'
let g:NERDTreeMapHelp = '<Nop>'

" noremap  <silent> <C-i> :call NERDComment('cc', 'Comment')<CR>
" inoremap <silent> <C-i> :call NERDComment('cc', 'Comment')<CR>
let g:NERDSpaceDelims=1
