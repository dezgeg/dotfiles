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

Bundle 'gmarik/vundle'

Bundle 'altercation/vim-colors-solarized'
Bundle 'Lokaltog/vim-powerline'
"Bundle 'airblade/vim-gitgutter' " broken?
Bundle 'scrooloose/nerdtree'
Bundle 'kien/ctrlp.vim'

Bundle 'junegunn/seoul256.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'tpope/vim-eunuch'
Bundle 'guns/vim-clojure-static'
Bundle 'derekwyatt/vim-scala'
Bundle 'rosenfeld/conque-term'

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

set incsearch hlsearch
set ignorecase infercase smartcase " let's try

set title
set number          " not nonumber
"set numberwidth=2  " necessary?
"set shortmess=atI  " ???
set ruler
set showmode
set showmatch
set matchtime=0
set matchpairs+=<:>
set list listchars=tab:\ \ ,trail:.

if has("wildmenu")
        set wildignore+=*.a,*.o,*.out,*.beam
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

" Dvorak keybinds
no d h
no h j
no t k
no n l
no s :
no S :
no j d
no l n
no L N
no - $
no _ ^
no N <C-w><C-w>
no T <C-w><C-r>
no H 8<Down>
no T 8<Up>
no D <C-w><C-r>

set expandtab
set sw=4
set guifont=Monospace\ 7

set t_Co=256
set background=dark
let g:seoul256_background=233
colorscheme seoul256

set so=16
au BufRead,BufNewFile *.rb set expandtab
au BufRead,BufNewFile *.rb setlocal sw=2 ts=2
set updatetime=200

imap <F1> <Esc>
map  <F1> <Esc>
no Q <Nop>

map <silent> <F2> :NERDTreeToggle<CR>
map <silent> <C-N> :NERDTreeToggle<CR>

noremap <C-L> :cn<CR>
noremap <C-S> :wa<CR>
noremap <C-Q> :q<CR>

let g:NERDTreeMapOpenInTab = '<Nop>'
let g:NERDTreeMapOpenInTabSilent = '<Nop>'
let g:NERDTreeMapOpenVSplit = '<Nop>'
let g:NERDTreeMapHelp = '<Nop>'

" NERD Comment stuff
noremap  <silent> <C-u> :call NERDComment('ci', 'Invert')<CR>
inoremap <silent> <C-u> :call NERDComment('ci', 'Invert')<CR>
" noremap  <silent> <C-i> :call NERDComment('cc', 'Comment')<CR>
" inoremap <silent> <C-i> :call NERDComment('cc', 'Comment')<CR>
let g:NERDSpaceDelims=1
