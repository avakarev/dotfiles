# TODO: use make's conditionals instead of sh's
#       http://www.gnu.org/software/make/manual/html_node/Conditional-Syntax.html

BASH_BUNDLE := "bash" \
               "bash_profile" \
               "bashrc"

ZSH_BUNDLE := "zsh" \
              "zshrc"

VIM_BUNDLE := "vim" \
              "vimrc"

GIT_BUNDLE := "gitconfig"

# Function to deploy config files. Takes 1 argument: name-of-bundle.
# It will loop through all bundle items and create symlinks according to.
# So, existed files and dirs will be overwritten with symlinks.
deploy = \
	@for item in $(1); do \
		if [ -e "${PWD}/$$item" ]; then \
			if [ -d "${PWD}/$$item" ]; then \
				if [ -d "${HOME}/.$$item" ]; then \
					rm -rf "${HOME}/.$$item"; \
				fi; \
			fi; \
			ln -Ffs "${PWD}/$$item" "${HOME}/.$$item"; \
		fi; \
	done

# Confirmation prompt requires answer "yes" to continue.
all:
	@while true; do \
		echo "It might hurt your feelings. Are you sure ot continue? (yes/no)"; \
		read answer; \
		if [[ $$answer != "yes" ]]; then \
			echo "Nothing was made. Bye."; \
			exit; \
		else \
			$(MAKE) bash zsh vim git; \
			exit; \
		fi; \
		break; \
	done

# Install bash related config files.
bash:
	$(call deploy,$(BASH_BUNDLE));
	@ echo "bash bundle installed!";

# Install zsh related config files.
zsh:
	$(call deploy,$(ZSH_BUNDLE));
	@ echo "zsh bundle installed!";

# Install vim related config files.
vim:
	$(call deploy,$(VIM_BUNDLE));
	@ echo "vim bundle installed!";

# Install git related config files.
git:
	@for gitfile in $(GIT_BUNDLE); do \
		if [ -f "${PWD}/$$gitfile" ]; then \
			if [ "$$gitfile" == "gitconfig" ]; then \
				if [ -f "${HOME}/.$$gitfile" ]; then \
					rm "${HOME}/.$$gitfile"; \
				fi; \
				cp "${PWD}/$$gitfile" "${HOME}/.$$gitfile"; \
			else \
				ln -Ffs "${PWD}/$$gitfile" "${HOME}/.$$gitfile"; \
			fi; \
		fi; \
	done
	@ echo "git bundle installed!";

.PHONY: all bash zsh vim git
