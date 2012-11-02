#!/usr/bin/env sh

# http://linuxtidbits.wordpress.com/2008/08/11/output-color-on-bash-scripts/

bundle_bash="bash bash_profile bashrc inputrc taskrc"
bundle_zsh="bash zsh zshrc taskrc"
bundle_git="gitconfig gitignore-global"
bundle_ruby="gemrc rdebugrc irbrc rspec"
bundle_js="jshintrc"

color_red="$(tput setaf 1)"
color_green="$(tput setaf 2)"
color_yellow="$(tput setaf 3)"
color_blue="$(tput setaf 4)"
color_purple="$(tput setaf 5)"
color_cyan="$(tput setaf 6)"
color_gray="$(tput setaf 7)"
color_reset="$(tput sgr0)"

usage(){
  echo "
  Makes symlinks for specified configuration bundles ( ${PWD}.* => ${HOME}.* ).
  Sources: https://github.com/avakarev/dotfiles/blob/master/deploy.sh

  Usage:
      sh deploy.sh bundle1, bundle2, ..

  Available bundles:
      bash          :: bash-related environment ~/.{ bash/ bash_profile bashrc inputrc taskrc }
      zsh           :: zsh-related environment ~/.{ bash/ zsh/ zshrc taskrc }
      git           :: git custom configuration files ~/.{ gitconfig gitignore-global }
      ruby          :: ruby dev environment ~/.{ gemrc rdebugrc irbrc rspec }
      js            :: javascript dev evironment ~/.jshintrc
  "
  exit 1
}

linkify(){
  for i in $1 ; do

    # symlink source file/dir
    this_file_path="${PWD}/$i"

    # symlink target file/dir
    that_file_path="${HOME}/.$i"

    # is it already linked?
    that_link_path=$(readlink "${that_file_path}")

    # if source file/dir is exists
    if [ -e "${this_file_path}" ]; then
        # if target file/dir exists
        if [ -e "${that_file_path}" ]; then
            # if target file/dir is symlink and already linked to source file/dir
            if [ "${that_link_path}" == "$this_file_path" ]; then
                # do nothing
                echo "  ${color_yellow}ignoring${color_reset}: ./$i is already linked to ${this_file_path}"
            # else - ask how to handle that existing file/dir
            else
                echo "  Existing file/dir ${that_file_path} will be overitten by symlink to ${this_file_path}"
                echo "  Select an action:"
                echo "    1. ignore and do nothing"
                echo "    2. backup ${that_file_path} to ${that_file_path}.orig and create symlink to ${that_file_path}"
                echo "    3. remove ${that_file_path} and create symlink to ${that_file_path}"
                read -p "  [1]: " user_input

                # if user has chosen backup or remove
                if [ "${user_input}" == '2' ] || [ "${user_input}" == '3' ]; then
                    # backup
                    if [ "${user_input}" == '2' ]; then
                        echo "  ${color_yellow}backing up${color_reset}: ${that_file_path} to ${that_file_path}.orig"
                        mv "${that_file_path}" "${that_file_path}.orig"
                    # remove
                    else
                        echo "  ${color_red}removing${color_reset}: ${that_file_path}"
                        rm -rf "${that_file_path}"
                    fi

                    echo "  ${color_green}linking${color_reset}: ${that_file_path} to ${this_file_path}"
                    ln -Ffs "${this_file_path}" "${that_file_path}"
                # user has chosen ignore and to nothing
                else
                    echo "  ${color_yellow}ignoring${color_reset}: do nothing with ${that_file_path}"
                fi
            fi
        # target file/dir does not exsits, create an symlink
        else
            echo "  ${color_green}linking${color_reset}: ${that_file_path} to ${this_file_path}"
            ln -Ffs "${this_file_path}" "${that_file_path}"
        fi
    # source file/dir does not exist, do nothing
    else
        echo "  ${color_yellow}ignoring${color_reset}: ${that_file_path} does'nt exists"
    fi
  done
}

case "$1" in
  "" | "help" | "-h" | "-help" | "--help" | "list" )
    usage
    ;;
* )
    for name in "$@" ; do
        bundle_name="bundle_${name}"
        bundle=${!bundle_name}

        if [ -z "${bundle}" ]; then
            echo "${color_red}***${color_reset} [${color_red}${bundle_name}${color_reset}] is not defined: skipping ***"
        else
            echo "${color_green}***${color_reset} [${color_green}${bundle_name}${color_reset}] consists of: ${bundle} ***"
            linkify "${bundle}"
        fi
    done
    ;;
esac

exit 0
