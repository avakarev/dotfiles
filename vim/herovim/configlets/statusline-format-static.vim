if exists("loaded_herovim_statusline_format_dynamic")
    finish
endif
let loaded_herovim_statusline_format_static = 1


set laststatus=2 " Always show status line
set showmode     " Show the active mode in status line
set showcmd      " Show key commands in status line
set ruler        " Show current position of cursor in status line

set statusline=
set statusline+=%h%m%r%w\                       " status flags
set statusline+=(%n)\                           " buffer number
set statusline+=%t\                             " just filename, without path
set statusline+=[%{strlen(&ft)?&ft:'none'}]\    " file type
set statusline+=[%{&ff}/%{v:lang}]\             " file format / current language
set statusline+=%{fugitive#statusline()}\       " SCM status

" current file modification date/time
set statusline+=%{strftime(\"%Y-%m-%d\ %T\",getftime(expand(\"\%\%\")))}

set statusline+=%=                              " right align remainder

set statusline+=0x%-8B                          " character value
set statusline+=%-12(%l/%L:%c%V%)               " line, character
set statusline+=(%p%%)                          " cursor position in percent
