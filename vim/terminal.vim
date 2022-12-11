if !has('nvim')
    finish
endif

" Esc to leave insert mode
tnoremap <Esc> <C-\><C-n>

" Enter insert mode in terminals by default
autocmd VimRC TermOpen * startinsert

" Sync working directory every time insert mode is left
" TODO: should this be buffer local?
" TODO: does soething depend on this
function s:UpdateTerminalWorkingDirectory()
    if exists('b:terminal_job_pid')
        let cwd = resolve('/proc/' . b:terminal_job_pid . '/cwd')
        if isdirectory(cwd)
            execute 'cd ' . fnameescape(cwd)
        endif
    endif
endfunction
autocmd VimRC TermLeave * call <SID>UpdateTerminalWorkingDirectory()
