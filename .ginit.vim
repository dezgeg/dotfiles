let g:default_font="DejaVu Sans Mono:h11"
execute "Guifont " . g:default_font
GuiScrollBar 1
call GuiClipboard()
call GuiWindowMaximized(1)
nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
vnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>

" No minimize on Ctrl-Z thank you.
nnoremap <C-Z> <Nop>

" Paste (TODO: get C-S-V working)
inoremap <C-V> <C-R>+
cnoremap <C-V> <C-R>+
tnoremap <C-V> <C-\><C-N>"+pi

" X11 selection
vnoremap <LeftRelease> "*ygv

" Fix middle click paste in terminal mode
tnoremap <MiddleMouse> <C-\><C-N>"*pi
tnoremap <MiddleRelease> <Nop>

command! -bar -nargs=0 FontInc :let &guifont = substitute(&guifont,'\d\+$','\=submatch(0)+1','')
command! -bar -nargs=0 FontDec :let &guifont = substitute(&guifont,'\d\+$','\=submatch(0)-1','')
nnoremap <C--> :FontDec<CR>
nnoremap <C-+> :FontInc<CR>
nnoremap <C-0> :execute "Guifont " . g:default_font<CR>
