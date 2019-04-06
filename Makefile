IMAGE = eiri/minideb-erlang
VERSION ?= 20.1

.PHONY: help
help:
	@echo "COMMAND: build|test|shell|bash|deploy VERSION=\$$version"
	@echo "BUILDS IMAGE: $(IMAGE):$(VERSION)"
	@echo "VERSIONS: 17.5 18.3 19.3 20.1(default) latest"

.PHONY: test
test:
	docker run --rm -it $(IMAGE):$(VERSION) /opt/erlang/$(VERSION)/bin/erl -noshell -eval 'erlang:display(erlang:system_info(system_version))' -eval 'init:stop()'

.PHONY: shell
shell:
	docker run --rm -it $(IMAGE):$(VERSION) /opt/erlang/$(VERSION)/bin/erl

.PHONY: bash
bash:
	docker run --rm -it $(IMAGE):$(VERSION) /bin/bash

.PHONY: build
build: $(VERSION)

.PHONY: latest
latest:
	docker build -t $(IMAGE):latest .

.PHONY: 20.1
20.1: docker-build

.PHONY: 19.2
19.3: docker-build

.PHONY: 18.3
18.3: docker-build

.PHONY: 17.5
17.5: docker-build

.PHONY: docker-build
docker-build:
	docker build -t $(IMAGE):$(VERSION) --build-arg erl_version=$(VERSION) .

.PHONY: release
release: build
	docker push $(IMAGE):$(VERSION)
