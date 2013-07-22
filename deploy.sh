#!/usr/bin/env bash

# http://linuxtidbits.wordpress.com/2008/08/11/output-color-on-bash-scripts/

bundle_bash="bash bash_profile bashrc inputrc"
bundle_zsh="bash zsh zshrc"
bundle_git="gitconfig gitignore-global"
bundle_tools="agignore siegerc taskrc"
bundle_ruby="gemrc rvmrc rdebugrc irbrc pryrc rspec"
bundle_js="jshintrc"
bundle_osx="iterm2"
bundle_dev="${bundle_zsh} ${bundle_git} ${bundle_tools} ${bundle_ruby} ${bundle_js}"
bundle_all="${bundle_bash} ${bundle_dev}"

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
      bash deploy.sh [--undo | --status] bundle1, bundle2, ..

  Available bundles:
      bash          :: bash-related environment ~/.{ ${bundle_bash} }
      zsh           :: zsh-related environment ~/.{ ${bundle_zsh} }
      git           :: git custom configuration files ~/.{ ${bundle_git} }
      tools         :: configuration files for some tools I use ~/.{ ${bundle_tools} }
      ruby          :: ruby dev environment ~/.{ ${bundle_ruby} }
      js            :: javascript dev environment ~/.${bundle_js}
      osx           :: osx environment ~/.${bundle_osx}
      dev           :: zsh + git + tools + ruby + js
      all           :: bash + zsh + git + tools + ruby + js
  "
  exit 1
}

tildafy(){
    path=$(echo $1 | sed 's|'${HOME}'|~|g')
    [ -d "$1" ] && path="${path}/"
    echo "${path}"
}

setup_path(){

    # symlink source
    this_file_path="${PWD}/$1"
    this_file_path_tildafied="$(tildafy ${this_file_path})"

    # symlink target
    that_file_path="${HOME}/.$1"
    that_file_path_tildafied="$(tildafy ${that_file_path})"

    # is it already linked?
    that_link_path=$(readlink "${that_file_path}")

}

linkify(){
  for i in $1 ; do

    setup_path "$i"

    # if source file/dir is exists
    if [ -e "${this_file_path}" ]; then
        # if target file/dir exists
        if [ -e "${that_file_path}" ]; then
            # if target file/dir is symlink and already linked to source file/dir
            if [ "${that_link_path}" == "${this_file_path}" ]; then
                # do nothing
                echo " *${color_yellow}ignoring${color_reset} (already linked): ${that_file_path_tildafied} => ${this_file_path_tildafied}"
            # else - ask how to handle that existing file/dir
            else
                echo "  Existing ${that_file_path_tildafied} going to be overitten by symlink to ${this_file_path_tildafied}"
                echo "  Select an action:"
                echo "    1. ignore and do nothing"
                echo "    2. backup ${that_file_path_tildafied} to ${that_file_path_tildafied}.orig and create symlink to ${this_file_path_tildafied}"
                echo "    3. remove ${that_file_path_tildafied} and create symlink to ${this_file_path_tildafied}"
                read -p "  [1]: " user_input

                # if user has chosen backup or remove
                if [ "${user_input}" == '2' ] || [ "${user_input}" == '3' ]; then
                    # backup
                    if [ "${user_input}" == '2' ]; then
                        echo "  backing up: ${that_file_path_tildafied} to ${that_file_path_tildafied}.orig"
                        mv "${that_file_path}" "${that_file_path}.orig"
                    # remove
                    else
                        echo "  removing: ${that_file_path_tildafied}"
                        rm -rf "${that_file_path}"
                    fi

                    echo " *${color_green}linking${color_reset}: ${that_file_path_tildafied} => ${this_file_path_tildafied}"
                    ln -Ffs "${this_file_path}" "${that_file_path}"
                # user has chosen ignore and to nothing
                else
                    echo " *${color_yellow}ignoring${color_reset} (your choice): ${that_file_path_tildafied}"
                fi
            fi
        # target file/dir does not exsits, create an symlink
        else
            echo " *${color_green}linking${color_reset}: ${that_file_path_tildafied} => ${this_file_path_tildafied}"
            ln -Ffs "${this_file_path}" "${that_file_path}"
        fi
    # source file/dir does not exist, do nothing
    else
        echo " *${color_yellow}ignoring${color_reset} (does not exist): ${that_file_path_tildafied}"
    fi
  done
}

unlinkify(){
  for i in $1 ; do

    setup_path "$i"

    if [ -e "${this_file_path}" ] && [ -e "${that_file_path}" ]; then
        if [ "${that_link_path}" == "${this_file_path}" ]; then
            echo " *${color_green}unlinking${color_reset}: ${that_file_path_tildafied}"
            rm -rf "${that_file_path}"
        else
            echo " *${color_yellow}ignoring${color_reset}: ${that_file_path_tildafied} is not linked to ${this_file_path_tildafied}"
        fi
    else
        echo " *${color_yellow}ignoring${color_reset} (does not exist): ${this_file_path_tildafied} or ${that_file_path_tildafied}"
    fi
  done
}

show_status(){
  for i in $1 ; do

    setup_path "$i"

    if [ -e "${this_file_path}" ] && [ -e "${that_file_path}" ] && [ "${that_link_path}" == "${this_file_path}" ]; then
        echo " *${color_green}linked${color_reset}: ${that_file_path_tildafied} => ${this_file_path_tildafied}"
    else
        echo " *${color_yellow}not linked${color_reset}: ${that_file_path_tildafied} => ${this_file_path_tildafied}"
    fi
  done
}

case "$1" in
  "" | "help" | "-h" | "-help" | "--help" | "list" )
    usage
    ;;
  "--undo" )
    UNDO=1
    shift
    ;;
  "--status" )
    STATUS=1
    shift
    ;;
esac

# if there are no bundle names was passed
if [ -z "$1" ]; then
    usage
fi

for name in "$@" ; do
    bundle_name="bundle_${name}"
    bundle=${!bundle_name}

    if [ -z "${bundle}" ]; then
        echo "${color_red}***${color_reset} [${color_red}${bundle_name}${color_reset}] is not defined: skipping ***"
    else
        echo "${color_green}***${color_reset} [${color_green}${bundle_name}${color_reset}]: ${bundle} ***"
        if [ "${STATUS}" == "1" ]; then
            show_status "${bundle}"
        elif [ "${UNDO}" == "1" ]; then
            unlinkify "${bundle}"
        else
            linkify "${bundle}"
        fi
    fi
done

exit 0
