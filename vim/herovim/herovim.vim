if exists("colors_name")
    let s:herovim_colors = expand("~/.vim/herovim/colors/" . colors_name . ".vim")
    if exists("colors_name") && filereadable(s:herovim_colors)
        execute "source " . s:herovim_colors
        let WATCHDOG_COLORS_LOADED = 1
    endif
endif

function! herovim#include(configlet_name) abort
    let l:configlet = expand("~/.vim/herovim/configlets/" . a:configlet_name . ".vim")
    if filereadable(configlet)
        execute "source " . configlet
    endif
endfunction
