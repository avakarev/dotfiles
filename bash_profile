if [ -f ~/.bashrc ]; then
  . ~/.bashrc   # read ~/.bashrc, if present
  ENV=~/.bashrc
  export ENV
fi

# enabling bash auto-complete
# to install it, run "brew install bash-completion"
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

# add aliases
if [ -f ~/.bash/aliases ]; then
  . ~/.bash/aliases
fi

# improve bash command prompt
if [ -f ~/.bash/prompt ]; then
  . ~/.bash/prompt
fi

# add custom coloring
if [ -f ~/.bash/colors ]; then
  . ~/.bash/colors
fi

# enable custom functions
if [ -f ~/.bash/functions ]; then
  . ~/.bash/functions
fi
