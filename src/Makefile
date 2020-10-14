default: build

build-go:
	@make -C go

build-go-%:
	@make -C go build-$*

build: build-go
.PHONY: build
