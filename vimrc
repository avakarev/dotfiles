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




" -------------- [Map func keys] --------------

call herovim#include("func-keys")


" -------------- [Editor behaviour] --------------

call herovim#include("behaviour")


" -------------- [Statusline/titlestring] --------------

set laststatus=2 " Always show status line
set showmode     " Show the active mode in status line
set showcmd      " Show key commands in status line
set ruler        " Show current position of cursor in status line


" Nice window title
if has('title') && (has('gui_running') || &title)
    call herovim#include("titlestring-format")
endif


" -------------- [Search] --------------

call herovim#include("search")


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

" Apply filetype-specific indentation and so
autocmd BufNewFile,BufReadPre {GNUMakefile,Makefile,makefile}{,.am,.in} set noexpandtab
autocmd BufNewFile,BufReadPre *.{py,yaml} set tabstop=2 softtabstop=2 shiftwidth=2


" -------------- [Tabs] --------------

set showtabline=1 " Show tab bar only if there are more than 1 tab

map  <C-l> :tabnext<CR>     " Ctrl+l moves to the next tab
map  <C-h> :tabprevious<CR> " Ctrl+h moves to the previous tab
map  <C-n> :tabnew<CR>      " Ctrl+n creates a new tab


" -------------- [Utils] --------------

" Prints current file full path
" TODO: use -nargs=? and some optional param to show "%:s" or "%:p"
command ShowPath echo expand("%:p")

" Allows use sudo command if file requires it and was open without it
cmap w!! w !sudo tee % >/dev/null

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
