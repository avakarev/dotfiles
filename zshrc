# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.zsh/oh-my-zsh

# Set name of the theme to load.
# Look in ~/.zsh/oh-my-zsh/themes/
# ZSH_THEME="robbyrussell"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want disable red dots displayed while waiting for completion
# DISABLE_COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.zsh/oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(brew git node npm osx)

source $ZSH/oh-my-zsh.sh

# My custom theme
source "$HOME/.zsh/avakarev.zsh-theme"

# Customize to your needs...
export SVN_EDITOR=vi
export NODE_PATH=/usr/local/lib/node_modules


PATH=/usr/local/bin:$PATH:$HOME/.bash/scripts
export PATH

# Add aliases.
if [ -f ~/.bash/aliases ]; then
  . ~/.bash/aliases
  alias up='source ~/.zshrc'
fi

# This loads RVM into a shell session.
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
