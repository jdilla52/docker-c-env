REGISTRY=ghcr.io/jdilla52/cpp-env
IMAGE=cpp-env
TAG=$(shell cat ./VERSION)

build:
	docker build . -t $(IMAGE)

bash:
	docker run -it $(IMAGE)

push: ## this will push a tag an image
	docker tag $(IMAGE) $(REGISTRY):$(TAG)
	docker push --all-tags $(REGISTRY)

login:
	echo $CR_PAT | docker login ghcr.io

.PHONY: help
help:           ## Show this help.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
