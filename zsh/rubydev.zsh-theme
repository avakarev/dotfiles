# That's how to replace current shell with zsh
# chsh -s $(which zsh)

function current_datetime {
    date "+%d %b %H:%M:%S"
}

function prompt_char {
    # git branch >/dev/null 2>/dev/null && echo '⠠⠵' && return
    echo '○ $:>'
    # echo '$:>'
    # echo '==>'
    # echo '==>'
}

function host_name {
    [ -f ~/.host-name ] && cat ~/.host-name || hostname -s
}

function ruby_version() {
    if which rvm-prompt &> /dev/null; then
      rvm-prompt i v p
    else
      if which rbenv &> /dev/null; then
        rbenv version | sed -e "s/ (set.*$//"
      fi
    fi
}

local rvm_ruby='‹$(ruby_version)›%{$reset_color%}'
local current_dir='${PWD/#$HOME/~}'
local git_info='$(git_prompt_info)'
local datetime='$(current_datetime)'


RPROMPT="%{$FG[238]%}using %{$FG[244]%}${rvm_ruby} ${git_info}"
PROMPT="%{$FG[244]%}╭─%{$FG[146]%}%n%{$reset_color%} %{$FG[238]%}at%{$reset_color%} %{$FG[110]%}$(host_name)%{$reset_color%} %{$FG[238]%}in%{$reset_color%} %{$FG[244]%}[${current_dir}]%{$reset_color%} %{$FG[238]%}${datetime}%{$reset_color%}
%{$FG[244]%}╰─%{$FG[244]%}$(prompt_char) %{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$FG[238]%}on%{$reset_color%} %{$FG[244]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$FG[202]%}✘✘✘"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$FG[040]%}✔"
