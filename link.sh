#!/usr/bin/env sh

# @TODO: add colors
# http://linuxtidbits.wordpress.com/2008/08/11/output-color-on-bash-scripts/

bundle_bash="bash bash_profile bashrc inputrc taskrc"
bundle_zsh="bash zsh zshrc taskrc"
bundle_vim="vim vimrc gvimrc vimpagerrc"
bundle_git="gitconfig gitignore-global"
bundle_ruby="gemrc rdebugrc irbrc rspec"
bundle_js="jshintrc"

usage(){
  echo "
  Makes symlinks for specified configuration bundles ( ${PWD}.* => ${HOME}.* ).
  Sources: https://github.com/avakarev/dotfiles/blob/master/link.sh

  Usage:
      sh link.sh bundle1, bundle2, ..

  Available bundles:
      bash          :: bash-related environment ~/.{ bash/ bash_profile bashrc inputrc taskrc }
      zsh           :: zsh-related environment ~/.{ bash/ zsh/ zshrc taskrc }
      vim           :: vim custom configuration files ~/.{ vim/ vimrc gvimrc vimpagerrc }
      git           :: git custom configuration files ~/.{ gitconfig gitignore-global }
      ruby          :: ruby dev environment ~/.{ gemrc rdebugrc irbrc rspec }
      js            :: javascript dev evironment ~/.jshintrc
  "
  exit 1
}

link(){
  for i in $1 ; do
    if [ -e "${PWD}/$i" ]; then
      echo "item exists"
      if [ -d "${PWD}/$i" ]; then
        if [ -d "${HOME}/.$i" ]; then
          rm -rf "${HOME}/.$i"
        fi;
      fi;
      echo "link it again"
      ln -Ffs "${PWD}/$i" "${HOME}/.$i"
    fi
  done
}

case "$1" in
  "" | "help" | "-h" | "-help" | "--help" | "list" )
    usage
    ;;
* )
    for name in "$@" ; do
        bundle_name="bundle_$name"
        bundle=${!bundle_name}

        if [ -z "$bundle" ]; then
            echo "it is not clear how to link [$bundle_name]"
        else
            echo "[$bundle_name] being linked successfuly: $bundle"
            link "$bundle"
        fi
    done
    ;;
esac

exit 0
