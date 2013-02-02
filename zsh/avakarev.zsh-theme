# That's how to replace current shell with zsh
# chsh -s $(which zsh)

# colors
local cl_blue="%{$fg[blue]%}"
local cl_cyan="%{$fg[cyan]%}"
local cl_grey="%{$fg[grey]%}"
local cl_yellow="%{$fg[yellow]%}"
local cl_red="%{$fg[red]%}"
local cl_green="%{$fg[green]%}"
local cl_reset="%{$reset_color%}"


function host_name {
    [ -f ~/.host-name ] && cat ~/.host-name || hostname -s
}

local path_p="${cl_cyan}[%~% ]${cl_reset}"               # ~/current/path
local host_p="${cl_blue} @$(host_name) %{$reset_color%}" # @host

PROMPT="${path_p}${host_p}
$:> "
