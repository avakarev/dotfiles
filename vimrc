set nocompatible " Make Vim behave in a more useful way

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       Pathogen                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype off

" List of disabled plugins, prevent pathogen from self-sourcing
let g:pathogen_disabled = ["pathogen","jslint"]
call pathogen#infect()
filetype plugin indent on


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                  Syntax highlighting                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                      Cursor                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set scrolloff=3     " Minimal number of screen lines to keep above and below the cursor
set sidescroll=1    " Minimal number of columns to scroll horizontally
set sidescrolloff=3 " Minimal number of screen columns to keep to the left and to the right of the cursor if 'nowrap' is set

" Ctrl+j moves cursor 5 lines up
nmap <C-j> 5j<CR>
" Ctrl+k moves cursor 5 lines down
nmap <C-k> 5k<CR>

" Highlight current line
if (&t_Co >= 256) || has("gui_running") || ($TERM_PROGRAM == "iTerm.app") || ($COLORTERM == "gnome-terminal")
    set cursorline
endif

" Make cursor shape as line in insert mode and as block in other cases
if $COLORTERM == "gnome-terminal" && has("autocmd")
    " Should work in gnome-terminal >= 2.26
    autocmd InsertEnter          * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape ibeam"
    autocmd InsertLeave,VimLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

function! RestoreCurPrevPos()
    if line("'\"") > 1 && line("'\"") <= line("$")
        execute "normal! g`\"" |
    endif
endfunction

" When editing a file, always jump to the last known cursor position.
autocmd BufReadPost * call RestoreCurPrevPos()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                    Editor behaviour                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set encoding=utf-8 nobomb " BOM often causes trouble
set fileencodings=utf-8,cp1251,koi8-r,cp866
set fileformat=unix       " This affects the <EOL> of the current buffer
set fileformats=unix,dos  " <EOL> formats that will be tried when edition starts

if has("unix")
    " Try to use english locale on every system
    language en_US.UTF-8
endif

set autoread      " Re-read file if it was changed outside of Vim
set ttimeoutlen=0 " The time in ms that is waited for a key code to complete.

" Don't use Ex mode, use Q for formatting
map Q gq

" yy, dd and p works with system clipboard
set clipboard=unnamed " But only 7.03+ version supported

set history=1000    " Remember more commands and search history
set undolevels=1000 " Use many muchos levels of undo

set nobackup   " Disable to make a backup before overwriting a file
set noswapfile " Disable to use a swapfile for the buffer

" For modern standards in :TOhtml output
let html_use_css=1
let use_html=1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                      Appearance                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number    " Enable line numbers
set nowrap    " Do not wrap lines
set showmatch " Show matching parentheses

set visualbell   " Use visual bell instead of beeping
set noerrorbells " Ring the bell (beep or screen flash) for error messages

set lazyredraw " Screen will not be redrawn while executing macros
set ttyfast    " Improves smoothness of redrawing

set winminheight=0 " Minimal height of a window, when it's not the current window
set cmdheight=1    " Number of screen lines to use for the command-line

set foldcolumn=3      " 2 lines of column for fold showing, always
set foldmethod=syntax " The kind of folding used for the current window
set foldlevelstart=99 " Useful to always start editing with no folds closed
set foldenable        " All folds will be closed by default (really not, see foldlevelstart above)

set splitbelow " New window goes below (sp)
set splitright " New window goes right (vs)

" Resize splits when the window is resized
autocmd VimResized * execute "normal! \<c-w>="

" Display extra whitespace, toggle it with list!
set list listchars=tab:»·,trail:·
" set listchars+=eol:¬,extends:>,precedes:<,nbsp:_

" Highlight trailing whitespace, tabs and other invisible characters
" The 'SpecialKey' highlighting will be used for 'nbsp', 'tab' and 'trail'.
highlight SpecialKey ctermfg=77 guifg=#5fdf5f
" And 'NonText' for 'eol', 'extends' and 'precedes'
highlight NonText ctermfg=77 guifg=#5fdf5f

" Highlight string parts that goes over the 80 column limit
highlight OverLength ctermbg=darkgrey ctermfg=lightgrey guibg=#FFD9D9
match OverLength /\%81v.\+/


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                 Statusline & titlestring                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set laststatus=2 " Always show status line
set showmode     " Show the active mode in status line
set showcmd      " Show key commands in status line
set ruler        " Show current position of cursor in status line


" Nice window title
if has('title')
    set title " Show the filename in the window titlebar

    " Restore title on exit to home path instead of default 'Thanks for flying Vim'
    let &titleold = substitute(getcwd(), $HOME, "~", '')

    " Redefine title string format
    set titlestring=
    set titlestring+=%(\ %{expand(\"%:p:~\")}%)%(\ %a%) " fullpath/name of current file
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   Search & Replace                       "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       Completion                         "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Completion options
set completeopt-=preview " annoying window on the top
set completeopt+=longest " do not select the first variant by default
set completeopt+=menuone " always show the completion menu

" Word completion dictionary
set complete+=. " current buffer
set complete+=k " dictionary
set complete+=b " other bufs
set complete+=t " tags

" Hitting TAB in command mode will show possible completions above command line
set wildmenu

" A file that matches with one of these patterns is ignored when completing file or directory names
set wildignore=*.swp,*.bak,*.pyc,*.class


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                      Indentation                         "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         Tabs                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set showtabline=1 " Show tab bar only if there are more than 1 tab

map  <C-l> :tabnext<CR>     " Ctrl+l moves to the next tab
map  <C-h> :tabprevious<CR> " Ctrl+h moves to the previous tab
map  <C-n> :tabnew<CR>      " Ctrl+n creates a new tab


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         Utils                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Prints current file full path
" TODO: use -nargs=? and some optional param to show "%:s" or "%:p"
command ShowPath echo expand("%:p")

" Allows use sudo command if file requires it and was open without it
cmap w!! w !sudo tee % >/dev/null


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         vimrc                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Change the mapleader from \ to ,
let mapleader = ","

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>  " Quickly edit the vimrc file
nmap <silent> <leader>sv :so $MYVIMRC<CR> " Quickly reload the vimrc file


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       NERDTree                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let NERDTreeQuitOnOpen = 1  " Closes the tree window after opening a file
let NERDTreeWinSize    = 45 " Sets the window size when the NERD tree is opened
let NERDTreeMinimalUI  = 1  " Disables display of the 'Bookmarks' label and 'Press ? for help' text
let NERDTreeDirArrows  = 1  " Use arrows instead of + ~ chars when displaying directories
let NERDTreeIgnore     = ['\.git','\.hg','\.svn','\.DS_Store','\.pyc']
let NERDTreeShowHidden = 1

map <C-e> :NERDTreeToggle<CR> " Toggle NERDTree side pane
map <C-x> :NERDTreeFind<CR>   " Find current file in NERDtree

"autocmd VimEnter * NERDTree       " Auto-open NERDTree with vim
"autocmd VimEnter * wincmd p       " Focus main window when vim opens with NERDTree
"autocmd BufEnter * NERDTreeMirror " Auto-open NERDTree with new tab
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function! s:CloseIfOnlyNerdTreeLeft()
    if exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1 && winnr("$") == 1
        q
    endif
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       NERDCommenter                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let NERDSpaceDelims = 1 " Use a space after comment chars
