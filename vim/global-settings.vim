" Global stuff
set mouse=a " Support mouse
set title " Set terminal window title
set number " Line numbers
set shortmess+=atI " Do not show intro and shorten some messages
set undofile " Persistent undo
set termguicolors " 24-bit colors
set timeoutlen=100 " Don't wait ages after some keys
set updatetime=200 " Update time for some plugins
set signcolumn=yes " For gitsigns

" Editing
set matchpairs+=<:> " Allow using % on C++ template params
set virtualedit=onemore " Allow moving to last column
set shiftround " Round indentation when using the << or >> commands

" Tabs/spaces configuration
set shiftwidth=4
set softtabstop=-1 " Use same as shiftwidth
set tabstop=8 " Default
set expandtab

" Wrapping configuration
set breakindent
set showbreak=↳

" Cursor shape
set guicursor=n-v-c-sm:block-blinkon1000-blinkoff100-blinkwait1000
set guicursor+=i-ci-ve:ver25-blinkon1000-blinkoff100-blinkwait1000
set guicursor+=r-cr-o:hor20-blinkon1000-blinkoff100-blinkwait1000

" Whitespace display - https://vim.fandom.com/wiki/Highlight_unwanted_spaces
set list listchars=tab:»·,trail:.
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd VimRC InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd VimRC InsertLeave * match ExtraWhitespace /\s\+$/

" Windowing
set splitbelow splitright " Split logically
set scrolloff=16 " Context lines when scrolling

" Smarter search
set ignorecase infercase smartcase

" Command prompt
set wildmode=longest,list " Make Tab completion work the usual way
if has('nvim')
    set inccommand=nosplit " Real-time update of s/foo/bar
endif
set wildignore+=*.a,*.o,*.d,*.out,*.beam,*.pyc
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
set wildignore+=.DS_Store,.git,.hg,.svn
set wildignore+=*~,*.swp,*.tmp
set wildignore+=*.pdf,*.aux,*.toc,*.blg,*.bbl,*.cls

" Completion (to be tried)
" set completeopt=menu,menuone,preview,noinsert
