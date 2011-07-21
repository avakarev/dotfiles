BASH_BUNDLE := "bash_colors" \
               "bash_functions" \
               "bash_profile" \
               "bash_prompt" \
               "bashrc"

VIM_BUNDLE := "vim" \
              "vimrc" \

GIT_BUNDLE := "gitconfig"

# confirmation prompt requires answer "yes" to continue
all:
	@while true; do \
		echo "It might hurt your feelings. Are you sure ot continue? (yes/no)"; \
		read answer ; \
		if [[ $$answer != "yes" ]]; then \
			echo "Nothing was made, exiting..." ; \
			exit ; \
		else \
			$(MAKE) bash vim git ; \
			exit ; \
		fi; \
		break; \
	done;
#	bash vim git

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

# install git related config files
git:
	@for gitfile in $(GIT_BUNDLE) ; do \
		if [ -f "${PWD}/$$gitfile" ]; then \
			ln -Ffs "${PWD}/$$gitfile" "${HOME}/.$$gitfile" ; \
		fi ; \
	done
	@ echo "git bundle installed!";

.PHONY: all bash vim git
