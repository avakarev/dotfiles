# TODO: code in bash and vim section - the same
# try to move it to function

BASH_BUNDLE := "bash" \
               "bash_profile" \
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

# install bash related config files
# existed file will be overwritten
bash:
	@for bashitem in $(BASH_BUNDLE) ; do \
		if [ -e "${PWD}/$$bashitem" ]; then \
			if [ -d "${PWD}/$$bashitem" ]; then \
				if [ -d "${HOME}/.$$bashitem" ]; then \
					rm -rf "${HOME}/.$$bashitem" ; \
				fi ; \
			fi ; \
		    ln -Ffs "${PWD}/$$bashitem" "${HOME}/.$$bashitem" ; \
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
			if [ "$$gitfile" == "gitconfig" ]; then \
				if [ -f "${HOME}/.$$gitfile" ]; then \
					rm "${HOME}/.$$gitfile" ; \
				fi ; \
				cp "${PWD}/$$gitfile" "${HOME}/.$$gitfile" ; \
			else \
				ln -Ffs "${PWD}/$$gitfile" "${HOME}/.$$gitfile" ; \
			fi ; \
		fi ; \
	done
	@ echo "git bundle installed!";

.PHONY: all bash vim git
