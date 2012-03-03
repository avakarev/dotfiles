# 'Switch on' bash auto-complete
# To install it, just run "brew install bash-completion"
if [ -f `brew --prefix`/etc/bash_completion ]; then
  source `brew --prefix`/etc/bash_completion
fi

# Load
#   ~/.bash/aliases  apply command aliases
#   ~/.bash/prompt   customize bash command prompt
#   ~/.bash/colors   add custom coloring in terminal
#   ~/.bash/exports  apply some environment vars: like EDITOR, PATH and so
for file in aliases prompt colors exports; do
    file="$HOME/.bash/$file"
    if [ -e "$file" ]; then
        source "$file"
    fi
done

# This loads RVM into a shell session.
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
