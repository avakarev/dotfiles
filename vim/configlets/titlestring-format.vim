" if file changed, put * at the beginning
set titlestring=
set titlestring+=%(\ %{expand(\"%:p:~\")}%)%(\ %a%) " fullpath/name of current file
set titlestring+=\ -\ %{v:servername}               " editor name
