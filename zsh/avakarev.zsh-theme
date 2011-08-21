# colors
local cl_blue="%{$fg[blue]%}"
local cl_cyan="%{$fg[cyan]%}"
local cl_grey="%{$fg[grey]%}"
local cl_yellow="%{$fg[yellow]%}"
local cl_red="%{$fg[red]%}"
local cl_green="%{$fg[green]%}"
local cl_reset="%{$reset_color%}"

# current path
local path_p="${cl_cyan}[%~% ]${cl_reset}"

# user@host
local user_host="${cl_blue}[${cl_grey}%n${cl_blue}@${cl_yellow}%m% ${cl_blue}]%{$reset_color%}"
# @host
local host_p="${cl_blue} @%m% %{$reset_color%}"

#Customized git status, oh-my-zsh currently does not allow render dirty status before branch
git_custom_status() {
  local cb=$(current_branch)
  if [ -n "$cb" ]; then
    ZSH_THEME_GIT_PROMPT_DIRTY="${cl_red}*${cl_reset}"
    local git_status="$(parse_git_dirty)${cl_reset}${cl_grey}[$(current_branch)]"
    local commits_ahead=`git st | awk -F"[" 'NR==1{sub("]","",$2);print $2}' | sed -ne "s%[^0-9]*\([0-9]*\).*%\1%p"`
    if [ -n "$commits_ahead" ]; then
        echo "${git_status}${cl_green}:${commits_ahead}${cl_reset}";
    else
        echo "${git_status}${cl_reset}";
    fi
  fi
}

# git settings
RPS1='$(git_custom_status) $EPS1'

PROMPT="${path_p}${host_p}
$:> "
