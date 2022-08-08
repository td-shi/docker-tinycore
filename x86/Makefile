IMAGE_NAME := tinycore
IMAGE_VER := 13.1
IMAGE_ARC := x86
IMAGE_TAG := $(IMAGE_VER)-$(IMAGE_ARC)

.PHONY: all build stop clean

all: build

build:
	docker build -t $(IMAGE_NAME):$(IMAGE_TAG) .

clean:
	docker ps -a --filter label=uuid=07d59f60-6e12-42f2-a7ea-0a9a2d234ea5 -q | xargs -r docker rm -f || true
	docker ps -a --filter label=uuid=4f233d3b-c403-4e24-8716-4f8046de90d3 -q | xargs -r docker rm -f || true
	docker images --filter label=uuid=07d59f60-6e12-42f2-a7ea-0a9a2d234ea5 -q | sort | uniq | xargs -r docker rmi -f || true
	docker images --filter label=uuid=4f233d3b-c403-4e24-8716-4f8046de90d3 -q | sort | uniq | xargs -r docker rmi -f || true

