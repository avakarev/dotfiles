set nocompatible " Make Vim behave in a more useful way


" -------------- [Syntax highlighting] --------------
set background=dark " Text background should be dark
syntax on " Enable syntax highlighting

" To enable 256-color schemes, make sure that terminal supports 256 colors
if &t_Co >= 256 || has("gui_running") || $TERM_PROGRAM == "iTerm.app" || $COLORTERM == "gnome-terminal"
    set t_Co=256         " Enable 256-color mode
    colorscheme xoria256 " Set nice 256-color scheme
else
    colorscheme default
endif

source ~/.vim/herovim/herovim.vim

autocmd BufNewFile,BufRead *vimpagerrc* set filetype=vim
autocmd BufNewFile,BufRead *.json set filetype=javascript
autocmd BufNewFile,BufRead *bash_profile* set filetype=sh
autocmd BufNewFile,BufRead *bash/* set filetype=sh
autocmd BufNewFile,BufRead *zsh/* set filetype=zsh


" -------------- [Cursor] --------------

call herovim#include("cursor")


" -------------- [Common] --------------

set wildmenu " Hitting TAB in command mode will show possible completions above command line

" A file that matches with one of these patterns is ignored when completing file or directory names
set wildignore=*.swp,*.bak,*.pyc,*.class

set history=1000    " Remember more commands and search history
set undolevels=1000 " Use many muchos levels of undo

set nobackup   " Disable to make a backup before overwriting a file
set noswapfile " Disable to use a swapfile for the buffer

" Allows use sudo command if file requires it and was open without it
cmap w!! w !sudo tee % >/dev/null

" For modern standards in :TOhtml output
let html_use_css=1
let use_html=1


" -------------- [Remap arrow keys] --------------

call herovim#include("arrow-keys")


" -------------- [Map func keys] --------------

call herovim#include("func-keys")


" -------------- [Editor behaviour] --------------

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

" Highlight string parts that goes over the 80 column limit
highlight OverLength ctermbg=darkgrey ctermfg=lightgrey guibg=#FFD9D9
match OverLength /\%81v.\+/

" Don't use Ex mode, use Q for formatting
map Q gq


" -------------- [Statusline/titlestring] --------------

set laststatus=2 " Always show status line
set showmode     " Show the active mode in status line
set showcmd      " Show key commands in status line
set ruler        " Show current position of cursor in status line

" More informative status line
if has("statusline")
    call herovim#include("statusline-format-dynamic")
endif

" Nice window title
if has('title') && (has('gui_running') || &title)
    call herovim#include("titlestring-format")
endif


" -------------- [Search] --------------

call herovim#include("search")


" -------------- [Windows] --------------

set splitbelow " New windows goes below (sp)
set splitright " New windows goes right (vs)

" Resize splits when the window is resized
autocmd VimResized * execute "normal! \<c-w>="


" -------------- [Completion] --------------

call herovim#include("completion")


" -------------- [Indentation] --------------

set expandtab     " Turn tabs to spaces
set tabstop=4     " Number of spaces that a <Tab> in the file counts for
set softtabstop=4 " Number of spaces while editiong
set shiftwidth=4  " Number of spaces to use for each step of (auto)indent
set shiftround    " Use multiple of shiftwidth when indenting with '<' and '>'
set smarttab      " Be smart about deleting tab space, etc

set autoindent " Indent new line to the level of the previous one
set copyindent " Copy the previous indentation on autoindenting

set backspace=indent,eol,start " Allow backspacing over everything in insert mode
" Display extra whitespace, toggle it with list!
set list listchars=tab:»·,trail:·
" set listchars+=eol:¬,extends:>,precedes:<,nbsp:_

" Highlight trailing whitespace, tabs and other invisible characters
" The 'NonText' highlighting will be used for 'eol', 'extends' and 'precedes'
" 'SpecialKey' for 'nbsp', 'tab' and 'trail'.
highlight SpecialKey ctermfg=77 guifg=#5fdf5f
highlight NonText    ctermfg=77 guifg=#5fdf5f

" Apply filetype-specific indentation and so
autocmd BufNewFile,BufReadPre {GNUMakefile,Makefile,makefile}{,.am,.in} set noexpandtab
autocmd BufNewFile,BufReadPre *.{py,yaml} set tabstop=2 softtabstop=2 shiftwidth=2


" -------------- [Tabs] --------------

set showtabline=1   " Show tab bar only if there are more than 1 tab

map  <C-l> :tabnext<CR>     " Ctrl+l moves to the next tab
map  <C-h> :tabprevious<CR> " Ctrl+h moves to the previous tab
map  <C-n> :tabnew<CR>      " Ctrl+n creates a new tab


" -------------- [Utils] --------------

" Prints current file full path
" TODO: use -nargs=? and some optional param to show "%:s" or "%:p"
command ShowPath echo expand("%:p")


" -------------- [vimrc] --------------

" Change the mapleader from \ to ,
let mapleader = ","

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>  " Quickly edit the vimrc file
nmap <silent> <leader>sv :so $MYVIMRC<CR> " Quickly reload the vimrc file


" -------------- [NERDTree] --------------

call herovim#include("nerdtree")


" -------------- [NERDCommenter] --------------

let NERDSpaceDelims = 1 " Use a space after comment chars


" -------------- [Pathogen] --------------

filetype off

" List of disabled plugins, prevent pathogen from self-sourcing
let g:pathogen_disabled = ["pathogen","jslint"]

call pathogen#infect()
filetype plugin indent on
