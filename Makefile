IMAGE_TAG= $(shell git describe --tags 2>/dev/null || echo 'v0.0.0')
CURRENT_DATE ?= $(shell date -u +'%Y-%m-%dT%H:%M:%SZ' | cut -c 1-)
REVERSION ?= $(shell git rev-list HEAD -n 1 | cut -c 1-)
PROJECT_LABEL = "smee.io"
PLATFORM ?= "linux/amd64"

.PHONY: images
images:
	@docker buildx build . --load -f Dockerfile -t registry.cn-sh-01.sensecore.cn/tsm_2024052501/smee.io:${IMAGE_TAG} --pull --label=org.opencontainers.image.created=${CURRENT_DATE} --label=org.opencontainers.image.title=${PROJECT_LABEL} --label=org.opencontainers.image.revision=${REVERSION} --platform=${PLATFORM}

.PHONY: push
push:
	@docker push registry.cn-sh-01.sensecore.cn/tsm_2024052501/smee.io:${IMAGE_TAG}
