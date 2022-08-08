IMAGE_NAME := tinycore
IMAGE_VER := 13.1
IMAGE_ARC := x86_64
IMAGE_TAG := $(IMAGE_VER)-$(IMAGE_ARC)

.PHONY: all build stop clean

all: build

build:
	docker build -t $(IMAGE_NAME):$(IMAGE_TAG) .
	docker tag $(IMAGE_NAME):$(IMAGE_TAG) $(IMAGE_NAME):latest

clean:
	docker ps -a --filter label=uuid=72863671-3c02-4705-9cd1-194c4a86499e -q | xargs -r docker rm -f || true
	docker ps -a --filter label=uuid=5d5648eb-37c5-487d-8ff6-25c543f5c4a2 -q | xargs -r docker rm -f || true
	docker images --filter label=uuid=72863671-3c02-4705-9cd1-194c4a86499e -q | sort | uniq | xargs -r docker rmi -f || true
	docker images --filter label=uuid=5d5648eb-37c5-487d-8ff6-25c543f5c4a2 -q | sort | uniq | xargs -r docker rmi -f || true

