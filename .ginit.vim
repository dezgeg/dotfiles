Guifont DejaVu Sans Mono:h11
GuiScrollBar 1
call GuiClipboard()
call GuiWindowMaximized(1)
nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
vnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>

" No minimize on Ctrl-Z thank you.
nnoremap <C-Z> <Nop>

" Paste (TODO: get C-S-V working)
inoremap <C-V> <C-R>*
cnoremap <C-V> <C-R>*
tnoremap <C-V> <C-\><C-N>"*pi

" X11 selection
vnoremap <LeftRelease> "*ygv

" Fix middle click paste in terminal mode
tnoremap <MiddleMouse> <C-\><C-N>"*pi
tnoremap <MiddleRelease> <Nop>
