AWS_CDK_VERSION = 1.105.0
IMAGE_NAME ?= contino/aws-cdk:$(AWS_CDK_VERSION)
TAG = $(AWS_CDK_VERSION)

build:
	docker build -t $(IMAGE_NAME) .

test:
	docker run --rm --name cdk-env -it $(IMAGE_NAME) cdk --version

exec:
	docker exec -it cdk-env bash

shell:
	docker run --rm --name cdk-env -it -v ~/.aws:/root/.aws -v $(shell pwd):/opt/app $(IMAGE_NAME) bash

run:
	docker run --rm --name cdk-env -d -v ~/.aws:/root/.aws -v $(shell pwd):/opt/app $(IMAGE_NAME) sleep infinity

rm:
	docker rm -f cdk-env

gitTag:
	-git tag -d $(TAG)
	-git push origin :refs/tags/$(TAG)
	git tag $(TAG)
	git push origin $(TAG)
