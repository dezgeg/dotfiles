" Dvorak homerow
" Keep t/T as 'till char' in visual/operator-pending mode
noremap d h
noremap h j
nnoremap t k
vnoremap t k
noremap n l

" Shifted Dvorak homerow navigation
noremap H 8<Down>
nnoremap T 8<Up>
vnoremap T 8<Up>

" Window switching
noremap D <C-w><C-W>
noremap N <C-w><C-w>

" Remap useful keys lost by Dvorak binds
noremap j d
noremap l n
noremap L N

" Easier to enter ex mode
nnoremap ; :
vnoremap ; :
