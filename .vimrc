" Vundle
if !isdirectory(expand("~/.vim/bundle/Vundle.vim"))
    !mkdir -p ~/.vim/bundle
    !git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    let s:bootstrap=1
endif
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
if !has('nvim')
  Plugin 'noahfrederick/vim-neovim-defaults'
endif
Plugin 'godlygeek/tabular'
Plugin 'itchyny/lightline.vim'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/gv.vim'
Plugin 'junegunn/seoul256.vim'
Plugin 'mbbill/undotree'
" Plugin 'michaeljsmith/vim-indent-object' broken?
Plugin 'mileszs/ack.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tikhomirov/vim-glsl'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'vim-scripts/argtextobj.vim'
call vundle#end()
filetype plugin indent on

if exists("s:bootstrap") && s:bootstrap
    unlet s:bootstrap
    BundleInstall
endif

augroup VimRC
    autocmd!
augroup END

" Colorscheme
source ~/dotfiles/vim/colorscheme.vim
source ~/dotfiles/vim/binds-dvorak.vim
source ~/dotfiles/vim/binds-misc.vim
source ~/dotfiles/vim/global-settings.vim

source ~/dotfiles/vim/lightline.vim
source ~/dotfiles/vim/terminal.vim
source ~/dotfiles/vim/tweaks.vim

source ~/dotfiles/vim/smart-paren.vim
source ~/dotfiles/vim/nerdcommenter.vim

source ~/.ideavimrc

" Various global options
set formatoptions+=n " Do not make mess of numbered lists when using gq
set undofile

" Various editing options
set copyindent " Autoindent?

set mouse=a

set timeoutlen=100
set updatetime=200
" set clipboard=unnamed,autoselect

" Navigation in insert mode
" Alt-{dhtn, bw}: as usual
" Alt-{0^}: ^ and $
inoremap <A-d> <Left>
inoremap <A-h> <Down>
inoremap <A-t> <Up>
inoremap <A-n> <Right>
inoremap <A-b> <C-Left>
inoremap <A-w> <C-Right>
inoremap <A-^> <Home>
inoremap <A-$> <End>

" And command-line mode as well.
cnoremap <A-d> <Left>
cnoremap <A-h> <Down>
cnoremap <A-t> <Up>
cnoremap <A-n> <Right>
cnoremap <A-b> <C-Left>
cnoremap <A-w> <C-Right>
cnoremap <A-^> <Home>
cnoremap <A-$> <End>

" Indent changes in insert mode (does not work in terminal!)
inoremap <C-,> <C-D>
inoremap <C-.> <C-T>

" Sane paste
inoremap <C-p> <C-g>u<C-r>"
cnoremap <C-p> <C-g>u<C-r>"

" Undo
inoremap <C-u> <C-o>u
cnoremap <C-u> <C-o>u

" Repeat command for each line in selection
xnoremap <silent> . :normal .<CR>

" Tabs
nnoremap <C-Left> gT
nnoremap <C-Right> gt

" Jumplist navigation: Ctrl-{Left,Right), Alt-[dn]
nnoremap <M-Left>  <C-o>
nnoremap <M-Right> <C-i>
vnoremap <M-Left>  <C-o>
vnoremap <M-Right> <C-i>
nnoremap <M-d> <C-o>
nnoremap <M-n> <C-i>
vnoremap <M-d> <C-o>
vnoremap <M-n> <C-i>

" Git
noremap gs :Gstatus<CR>
noremap gd :Gdiff<CR>

" Undotree
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1

function! g:Undotree_CustomMap()
    nmap <buffer> H <plug>UndotreePreviousState
    nmap <buffer> T <plug>UndotreeNextState
endfunction

noremap <silent> <C-u> :UndotreeToggle<CR>

" fzf
" Use --hidden with rg
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --hidden -- ".shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)
noremap <C-E> :Files<CR>
noremap <C-G> :Rg<CR>
noremap <C-F> :Buffers<CR>
" Make ESC cancel (override global Esc map)
autocmd VimRC FileType fzf tnoremap <buffer> <Esc> <Esc>
let g:fzf_history_dir = '~/.local/share/fzf-history'

" If closing an editor window opened from terminal, focus back that same terminal
function s:SmartWindowClose()
    if exists('w:terminal_buffer')
        let current_buffer = bufnr("%")
        setlocal bufhidden=delete
        execute "buffer " . w:terminal_buffer
        unlet w:terminal_buffer
        startinsert
    else
        if exists('g:GuiLoaded') && winnr("$") == 1 && tabpagenr("$") == 1
            echo "Not closing last window!"
        else
            q
        end
    endif
endfunction
nnoremap <silent> <C-Q> :call <SID>SmartWindowClose()<CR>

" u/U in visual mode to search for the current selection (mnemoic: use)
function! s:SearchForSelection(dir)
    let old = @"
    normal! gvy

    let regex = '\V' .. escape(@", '/\')

    let @" = old
    let @/ = regex
    execute 'normal! ' .. a:dir .. regex .. "\r"
endfunction

vnoremap u :call <SID>SearchForSelection('/')<CR>
vnoremap U :call <SID>SearchForSelection('?')<CR>

if exists("g:neovide")
    source ~/dotfiles/vim/neovide.vim
endif

" TODO:
" http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
" http://vimcasts.org/episodes/undo-branching-and-gundo-vim/
" http://vimcasts.org/episodes/fugitive-vim---a-complement-to-command-line-git/
