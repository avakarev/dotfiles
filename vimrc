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

" Custom filetype settings
autocmd BufNewFile,BufRead *vimpagerrc* set filetype=vim
autocmd BufNewFile,BufRead *.json set filetype=javascript
autocmd BufNewFile,BufRead *bash_profile* set filetype=sh
autocmd BufNewFile,BufRead *bash/* set filetype=sh
autocmd BufNewFile,BufRead *zsh/* set filetype=zsh

" Easy filetype switching
nnoremap _m :set filetype=markdown<CR>
nnoremap _l :set filetype=lua<CR>
nnoremap _x :set filetype=xml<CR>
nnoremap _j :set filetype=javascript<CR>
nnoremap _t :set filetype=tt2<CR>
nnoremap _v :set filetype=vim<CR>
nnoremap _s :set filetype=sh<CR>
nnoremap _h :set filetype=html<CR>
nnoremap _p :set filetype=python<CR>
nnoremap _r :set filetype=ruby<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                      Cursor                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set scrolloff=3     " Minimal number of screen lines to keep above and below the cursor
set sidescroll=1    " Minimal number of columns to scroll horizontally
set sidescrolloff=3 " Minimal number of screen columns to keep to the left and to the right of the cursor if 'nowrap' is set

" Ctrl+j moves cursor 5 lines up
noremap <C-j> 5j<CR>
" Ctrl+k moves cursor 5 lines down
noremap <C-k> 5k<CR>

" Differs from 'j' and 'k' when lines wrap, because it's not linewise
noremap j gj
noremap k gk

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

set secure      " Disable shell scripts in ./.vimrc
set nomodeline  " Disable setting vim mode from documents
set modelines=0 " Disable vim modelines parser

set encoding=utf-8 nobomb " BOM often causes trouble
set fileencodings=utf-8,cp1251,koi8-r,cp866
set fileformat=unix       " This affects the <EOL> of the current buffer
set fileformats=unix,dos  " <EOL> formats that will be tried when edition starts

if has("unix")
    " Try to use english locale on every system
    language en_US.UTF-8
endif

set autoread " Re-read file if it was changed outside of Vim

" Do not write contents of the file automatically
set noautowrite
set noautowriteall

set hidden         " When a buffer is brought to foreground, remember undo history and marks
set ttimeoutlen=50 " The time in ms that is waited for a key code to complete

let mapleader = "," " Change the mapleader from \ to ,

set whichwrap+=h,l  " Make possible navigate between line in curson on first/last position
set backspace=indent,eol,start " Allow backspacing over everything in insert mode

" Don't use Ex mode, use Q for formatting
nnoremap Q gqap
vnoremap Q gq

" Toggle command mode by hitting Enter key
nmap <CR> :

" Yanking/deleting till end of the line
nnoremap Y y$
nnoremap D d$
nnoremap C c$

" Toggle variable and report the change:
"  paste
nnoremap <leader>tp :set invpaste paste?<CR>
"  wrap
nnoremap <leader>tw :set invwrap wrap?<CR>
"  list
nnoremap <leader>tl :set invlist list?<CR>
"  highlighting of search matches
nnoremap <leader>th :set invhls hls?<CR>
"  numbers
nnoremap <leader>tn :set number!<Bar> set number?<CR>
"  spell
nnoremap <leader>ts :set spell! <Bar> set spell?<CR>
"  relative number
if exists("&relativenumber")
    nnoremap <leader>tr :set relativenumber!<Bar> set relativenumber?<CR>
endif
"  highlighting of overlength
nnoremap <leader>to :call ToggleOverLengthHi()<CR>
function! ToggleOverLengthHi()
    if exists("b:overlengthhi") && b:overlengthhi
        " highlight clear OverLength
        match none
        let b:overlengthhi = 0
        echo "overlength highlight off"
    else
        " Highlight string parts that goes over the 80 column limit
        highlight OverLength ctermbg=darkgrey ctermfg=lightgrey guibg=#FFD9D9
        match OverLength /\%81v.\+/
        let b:overlengthhi = 1
        echo "overlength highlight on"
    endif
endfunction

" yy, dd and p works with system clipboard
set clipboard=unnamed " But only 7.03+ version supported

set history=1000    " Remember more commands and search history
set undolevels=1000 " Use many muchos levels of undo

set nobackup   " Disable to make a backup before overwriting a file
set noswapfile " Disable to use a swapfile for the buffer

" For modern standards in :TOhtml output
let html_use_css        = 1
let use_xhtml           = 1
let html_ignore_folding = 1
let html_number_lines   = 0

" Formatoptions are in the order presented in fo-table
set formatoptions+=t " Auto-wrap using textwidth (not comments)
set formatoptions+=c " Auto-wrap comments too
set formatoptions+=r " Continue the comment header automatically on <CR>
set formatoptions-=o " Don't insert comment leader with 'o' or 'O'
set formatoptions+=q " Allow formatting of comments with gq
set formatoptions-=w " Double-carriage-return indicates paragraph
set formatoptions-=a " Don't reformat automatically
set formatoptions+=n " Recognize numbered lists when autoindenting
set formatoptions+=2 " Use second line of paragraph when autoindenting
set formatoptions-=v " Don't worry about vi compatiblity
set formatoptions-=b " Don't worry about vi compatiblity
set formatoptions+=l " Don't break long lines in insert mode
set formatoptions+=1 " Don't break lines after one-letter words, if possible


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                      Appearance                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set number    " Enable line numbers
set mousehide " Hide mouse pointer when characters are typed
set showmatch " Show matching parentheses
set wrap      " Wrap lines
set linebreak " Do not break words
if has("linebreak")
    " String to put at the beginning of lines that have been wrapped: ↪
    let &showbreak = nr2char(8618).' '
endif

set visualbell   " Use visual bell instead of beeping
set noerrorbells " Ring the bell (beep or screen flash) for error messages
set t_vb=        " Turn off error beep/flash

set lazyredraw " Screen will not be redrawn while executing macros
set ttyfast    " Improves smoothness of redrawing

set winminheight=0 " Minimal height of a window, when it's not the current window
set cmdheight=1    " Number of screen lines to use for the command-line
set report=0       " Show a report when something was changed. 0 means 'all'

set foldcolumn=3      " 2 lines of column for fold showing, always
set foldmethod=syntax " The kind of folding used for the current window
set foldlevelstart=99 " Useful to always start editing with no folds closed
set foldenable        " All folds will be closed by default (really not, see foldlevelstart above)

" Spelling
if filereadable(expand("~/.vim/spell/ru.utf-8.spl"))
    set spelllang=en,ru
else
    set spelllang=en
endif

autocmd FileType markdown set spell

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

nnoremap * *<C-o> " Don't move on *

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

set pumheight=8 " Keep a small completion window

" Hitting TAB in command mode will show possible completions above command line
set wildmenu

" A file that matches with one of these patterns is ignored when completing file or directory names
set wildignore+=.hg,.git,.svn                  " Version control
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg " Binary images
set wildignore+=*.swp,*.bak,*.pyc,*.class      " Other


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
