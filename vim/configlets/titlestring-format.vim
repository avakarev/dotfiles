" if file changed, put * at the beginning
set titlestring=
set titlestring+=%(\ %{expand(\"%:p:h\")}/%t%)%(\ %a%) " fullpath/name of current fule
set titlestring+=\ -\ %{v:servername}                  " editor name
