if exists("loaded_herovim_statusline_format_static")
    finish
endif
let loaded_herovim_statusline_format_dynamic = 1

function! s:UpdateStatusLine(isEnter)
    " TODO: try to compare length of status line with actual window width instead of hardcoding
    let l:isFull = winwidth(0) >= 120
    let l:isSlim = winwidth(0) <= 52

    let l:ret = ""

    let ret .= "%h%m%r%w"                     " status flags
    let ret .= "(%n)"                         " buffer number
    let ret .= exists("g:HEROVIM_COLORS_LOADED") ? "%1*" : ""
    let ret .= " %t"                          " just filename, without path
    let ret .= exists("g:HEROVIM_COLORS_LOADED") ? "%3*" : ""
    let ret .= " [%{strlen(&ft)?&ft:'none'}]" " file type

    " file format / current language (in not full mode only file format)
    let ret .= isFull ? " [%{&ff}/%{v:lang}]" : (isSlim ? "" : " [%{&ff}]")

    " SCM info: current branch and so (on in slim mode)
    let ret .= isSlim ? "" : " %{fugitive#statusline()}"

    " current file modification date/time (only in full mode)
    let ret .= isFull ? " %{strftime(\"%Y-%m-%d\ %T\",getftime(expand(\"\%\%\")))}" : ""

    let ret .= "%="      " right align remainder

    " character value (only in full mode)
    let ret .= isFull ? " 0x%-8B" : ""

    " line, character position (in not full mode only lines)
    let ret .= isSlim ? " %l/%L" : " %-12(%l/%L:%c%V%)"

    let ret .= " (%p%%)" " cursor position in percent

    let &l:stl = l:ret
endfunction

autocmd BufWinEnter,WinEnter,CmdwinEnter,CursorHold,CursorHoldI,BufWritePost * call <SID>UpdateStatusLine(1)
autocmd WinLeave * call <SID>UpdateStatusLine(0)
