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

"set statusline=%<%f\ %h%m%r%=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%k\ %-14.(%l,%c%V%)\ %P
