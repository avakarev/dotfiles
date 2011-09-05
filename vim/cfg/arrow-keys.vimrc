" The `Up` arrow key deletes a blank line above the current line (a non-empty line will not be deleted),
" while the `Down` arrow key inserts a blank line above the current line.
" The result is hitting `Up` or `Down` moves the current line up or down, in both normal as well as insert mode.
"
" Typing `Ctrl-Up` and `Ctrl-Down`, instead, deletes or inserts a blank line below the current line.
" The result is that the text below the current line moves up or down, respectively.
"
" Typing `Left` de-dents the current line, while `Right` indents it.
" The result is that text shifts left and right, respectively.

function! DelEmptyLineAbove()
    if line(".") == 1
        return
    endif
    let l:line = getline(line(".") - 1)
    if l:line =~ '^\s*$'
        let l:colsave = col(".")
        .-1d
        silent normal! <C-y>
        call cursor(line("."), l:colsave)
    endif
endfunction

function! AddEmptyLineAbove()
    let l:scrolloffsave = &scrolloff
    " Avoid jerky scrolling with ^E at top of window
    set scrolloff=0
    call append(line(".") - 1, "")
    if winline() != winheight(0)
        silent normal! <C-e>
    endif
    let &scrolloff = l:scrolloffsave
endfunction

function! DelEmptyLineBelow()
    if line(".") == line("$")
        return
    endif
    let l:line = getline(line(".") + 1)
    if l:line =~ '^\s*$'
        let l:colsave = col(".")
        .+1d
        ''
        call cursor(line("."), l:colsave)
    endif
endfunction

function! AddEmptyLineBelow()
    call append(line("."), "")
endfunction

" Arrow key remapping: Up/Dn = move line up/dn; Left/Right = indent/unindent
function! SetArrowKeysAsTextShifters()
    " Normal mode
    nmap <silent> <Left> <<
    nmap <silent> <Right> >>
    nnoremap <silent> <Up> <Esc>:call DelEmptyLineAbove()<CR>
    nnoremap <silent> <Down>  <Esc>:call AddEmptyLineAbove()<CR>
    nnoremap <silent> <C-Up> <Esc>:call DelEmptyLineBelow()<CR>
    nnoremap <silent> <C-Down> <Esc>:call AddEmptyLineBelow()<CR>

    " Visual mode
    vmap <silent> <Left> <
    vmap <silent> <Right> >
    vnoremap <silent> <Up> <Esc>:call DelEmptyLineAbove()<CR>gv
    vnoremap <silent> <Down>  <Esc>:call AddEmptyLineAbove()<CR>gv
    vnoremap <silent> <C-Up> <Esc>:call DelEmptyLineBelow()<CR>gv
    vnoremap <silent> <C-Down> <Esc>:call AddEmptyLineBelow()<CR>gv

    " Insert mode
    imap <silent> <Left> <C-D>
    imap <silent> <Right> <C-T>
    inoremap <silent> <Up> <Esc>:call DelEmptyLineAbove()<CR>a
    inoremap <silent> <Down> <Esc>:call AddEmptyLineAbove()<CR>a
    inoremap <silent> <C-Up> <Esc>:call DelEmptyLineBelow()<CR>a
    inoremap <silent> <C-Down> <Esc>:call AddEmptyLineBelow()<CR>a

    " Disable modified versions we are not using
    nnoremap  <S-Up>     <NOP>
    nnoremap  <S-Down>   <NOP>
    nnoremap  <S-Left>   <NOP>
    nnoremap  <S-Right>  <NOP>
    vnoremap  <S-Up>     <NOP>
    vnoremap  <S-Down>   <NOP>
    vnoremap  <S-Left>   <NOP>
    vnoremap  <S-Right>  <NOP>
    inoremap  <S-Up>     <NOP>
    inoremap  <S-Down>   <NOP>
    inoremap  <S-Left>   <NOP>
    inoremap  <S-Right>  <NOP>
endfunction

call SetArrowKeysAsTextShifters()
