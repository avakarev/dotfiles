colorscheme xoria256

set lines=30 columns=120 " Size of MacVim window

set guioptions-=m " Do not display menu
set guioptions-=T " Do not display toolbar
set guioptions-=r " Do not display right-hand scrollbar
set guioptions-=L " Do not display left-hand scrollbar
set guioptions-=b " Do not display bottom (horizontal) scrollbar

if has("gui_macvim")
    set guifont=Monaco:h13 " Make font size bigger
endif

if exists('+colorcolumn')
    set colorcolumn=80
    highlight ColorColumn guibg=#262626
endif
