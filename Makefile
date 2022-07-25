# sourced by https://github.com/octomation/makefiles

.DEFAULT_GOAL = validate

AT    := @
ARCH  := $(shell uname -m | tr '[:upper:]' '[:lower:]')
OS    := $(shell uname -s | tr '[:upper:]' '[:lower:]')
DATE  := $(shell date -u +%Y-%m-%dT%T%Z)
SHELL := /usr/bin/env bash -euo pipefail -c

find-todos:
	$(AT) grep \
		--exclude-dir={bin,docs} \
		--exclude-dir={node_modules,vendor} \
		--exclude-dir={.docz,.next} \
		--color \
		--text \
		-inRo -E ' TODO:.*|SkipNow' . | grep -v ' TODO:.*|SkipNow' || true
.PHONY: find-todos

help:
	@LC_ALL=C $(MAKE) -pRrq -f $(firstword $(MAKEFILE_LIST)) : 2>/dev/null \
	| awk -v RS= -F: '/(^|\n)# Files(\n|$$)/,/(^|\n)# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' \
	| sort \
	| egrep -v -e '^[^[:alnum:]]' -e '^$@$$' || true
.PHONY: help

make-verbose:
	$(eval AT :=) $(eval MAKE := $(MAKE) verbose) @true
.PHONY: make-verbose

COMMIT  := $(shell git rev-parse --short --verify HEAD)
RELEASE := $(shell git describe --tags 2>/dev/null | rev | cut -d - -f3- | rev)

git-config:
	$(AT) git config core.autocrlf input
.PHONY: git-config

git-clean:
	$(AT) git clean -fdx
.PHONY: git-clean

git-check:
	$(AT) git diff --exit-code >/dev/null
	$(AT) git diff --cached --exit-code >/dev/null
	$(AT) ! git ls-files --others --exclude-standard | grep -q ^
.PHONY: git-check

git-rmdir:
	$(AT) for dir in `git ls-files --others --exclude-standard --directory`; do \
		find $${dir%%/} -depth -type d -empty | xargs rmdir; \
	done
.PHONY: git-rmdir

GOBIN ?= $(PWD)/bin/$(OS)/$(ARCH)
export GOBIN := $(GOBIN)
TOOLFLAGS ?= -mod=

go-tools-env:
	@echo "GOBIN:       `go env GOBIN`"
	@echo "TOOLFLAGS:   $(TOOLFLAGS)"
.PHONY: go-tools-env

ifneq (, $(wildcard ./tools/))
go-tools-check: GOFLAGS = $(TOOLFLAGS)
go-tools-check:
	$(AT) cd tools; \
	go mod verify; \
	govulncheck -tags $(GOTAGS) -test ./...; \
	if command -v egg >/dev/null; then \
		egg deps check license; \
		egg deps check version; \
	fi
.PHONY: go-tools-check

go-tools-fetch: GOFLAGS = $(TOOLFLAGS)
go-tools-fetch:
	$(AT) cd tools; go mod download; \
	if [[ "`go env GOFLAGS`" =~ -mod=vendor ]]; then go mod vendor; fi
.PHONY: go-tools-fetch

go-tools-install: GOFLAGS = $(TOOLFLAGS)
go-tools-install: GOTAGS = tools
go-tools-install: go-tools-fetch
	$(AT) cd tools; go generate -tags $(GOTAGS) tools.go
.PHONY: go-tools-install

go-tools-tidy: GOFLAGS = $(TOOLFLAGS)
go-tools-tidy:
	$(AT) cd tools; go mod tidy; \
	if [[ "`go env GOFLAGS`" =~ -mod=vendor ]]; then go mod vendor; fi
.PHONY: go-tools-tidy

go-tools-update: GOFLAGS = $(TOOLFLAGS)
go-tools-update: selector = '{{if not (or .Main .Indirect)}}{{.Path}}{{end}}'
go-tools-update:
	$(AT) cd tools; \
	if command -v egg >/dev/null; then \
		packages="`egg deps list | tr ' ' '\n'`"; \
	else \
		packages="`go list -f $(selector) -m -mod=readonly all`"; \
	fi; \
	if [ -z "$$packages" ]; then exit; fi; \
	for package in $$packages; do \
		go mod edit -require=$$package@latest; \
		go mod tidy; \
	done
	$(AT) $(MAKE) go-tools-tidy go-tools-install
.PHONY: go-tools-update
else
go-tools-disabled:
	@echo have no tools
.PHONY: go-tools-disabled

go-tools-check: go-tools-disabled
	@true
.PHONY: go-tools-check

go-tools-fetch: go-tools-disabled
	@true
.PHONY: go-tools-fetch

go-tools-install: go-tools-disabled
	@true
.PHONY: go-tools-install

go-tools-tidy: go-tools-disabled
	@true
.PHONY: go-tools-tidy

go-tools-update: go-tools-disabled
	@true
.PHONY: go-tools-update
endif

export PATH := $(GOBIN):$(PATH)

env: go-tools-env
env:
	@echo "PATH:        $(PATH)"
.PHONY: env

tools: go-tools-install
.PHONY: tools

validate:
	$(AT) traefik-config-validator -cfg traefik/static.yml -cfgdir traefik/dynamic
.PHONY: validate
