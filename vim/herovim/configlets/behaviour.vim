set encoding=utf-8 nobomb " BOM often causes trouble
set fileencodings=utf-8,cp1251,koi8-r,cp866
set fileformat=unix       " This affects the <EOL> of the current buffer
set fileformats=unix,dos  " <EOL> formats that will be tried when edition starts

if has("unix")
    " Try to use english locale on every system
    language en_US.UTF-8
endif

set autoread        " Re-read file if it was changed outside of Vim
set ttimeoutlen=0

set number          " Enable line numbers
set nowrap          " Do not wrap lines
set showmatch       " Show matching parentheses

set visualbell   " Use visual bell instead of beeping
set noerrorbells " Ring the bell (beep or screen flash) for error messages

" Display extra whitespace, toggle it with list!
set list listchars=tab:»·,trail:·
" set listchars+=eol:¬,extends:>,precedes:<,nbsp:_

" Highlight trailing whitespace, tabs and other invisible characters
" The 'NonText' highlighting will be used for 'eol', 'extends' and 'precedes'
" 'SpecialKey' for 'nbsp', 'tab' and 'trail'.
highlight SpecialKey ctermfg=77 guifg=#5fdf5f
highlight NonText    ctermfg=77 guifg=#5fdf5f

" Highlight string parts that goes over the 80 column limit
highlight OverLength ctermbg=darkgrey ctermfg=lightgrey guibg=#FFD9D9
match OverLength /\%81v.\+/

" Don't use Ex mode, use Q for formatting
map Q gq

set splitbelow " New window goes below (sp)
set splitright " New window goes right (vs)

" Resize splits when the window is resized
autocmd VimResized * execute "normal! \<c-w>="

" yy, dd and p works with system clipboard
set clipboard=unnamed " But only 7.03+ version supported

set history=1000    " Remember more commands and search history
set undolevels=1000 " Use many muchos levels of undo

set nobackup   " Disable to make a backup before overwriting a file
set noswapfile " Disable to use a swapfile for the buffer


" For modern standards in :TOhtml output
let html_use_css=1
let use_html=1
