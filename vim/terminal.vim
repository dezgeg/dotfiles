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

function s:GetFilenameUnderCursor()
    let line = getline(".")

    " Match ls -la output, e.g.
    " -rw-r--r--   1 tmtynkky tmtynkky 10508 la 2020-09-12 20:59:07 .vimrc
    let LS_PATTERN = '^[-drwx]\{10\} \+\d \+\w\+ \+\w\+ \+[0-9.KM]\+ \+\w\+ \+\d\{4}-\d\d-\d\d \d\d:\d\d:\d\d \(.\+\)[/*|]\{0,1\}$'
    let matches = matchlist(line, LS_PATTERN)
    if len(matches) > 0
        return [matches[1]]
    endif

    " Match grep -n output, e.g.:
    " .vimrc:272:    function s:SmartTerminalGoto()
    let GREP_PATTERN = '^\([^:]\+\):\([0-9]\+\)'
    let matches = matchlist(line, GREP_PATTERN)
    if len(matches) > 0
        let file = matches[1]
        let lineno = matches[2]
        return [file, lineno]
    endif

    " Match rg output when on a line number, e.g. second line:
    " .vimrc
    " 272:    function s:SmartTerminalGoto()
    let RG_PATTERN = '^\([0-9]\+\)[:-]'
    let matches = matchlist(line, RG_PATTERN)
    if len(matches) > 0
        let lineno = matches[1]

        " Scan upwards (up to 100 lines) to find the filename to edit
        let term_line = line(".") - 1
        let stop_line = min([term_line - 100, 1])
        while term_line >= stop_line
            let line = getline(term_line)
            let matches = matchlist(line, RG_PATTERN)
            if len(matches) == 0
                " 'line' did not contain line number -> should be filename
                if filereadable(line)
                    return [line, lineno]
                endif
                return
            endif

            let term_line -= 1
        endwhile

    endif
    return []
endfunction

" Smart terminal goto
function s:SmartTerminalGoto()
    if &buftype != "terminal"
        return
    endif
    let result = s:GetFilenameUnderCursor()

    if len(result) == 2
        " filename + line number
        let file = result[0]
        let lineno = result[1]
        let w:terminal_buffer = bufnr('%')
        execute "edit +" . lineno . " " . file
        return
    endif

    if len(result) == 1
        " just filename
        let file = result[0]
        let w:terminal_buffer = bufnr('%')
        execute "edit " . file
        return
    endif
 endfunction

nnoremap <silent> <Return> :call <SID>SmartTerminalGoto()<CR>
