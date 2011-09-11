set hlsearch   " Highlight search matches
set incsearch  " Highlight search matches as you type them
set ignorecase " Case-insensitive searching
set smartcase  " If the search pattern contains upper case chars, override 'ignorecase' option
set wrapscan   " Set the search scan to wrap around the file
set gdefault   " By default add 'g' flag to search/replace. Add 'g' to toggle

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Press space bar to turn off search highlighting and clear any message displayed
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
