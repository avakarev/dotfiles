set scrolloff=3     " Minimal number of screen lines to keep above and below the cursor
set sidescroll=1    " Minimal number of columns to scroll horizontally
set sidescrolloff=3 " Minimal number of screen columns to keep to the left and to the right of the cursor if 'nowrap' is set

nmap <C-j> 5j<CR> " Ctrl+j moves cursor 5 lines up
nmap <C-k> 5k<CR> " Ctrl+k moves cursor 5 lines down

" Highlight current line
if (&t_Co >= 256) || has("gui_running") || ($TERM_PROGRAM == "iTerm.app") || ($COLORTERM == "gnome-terminal")
    set cursorline
endif

" Make cursor shape as line in insert mode and as block in other cases
if $COLORTERM == "gnome-terminal" && has("autocmd")
    " Should work in gnome-terminal >= 2.26
    autocmd InsertEnter          * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape ibeam"
    autocmd InsertLeave,VimLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

function! RestoreCurPrevPos()
    if line("'\"") > 1 && line("'\"") <= line("$")
        execute "normal! g`\"" |
    endif
endfunction

" When editing a file, always jump to the last known cursor position.
autocmd BufReadPost * call RestoreCurPrevPos()
