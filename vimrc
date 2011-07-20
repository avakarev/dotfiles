set nocompatible " Make vim more useful

" Set syntax highlighting options
" To enable nice coloring features, make sure your terminal supports 256 colors and 
" set 'report terminal type' as a 'xterm-256color'
if $TERM == "xterm-256color"
    set t_Co=256 "Enable 256-color mode
endif
set background=dark
syntax on

if $TERM == "xterm-256color"
    colorscheme xoria256 "Enable nice 256-color scheme
else
    colorscheme default
endif

" Highlight trailing whitespace and tabs
" The 'NonText' highlighting will be used for 'eol', 'extends' and 'precedes'.
" 'SpecialKey' for 'nbsp', 'tab' and 'trail'.
highlight SpecialKey ctermfg=DarkGray

" Display extra whitespace, toggle it with list!
set list listchars=tab:»·,trail:·

set ruler " Show the cursor position

set expandtab " Expand tabs to spaces
set tabstop=4 " Tab size in whitespaces
set softtabstop=4
set shiftwidth=4

set autoindent " Copy indent from last line when starting new line

if $TERM == "xterm-256color"
    set cursorline " Highlight current line
endif

set encoding=utf-8 nobomb " BOM often causes troublie
set nu " Enable line numbers
set showmode " Show the current mode
set showtabline=2 " Always show tab bar
set laststatus=2 " Always show status line

set title " Show the filename in the window titlebar

" Make cursor shape as line in insert mode and as block in other cases
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
