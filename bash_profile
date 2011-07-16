if [ -f ~/.bashrc ]; then
  . ~/.bashrc   # read ~/.bashrc, if present
fi

ENV=$HOME/.bashrc
export ENV

# enabling bash auto-complete
# to install it, run "brew install bash-completion"
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

# improve bash command prompt
if [ -f ~/.bash_prompt ]; then
  . ~/.bash_prompt
fi

# add custom coloring
if [ -f ~/.bash_colors ]; then
  . ~/.bash_colors
fi

# enable custom functions
if [ -f ~/.bash_functions ]; then
  . ~/.bash_functions
fi