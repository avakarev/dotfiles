# Aplly ~/.bashrc with addition settings
if [ -f $HOME/.bashrc ]; then
  source $HOME/.bashrc
  ENV=$HOME/.bashrc
  export ENV
fi

# 'Switch on' bash auto-complete
# To install it, just run "brew install bash-completion"
if [ -f `brew --prefix`/etc/bash_completion ]; then
  source `brew --prefix`/etc/bash_completion
fi

# Load
#   ~/.bash/aliases  apply command aliases
#   ~/.bash/prompt   customize bash command prompt
#   ~/.bash/colors   add custom coloring in terminal
for file in aliases prompt colors; do
    file="$HOME/.bash/$file"
    if [ -e "$file" ]; then
        source "$file"
    fi
done
