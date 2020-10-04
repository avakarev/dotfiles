# zmodload zsh/zprof # uncoment to profile loading time

# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.zsh/ohmyzsh

# Set name of the theme to load.
# Look in ~/.zsh/ohmyzsh/themes/
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

# Which plugins would you like to load? (plugins can be found in ~/.zsh/ohmyzsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(aws docker git git-flow golang kubectl mix node nvm osx pip python redis-cli yarn)

source $ZSH/oh-my-zsh.sh

# Additional completion definitions for zsh
# fpath=($HOME/.zsh/completions/src $fpath)

# My custom theme
if [ "$TERM" != "dumb" ]; then # not a MacVim
    source "$HOME/.zsh/avakarev.zsh-theme"
fi

# Apply exports
if [ -e $HOME/.bash/exports ]; then
  source $HOME/.bash/exports
fi

# Add aliases
if [ -e $HOME/.bash/aliases ]; then
  source $HOME/.bash/aliases
  alias up='source ~/.zshrc'
fi

# Disable autocorrect where zsh does suggest bullshit
if [ -f $HOME/.zsh/zsh_nocorrect ]; then
  while read -r COMMAND; do
    alias $COMMAND="nocorrect $COMMAND"
  done < $HOME/.zsh/zsh_nocorrect
fi

# zprof # uncoment to profile loading time
