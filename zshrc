# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.zsh/oh-my-zsh

# Set name of the theme to load.
# Look in ~/.zsh/oh-my-zsh/themes/
# ZSH_THEME="robbyrussell"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want disable red dots displayed while waiting for completion
# DISABLE_COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.zsh/oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(brew gem git git-flow heroku npm osx redis-cli rvm sublime taskwarrior thor vagrant)

source $ZSH/oh-my-zsh.sh

# My custom theme
source "$HOME/.zsh/avakarev.zsh-theme"

# Apply exports.
if [ -e $HOME/.bash/exports ]; then
  source $HOME/.bash/exports
fi

# Add aliases.
if [ -e $HOME/.bash/aliases ]; then
  source $HOME/.bash/aliases
  alias up='source ~/.zshrc'
fi
