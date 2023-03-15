let g:default_font="Cascadia Mono:h12"
let &guifont = g:default_font

command! -bar -nargs=0 FontInc :let &guifont = substitute(&guifont,'\d\+$','\=submatch(0)+1','')
command! -bar -nargs=0 FontDec :let &guifont = substitute(&guifont,'\d\+$','\=submatch(0)-1','')
nnoremap <C--> :FontDec<CR>
nnoremap <C-+> :FontInc<CR>
nnoremap <C-0> :execute "Guifont " . g:default_font<CR>
