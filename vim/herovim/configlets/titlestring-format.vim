set title " Show the filename in the window titlebar

" Restore title on exit to home path instead of default 'Thanks for flying Vim'
let &titleold = substitute(getcwd(), $HOME, "~", '')

" Redefine title string format
set titlestring=
set titlestring+=%(\ %{expand(\"%:p:~\")}%)%(\ %a%) " fullpath/name of current file
set titlestring+=\ -\ %{v:servername}               " editor name
