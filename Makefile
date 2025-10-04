VERSION = $(shell cat VERSION.txt)
CADDY_VERSION = $(shell awk -F- '{print $$1}' VERSION.txt)
PLUGINS = $(shell cat WITH.txt)

all: zip

zip: VERSION.txt WITH.txt
	rm -rf caddy-build
	mkdir caddy-build
	GOPROXY="https://proxy.golang.org,direct" xcaddy build v${CADDY_VERSION} ${PLUGINS} --output caddy-build/caddy
	zip caddy-build -r caddy-build

tag:
	git tag v${VERSION}
	git push origin v${VERSION}
	git push origin main