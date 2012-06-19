# 'Switch on' bash auto-complete
# To install it, just run "brew install bash-completion"
if [ -d /usr/local/Cellar ] && [ -f `brew --prefix`/etc/bash_completion ]; then
  source `brew --prefix`/etc/bash_completion
fi

# Load
#   ~/.bash/exports  apply some environment vars: like EDITOR, PATH and so
#   ~/.bash/aliases  apply command aliases
#   ~/.bash/prompt   customize bash command prompt
#   ~/.bash/colors   add custom coloring in terminal
for file in exports aliases prompt colors; do
    file="$HOME/.bash/$file"
    if [ -e "$file" ]; then
        source "$file"
    fi
done
