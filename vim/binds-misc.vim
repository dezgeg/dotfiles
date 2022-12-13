" Annoying
noremap  <F1> <Nop>
inoremap <F1> <Nop>

" Quick save
noremap <C-S> :wa<CR>

" Select pasted text
nnoremap gp `[v`]

" Ctrl-Backspace like readline
nnoremap <C-H> db
inoremap <C-H> <C-W>
cnoremap <C-H> <C-W>

" Alt-Backspace like shell-delete-word (TODO)
inoremap <Esc><Backspace> <C-W>
cnoremap <Esc><Backspace> <C-W>

" Ctrl-Del like readline (TODO how to do in cnoremap)
inoremap <C-Del> <C-o>dw
nnoremap <C-Del> dw
