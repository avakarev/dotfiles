GO_CMDS = $(notdir $(shell go list ./go/cmd/...))
GO_BUILD_TARGETS = $(addprefix build-go-,$(GO_CMDS))

gocmds:
	@for cmd in ${GO_CMDS}; do\
		echo $$cmd;\
	done

print-go:
	@echo ">> Building using go $(shell go version | cut -c14-19):"

build-go-%:
	@echo "    * $*"
	@go build -o ../bash/scripts/$* ./go/cmd/$*

build-go: print-go $(GO_BUILD_TARGETS)

build: build-go
.PHONY: build
