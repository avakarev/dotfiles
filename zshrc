# zmodload zsh/zprof # uncoment to profile loading time

# Check the default zshrc template at ~/.zsh/ohmyzsh/templates/zshrc.zsh-template

# Enable auto completion. You may have to force rebuild zcompdump: `rm -f ~/.zcompdump; compinit`
autoload -Uz compinit
compinit
fpath=($HOME/.zsh/completions/src $fpath)

# Path to your oh-my-zsh installation
export ZSH=$HOME/.zsh/ohmyzsh

# Disable automatic upgrades
DISABLE_UPDATE_PROMPT=true
DISABLE_AUTO_UPDATE=true

# Load plugins from ~/.zsh/ohmyzsh/plugins/
plugins=(
  # aws
  command-not-found
  # docker
  # docker-compose
  # helm
  # kubectl
  # kubectx
  # nvm
)

source $ZSH/oh-my-zsh.sh

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
