set nocompatible " Make Vim behave in a more useful way


" -------------- [Syntax highlighting] --------------
set background=dark " Text background should be dark
syntax on " Enable syntax highlighting

" To enable 256-color schemes, make sure that terminal supports 256 colors
if &t_Co >= 256 || has("gui_running") || $TERM_PROGRAM == "iTerm.app"
    set t_Co=256 " Enable 256-color mode
    colorscheme xoria256 " Set nice 256-color scheme
else
    colorscheme default
endif

autocmd BufNewFile,BufRead *vimpagerrc* set filetype=vim
autocmd BufNewFile,BufRead *.json set filetype=javascript
autocmd BufNewFile,BufRead *bash_profile* set filetype=sh
autocmd BufNewFile,BufRead *bash/* set filetype=sh
autocmd BufNewFile,BufRead *zsh/* set filetype=zsh


" -------------- [Cursor] --------------

if &t_Co >= 256 || has("gui_running") || $TERM_PROGRAM == "iTerm.app"
    set cursorline " Highlight current line
endif

" Make cursor shape as line in insert mode and as block in other cases
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"


" -------------- [Common] --------------

set wildmenu " Hitting TAB in command mode will show possible completions above command line

set history=1000 " Remember more commands and search history
set undolevels=1000 " Use many muchos levels of undo

" A file that matches with one of these patterns is ignored when completing file or directory names
set wildignore=*.swp,*.bak,*.pyc,*.class

set visualbell   " Use visual bell instead of beeping
set noerrorbells " Ring the bell (beep or screen flash) for error messages

set nobackup " Disable to make a backup before overwriting a file
set noswapfile " Disable to use a swapfile for the buffer

nmap <C-j> 5j<CR> " Ctrl+j moves cursor 5 lines up
nmap <C-k> 5k<CR> " Ctrl+k moves cursor 5 lines down

" Allows use sudo command if file requires it and was open without it
cmap w!! w !sudo tee % >/dev/null

" When editing a file, always jump to the last known cursor position.
autocmd BufReadPost * call RestoreCurPrevPos()

function! RestoreCurPrevPos()
    if line("'\"") > 1 && line("'\"") <= line("$")
        execute "normal! g`\"" |
    endif
endfunction

" Resize splits when the window is resized
autocmd VimResized * execute "normal! \<c-w>="


" -------------- [Remap arrow keys] --------------
if filereadable(expand("~/.vim/cfg/arrow-keys.vimrc"))
    source ~/.vim/cfg/arrow-keys.vimrc
endif


" -------------- [Editor behaviour] --------------

set encoding=utf-8 nobomb " BOM often causes trouble
set fileencodings=utf-8,cp1251
set number " Enable line numbers
set nowrap " Do not wrap lines
set scrolloff=3 " Minimal number of screen lines to keep above and below the cursor
set sidescroll=1 " Minimal number of columns to scroll horizontally
set sidescrolloff=3 " Minimal number of screen columns to keep to the left and to the right of the cursor if 'nowrap' is set
set showmode " Show the active mode in status line
set showmatch " Show matching parentheses
set showcmd " Show key commands in status line
set ruler " Show current position of cursor in status line
set showtabline=1 " Show tab bar only if there are more than 1 tab

" Highlight string parts that goes over the 80 column limit
highlight OverLength ctermbg=darkgrey ctermfg=lightgrey guibg=#FFD9D9
match OverLength /\%81v.\+/


" -------------- [Status line] --------------

set laststatus=2 " Always show status line
set statusline=
set statusline+=%h%m%r%w\                       " status flags
set statusline+=(%n)\                           " buffer number
set statusline+=%t\                             " just filename, without path
set statusline+=[%{strlen(&ft)?&ft:'none'}]\    " file type
set statusline+=[%{&ff}/%{v:lang}]\             " file format / current language
set statusline+=%{strftime(\"%Y-%m-%d\ %T\",getftime(expand(\"\%\%\")))} " last modification time
set statusline+=%=                              " right align remainder
set statusline+=0x%-8B                          " character value
set statusline+=%-12(%l/%L:%c%V%)               " line, character
set statusline+=(%p%%)                          " cursor position in percent

set title " Show the filename in the window titlebar
" Restore title on exit to home path instead of default 'Thanks for flying Vim'
let &titleold = substitute(getcwd(), $HOME, "~", '')

" Nice window title
if has('title') && (has('gui_running') || &title)
    set titlestring=
    set titlestring+=%(\ %{expand(\"%:p:h\")}/%t%)%(\ %a%) " fullpath/name of current fule
    set titlestring+=\ -\ %{v:servername}                  " editor name
endif


" -------------- [Search] --------------

set hlsearch " Highlight search matches
set incsearch " Highlight search matches as you type them
set ignorecase " Case-insensitive searching
set smartcase " If the search pattern contains upper case chars, override 'ignorecase' option
set wrapscan " Set the search scan to wrap around the file
set gdefault " By default add 'g' flag to search/replace. Add 'g' to toggle

" Press space bar to turn off search highlighting and clear any message displayed
nnoremap <silent> <Space> :nohl<Bar>:echo<CR>

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv


" -------------- [Windows] --------------

set splitbelow " New windows goes below (sp)
set splitright " New windows goes right (vs)


" -------------- [Indentation] --------------

set expandtab " Turn tabs to spaces
set tabstop=4 " Number of spaces that a <Tab> in the file counts for
set softtabstop=4 " Number of spaces while editiong
set shiftwidth=4 "Number of spaces to use for each step of (auto)indent
set shiftround " Use multiple of shiftwidth when indenting with '<' and '>'
set smarttab " Be smart about deleting tab space, etc

set autoindent " Indent new line to the level of the previous one
set copyindent " Copy the previous indentation on autoindenting

set backspace=indent,eol,start " Allow backspacing over everything in insert mode

" Highlight trailing whitespace and tabs
" The 'NonText' highlighting will be used for 'eol', 'extends' and 'precedes'.
" 'SpecialKey' for 'nbsp', 'tab' and 'trail'.
highlight SpecialKey ctermfg=DarkGray
" Display extra whitespace, toggle it with list!
set list listchars=tab:»·,trail:·

" Apply filetype-specific indentation and so
autocmd BufNewFile,BufReadPre {GNUMakefile,Makefile,makefile}{,.am,.in} set noexpandtab
autocmd BufNewFile,BufReadPre *.{py,yaml} set tabstop=2 softtabstop=2 shiftwidth=2


" -------------- [Tabs] --------------

map  <C-l> :tabnext<CR> " Ctrl+l moves to the next tab
map  <C-h> :tabprevious<CR> " Ctrl+h moves to the previous tab
map  <C-n> :tabnew<CR> " Ctrl+n creates a new tab


" -------------- [Utils] --------------

" Prints current file full path
" TODO: use -nargs=? and some optional param to show "%:s" or "%:p"
command ShowPath echo expand("%:p")


" -------------- [vimrc] --------------

" Change the mapleader from \ to ,
let mapleader=","

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR> " Quickly edit the vimrc file
nmap <silent> <leader>sv :so $MYVIMRC<CR> " Quickly reload the vimrc file


" -------------- [NERDTree] --------------

let NERDTreeQuitOnOpen = 1 " Closes the tree window after opening a file
let NERDTreeWinSize    = 45 " Sets the window size when the NERD tree is opened
let NERDTreeMinimalUI  = 1 " Disables display of the 'Bookmarks' label and 'Press ? for help' text
let NERDTreeDirArrows  = 1 " Use arrows instead of + ~ chars when displaying directories
let NERDTreeIgnore     = ['\.git','\.hg','\.svn','\.DS_Store']

map <C-e> :NERDTreeToggle<CR> " toggle NERDTree side pane
map <C-x> :NERDTreeFind<CR> " find current file in NERDtree

"autocmd VimEnter * NERDTree " Auto-open NERDTree with vim
"autocmd VimEnter * wincmd p " Focus main window when vim opens with NERDTree
"autocmd BufEnter * NERDTreeMirror " Auto-open NERDTree with new tab
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function! s:CloseIfOnlyNerdTreeLeft()
    if exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1 && winnr("$") == 1
        q
    endif
endfunction


" -------------- [NERDCommenter] --------------

let NERDSpaceDelims = 1  " Use a space after comment chars


" -------------- [Pathogen] --------------

filetype off

" List of disabled plugins, prevent pathogen from self-sourcing
let g:pathogen_disabled = ["pathogen","jslint"]

call pathogen#infect()
filetype plugin indent on
