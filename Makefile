BASH_BUNDLE := "bash_colors" \
               "bash_functions" \
               "bash_profile" \
               "bash_prompt" \
               "bashrc"

# install bash related config files
# existed file will be overwritten
bash:
	@for bashfile in $(BASH_BUNDLE) ; do \
		if [ -f "${PWD}/$$bashfile" ]; then \
			ln -sfF "${PWD}/$$bashfile" "${HOME}/.$$bashfile" ; \
		fi ; \
	done
	@ echo "bash bundle installed!";

.PHONY: all bash