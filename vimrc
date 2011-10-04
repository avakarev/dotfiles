set nocompatible     " Make Vim behave in a more useful way
scriptencoding utf-8 " Specify the character encoding used in the script


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
    autocmd WinLeave * set nocursorline
    autocmd WinEnter * set cursorline
endif

" Make cursor shape as line in insert mode and as block in other cases
if $COLORTERM == "gnome-terminal" && has("autocmd")
    " Should work in gnome-terminal >= 2.26
    autocmd InsertEnter          * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape ibeam"
    autocmd InsertLeave,VimLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
elseif $TERM =~ "xterm"
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
    language message en_US.UTF-8
    set langmenu=en_US.UTF-8
endif

set autoread " Re-read file if it was changed outside of Vim

set confirm " Y-N-C prompt if closing with unsaved changes.

" Do not write contents of the file automatically
set noautowrite
set noautowriteall

" Don't jump to the start of line when moving around (scrolling)
set nostartofline " Affects: CTRL-D, CTRL-U, CTRL-B, CTRL-F, G, H, M, L, gg

set hidden         " When a buffer is brought to foreground, remember undo history and marks
set ttimeoutlen=50 " The time in ms that is waited for a key code to complete
set timeoutlen=500 " Lower the timeout after typing the leader key

let mapleader = "," " Change the mapleader from \ to ,
let g:mapleader = ","

" Map ,, to PageDown key and ,. to PageUp
noremap <leader>, <PageDown>
noremap <leader>. <PageUp>

" Making it so ; works like : for commands
nnoremap ; :

set whichwrap+=h,l  " Make possible navigate between line in cursor on first/last position
set backspace=indent,eol,start " Allow backspacing over everything in insert mode

" Indent/unindent lines
nnoremap <silent> > >>
nnoremap <silent> < <<
vmap > >gv
vmap < <gv

" Find word under cursor recursively in current directory
map <leader>ff :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>

" Tab for brackets
nnoremap <Tab> %
vnoremap <Tab> %

" Go to beginning/end of the line
nnoremap <leader>h ^
nnoremap <leader>l $

" Don't use Ex mode, use Q for formatting
nnoremap Q gqap
vnoremap Q gq

" Easier navigation in insert mode
noremap! <C-a> <Home>
noremap! <C-e> <End>

" Easier navigation in command mode
cnoremap <C-h> <left>
cnoremap <C-l> <right>
cnoremap <C-b> <S-left>
cnoremap <C-f> <S-right>

" Make Ctrl+k delete to end of line, like in Bash
cnoremap <C-k> <C-\>estrpart(getcmdline(), 0, getcmdpos()-1)<CR>
cnoremap jj <C-c>

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
set undolevels=1000 " Set huge undo steps

set nobackup nowritebackup noswapfile " Disable backups and swapfile

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

set number      " Enable line numbers
set mousehide   " Hide mouse pointer when characters are typed
set showmatch   " Show matching parentheses
set matchtime=3 " Duration to show matching brace (1/10 sec)

set wrap      " Wrap lines
set linebreak " Do not break words
if has("linebreak")
    " String to put at the beginning of lines that have been wrapped: ↪
    let &showbreak = nr2char(8618).' '
endif

set visualbell noerrorbells t_vb= " Turn off error beep/flash

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

if &diff
   set nospell " If we're running in vimdiff, then disable spelling
endif

set splitbelow splitright " New window goes below (:sp) and right (:vs)

" Fast window switching
map <leader>w <C-W>w

" Resize splits when the window is resized
autocmd VimResized * execute "normal! \<c-w>="

" Resize windows
nmap <C-Left> <C-W><<C-W><
nmap <C-Right> <C-W>><C-W>>
" nmap <C-Up> <C-W>+<C-W>+
" nmap <C-Down> <C-W>-<C-W>-

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
set magic      " Set magic on, for regular expressions

nnoremap * *<C-o> " Don't move on *

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Turn off search matches highlighting and clear any message displayed
nnoremap <leader><Space> :nohlsearch<Bar>:echo<CR>


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
set softtabstop=4 " Number of spaces while editing
set shiftwidth=4  " Number of spaces to use for each step of (auto)indent
set shiftround    " Use multiple of shiftwidth when indenting with '<' and '>'
set smarttab      " Be smart about deleting tab space, etc

set autoindent " Indent new line to the level of the previous one
set copyindent " Copy the previous indentation on autoindenting


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       Tabline                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set showtabline=1 " Show tab bar only if there are more than 1 tab

map  <C-l> :tabnext<CR>     " Ctrl+l moves to the next tab
map  <C-h> :tabprevious<CR> " Ctrl+h moves to the previous tab
map  <C-n> :tabnew<CR>      " Ctrl+n creates a new tab

if has('windows')

    function! MyTabLabel(n)
        let buflist = tabpagebuflist(a:n)
        let winnr = tabpagewinnr(a:n)
        let buflen = tabpagewinnr(a:n, '$')
        let bufname = fnamemodify(bufname(buflist[winnr - 1]), ':t')

        let label = '#' . a:n . ' '
        let label .= bufname == '' ? 'Empty' : bufname
        let label .= '(' . buflen . ')'

        return label
    endfunction

    function! MyTabLine()
        let s = ''

        for i in range(tabpagenr('$'))
            if i + 1 == tabpagenr()
                let s .= '%#TabLineSel#'
            else
                let s .= '%#TabLine#'
            endif

            let s .= '%' . (i + 1) . 'T'
            let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
        endfor

        let s .= '%#TabLineFill#%T'
        if tabpagenr('$') > 1
            let s .= '%=%#TabLine#%999Xx'
        endif

        return s
    endfunction

    set tabline=%!MyTabLine()
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       Filetypes                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set up custom filetype settings
augroup CustomFiletypes
    autocmd!
    autocmd BufNewFile,BufRead *vimpagerrc* setlocal filetype=vim
    autocmd BufNewFile,BufRead *.json setlocal filetype=javascript
    autocmd BufNewFile,BufRead *bash_profile* setlocal filetype=sh
    autocmd BufNewFile,BufRead *bash/* setlocal filetype=sh
    autocmd BufNewFile,BufRead *zsh/* setlocal filetype=zsh
    autocmd BufNewFile,BufRead *.tt2 setlocal filetype=tt2
    autocmd BufNewFile,BufRead */nginx/* setlocal filetype=nginx
    autocmd BufNewFile,BufRead *tmux.conf* setlocal filetype=tmux
    autocmd BufNewFile,BufRead *.plist setlocal filetype=xml
    autocmd BufNewFile,BufRead {Gemfile,Capfile,Kirkfile,Rakefile,Thorfile,config.ru} setlocal filetype=ruby
    autocmd BufNewFile,BufReadPre {GNUMakefile,Makefile,makefile}{,.am,.in} setlocal noexpandtab
    autocmd BufNewFile,BufReadPre *.{py,yaml} setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.txt setlocal spell foldcolumn=0
    autocmd FileType markdown setlocal spell foldcolumn=0
augroup END

function s:SetColorScheme(name)
    highlight clear
    if exists("syntax_on")
        syntax reset
    endif
    exe "colorscheme " . a:name
endfunction

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
"                         Utils                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Allows use sudo command if file requires it and was open without it
cmap w!! w !sudo tee % >/dev/null

" Quickly edit/reload the vimrc file
nnoremap <leader>ev <C-w><C-v><C-l>:edit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" Set working directory to that of the current file
cmap cwd lcd %:p:h
cmap cd. lcd %:p:h

" Pull word under cursor into the replace formula
nmap <leader>r :%s/<C-r>=expand("<cword>")<CR>/<C-r>=expand("<cword>")<CR>/gc

" Strip all trailing whitespace in the current file
nnoremap <leader>ss :%s/\s\+$//<CR>:let @/=''<CR>

" Retab the document (tabs to spaces)
nnoremap <leader>st :retab!<CR>

" Prints current file full path
" TODO: use -nargs=? and some optional param to show "%:s" or "%:p"
command! ShowPath :echo expand("%:p")

" Prints current file size
command! ShowSize :echo s:FileSize()
function! s:FileSize()
    let bytes = getfsize(expand("%:p"))
    if bytes <= 0
        return ""
    endif
    if bytes < 1024
        return bytes . " Bytes"
    else
        return (bytes / 1024) . " kB"
    endif
endfunction

" Date/time helpers
command! -nargs=0 AppendNow  :execute "normal a".strftime("%c")
command! -nargs=0 AppendDate :execute "normal a".strftime("%Y-%m-%d")
command! -nargs=0 AppendTime :execute "normal a".strftime("%H:%M")
command! -nargs=0 AppendDateTime :execute "normal a".strftime("%Y-%m-%d %H:%M")


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        Plugins                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"                      [ NERDTree ]

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


"                   [ NERDCommenter ]

let NERDSpaceDelims = 1 " Use a space after comment chars


"                     [ Supertab ]

let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabLongestHighlight = 1


"                     [ Tasklist ]

map <leader>tt <Plug>TaskList


"                     [ YankRing ]

nnoremap <leader>ty :YRShow<CR>
let g:yankring_replace_n_nkey = ''
let g:yankring_history_dir = '$HOME/.vim/local'
let g:yankring_max_history = 200
let g:yankring_max_display = 200
let g:yankring_window_use_separate = 1
let g:yankring_window_height = 13
