" Global stuff
set title " Set terminal window title
set number " Line numbers
set shortmess+=atI " Do not show intro and shorten some messages

" Editing
set matchpairs+=<:> " Allow using % on C++ template params
set virtualedit=onemore " Allow moving to last column
set shiftround " Round indentation when using the << or >> commands

" Tabs/spaces configuration
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab

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
