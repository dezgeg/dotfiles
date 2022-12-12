" In diff mode, go to next/previous diff hunk
" In terminal mode, go to next/previous prompt occurrence
function s:SmartParen(key, mode)
    " Re-enter visual mode as binding exited it
    if a:mode == 'v'
        normal! gv
    endif

    " Go to prev/next diff hunk
    if &diff
        if a:key == '('
            normal! [c
        else
            normal! ]c
        endif
        return
    endif

    " Go to prev/next prompt occurrence
    if &buftype == "terminal"
        " Don't wrap
        let flags = 'W'
        if a:key == '('
            " Search backwards
            let flags ..= 'b'
        endif

        let pat = '^┊[^$#]\+[#$] *'
        let cur_lineno = line(".")
        let found_lineno = search(pat, flags)

        " If search moved to the current line then search again
        if cur_lineno == found_lineno
            let found_lineno = search(pat, flags)
        endif
        if found_lineno != 0
            let line_text = getline(found_lineno)
            let matched = matchstr(line_text, pat)
            call cursor(found_lineno, 1 + len(matched))
        endif
        return
    endif

    " Fall back to default
    if a:key == '('
        normal! (
    else
        normal! )
    endif
endfunction

nnoremap <silent> ( :call <SID>SmartParen('(', 'n')<CR>
nnoremap <silent> ) :call <SID>SmartParen(')', 'n')<CR>
vnoremap <silent> ( :call <SID>SmartParen('(', 'v')<CR>
vnoremap <silent> ) :call <SID>SmartParen(')', 'v')<CR>
