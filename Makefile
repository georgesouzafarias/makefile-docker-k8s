# --------------------------------------------------------------------
# Author: George Farias
# Email: georgesouzafarias@gmail.com
# 
# This software may be modified and distributed under the terms of the
# MIT license. See the LICENSE file for details.
# --------------------------------------------------------------------
# import config.
CONFIG ?= ./.config/project.ini
include $(CONFIG)
ENV_FILE ?= ./.config/env.ini

VERSION := $(shell git describe --tags --dirty --match="v*" 2> /dev/null || cat $(CURDIR)/.config/version 2> /dev/null || echo latest)

IMAGEM_HUB ?= docker.io

DOCKER_IMAGE := $(IMAGEM_HUB)/$(IMAGE_REPO)/$(APPLICATION_NAME):$(VERSION)

help:
	@echo ''
	@echo 'Usage:'
	@echo '    make (TARGET) [EXTRA ARGUMENTS]'
	@echo ''
	@echo 'TARGET can be:'	
	@echo 'image       - generates the Docker image using a build command.'
	@echo 'push        - push the Docker image to specified registry.'
	@echo 'release     - generates the Docker image and pushes to registry'	
	@echo 'run         - generates the Docker image and run it.'	
	@echo 'clean       - clean-up the image generated'	
	@echo 'clean-all   - clean-up all images generated and the all containers'	
	@echo 'help        - this message.'

image:
	docker build -t "$(DOCKER_IMAGE)" .
push:
	docker push "$(DOCKER_IMAGE)"
release: image push

run: image
	@test -f $(ENV_FILE) \
	&& docker run -d --rm --name $(APPLICATION_NAME) $(RUN_FLAGS) --env-file=$(ENV_FILE) $(DOCKER_IMAGE) \
	|| docker run -d --rm --name $(APPLICATION_NAME) $(RUN_FLAGS) $(DOCKER_IMAGE)
container-remove:
	@docker rm -f $(APPLICATION_NAME)
clean:
	@docker rmi -f $(DOCKER_IMAGE) 2>/dev/null
clean-all:
	@docker container prune -f
	@docker image prune -f