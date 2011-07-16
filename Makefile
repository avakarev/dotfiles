BASH_BUNDLE := "bash_colors" \
               "bash_functions" \
               "bash_profile" \
               "bash_prompt" \
               "bashrc"

VIM_BUNDLE := "vim" \
              "vimrc" \

# install bash related config files
# existed file will be overwritten
bash:
	@for bashfile in $(BASH_BUNDLE) ; do \
		if [ -f "${PWD}/$$bashfile" ]; then \
			ln -Ffs "${PWD}/$$bashfile" "${HOME}/.$$bashfile" ; \
		fi ; \
	done
	@ echo "bash bundle installed!";

# install vim related config files
vim:
	@for vimitem in $(VIM_BUNDLE) ; do \
		if [ -e "${PWD}/$$vimitem" ]; then \
			if [ -d "${PWD}/$$vimitem" ]; then \
				if [ -d "${HOME}/.$$vimitem" ]; then \
					rm -rf "${HOME}/.$$vimitem" ; \
				fi ; \
			fi ; \
		    ln -Ffs "${PWD}/$$vimitem" "${HOME}/.$$vimitem" ; \
		fi ; \
	done
	@ echo "vim bundle installed!";

.PHONY: all bash vim
