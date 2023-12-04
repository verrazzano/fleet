TARGETS := $(shell ls scripts)

GO ?= CGO_ENABLED=0 GO111MODULE=on go
DAPPER_VERSION = v0.6.0-v8o-2

# find or download dapper
DAPPER_PATH := $(shell eval go env GOPATH)
.PHONY: dapper
dapper:
ifeq (, $(shell command -v dapper))
	$(GO) install github.com/verrazzano/rancher-dapper@${DAPPER_VERSION}
	mv ${DAPPER_PATH}/bin/rancher-dapper $(DAPPER_PATH)/bin/dapper
	$(eval DAPPER=$(DAPPER_PATH)/bin/dapper)
else
	$(eval DAPPER=$(shell command -v dapper))
endif

serve-docs: mkdocs
	docker run -p 8000:8000 --rm -it -v $${PWD}:/docs mkdocs serve -a 0.0.0.0:8000

mkdocs:
	docker build -t mkdocs -f Dockerfile.docs .

$(TARGETS): dapper
	dapper $@

.DEFAULT_GOAL := default

.PHONY: $(TARGETS)
