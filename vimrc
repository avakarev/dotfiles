set nocompatible " Make Vim behave in a more useful way

" Set syntax highlighting options
" To enable nice coloring features, make sure your terminal supports 256 colors and 
" set 'report terminal type' as a 'xterm-256color'
if $TERM == "xterm-256color"
    set t_Co=256 " Enable 256-color mode
endif
set background=dark
syntax on

if $TERM == "xterm-256color"
    colorscheme xoria256 " Enable nice 256-color scheme
else
    colorscheme default
endif

" Highlight trailing whitespace and tabs
" The 'NonText' highlighting will be used for 'eol', 'extends' and 'precedes'.
" 'SpecialKey' for 'nbsp', 'tab' and 'trail'.
highlight SpecialKey ctermfg=DarkGray

" Display extra whitespace, toggle it with list!
set list listchars=tab:»·,trail:·

set ruler " Show current position of cursor in status line

set expandtab " Turn tabs to spaces
set tabstop=4 " Number of spaces that a <Tab> in the file counts for
set softtabstop=4 " Number of spaces while editiong
set shiftwidth=4 "Number of spaces to use for each step of (auto)indent
set smarttab " Be smart about deleting tab space, etc

set autoindent " Indent new line to the level of the previous one
set copyindent " Copy the previous indentation on autoindenting

if $TERM == "xterm-256color"
    set cursorline " Highlight current line
endif

set encoding=utf-8 nobomb " BOM often causes trouble
set number " Enable line numbers

set nowrap " Do not wrap lines
set showmode " Show the active mode in status line
set showmatch " Show matching parentheses
set showcmd " Show key commands in status line
set showtabline=2 " Always show tab bar
set laststatus=2 " Always show status line

set hlsearch " Highlight search matches
set incsearch " Highlight search matches as you type them
set ignorecase " Case-insensitive searching
set smartcase " If the search pattern contains upper case chars, override 'ignorecase' option
set wrapscan " Set the search scan to wrap around the file
set gdefault " By default add 'g' flag to search/replace. Add 'g' to toggle

" Press space bar to turn off search highlighting and clear any message displayed
nnoremap <silent> <Space> :nohl<Bar>:echo<CR>

set splitbelow " New window goes below (sp)
set splitright " New windows goes right (vs)

set wildmenu " Hitting TAB in command mode will show possible completions above command line

set title " Show the filename in the window titlebar

" Make cursor shape as line in insert mode and as block in other cases
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" Restore title on exit to home path instead of default 'Thanks for flying Vim'
let &titleold = substitute(getcwd(), $HOME, "~", '')

" Setup indentation according to passed value
function s:SetIndentation (ts)
    set expandtab
    let &tabstop = a:ts
    let &softtabstop = a:ts
    let &shiftwidth = a:ts
endfunction

" Set special indentation for particular filetype
function s:CheckIndentation (type)
    if a:type == "Makefile"
        " Use tabs for makefiles
        set noexpandtab " Use tabs instead of whitespaces for makefiles
    elseif a:type == "py" || a:type == "yaml" " Use only 2 spaces for Python and YAML files
        call s:SetIndentation(2)
    else " 4 spaces every where else
        call s:SetIndentation(4)
    endif
endfunction

autocmd BufNewFile,BufReadPre {GNUMakefile,Makefile,makefile}{,.am,.in} call s:CheckIndentation("Makefile")
autocmd BufNewFile,BufReadPre *.{py} call s:CheckIndentation("Makefile")
autocmd BufNewFile,BufReadPre *.{yaml} call s:CheckIndentation("yaml")

map  <C-l> :tabn<CR> " Ctrl+l moves to the next tab
map  <C-h> :tabp<CR> " Ctrl+h moves to the previous tab
map  <C-n> :tabnew<CR> " Ctrl+n creates a new tab
