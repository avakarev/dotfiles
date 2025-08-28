noop:
	@echo "Nothing to do, choose target to run"

LINKS = \
	gitconfig \
	gitignore-global \
	gitattributes-global \
	ignore \
	zshrc \
	zsh \
	bashrc \
	bash_profile \
	bash

link: $(addprefix ~/.,$(LINKS))
.PHONY: link

~/.%: ./%
	ln -sf $(abspath $<) $@

clean:
	rm -f $(addprefix ~/.,$(LINKS))
.PHONY: clean

init:
	git submodule update --init
.PHONY: init
