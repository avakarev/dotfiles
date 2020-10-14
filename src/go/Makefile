CMDS = $(notdir $(shell go list ./cmd/...))
BUILD_TARGETS = $(addprefix build-,$(CMDS))

default: build

cmds:
	@for cmd in ${CMDS}; do\
		echo $$cmd;\
	done

version:
	@echo ">> Using go $(shell go version | cut -c14-19)"

build-%:
	@echo ">> Building $*"
	@go build -o ../../bash/scripts/$* ./cmd/$*

build: version $(BUILD_TARGETS)
.PHONY: build
