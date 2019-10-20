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

VERSION := $(shell git describe --tags --dirty --match="v*" 2> /dev/null || cat $(CURDIR)/.config/version 2> /dev/null || echo v0.1)

DOCKER_IMAGE := $(IMAGE_HUB)/$(IMAGE_REPO)/$(APPLICATION_NAME):$(VERSION)

help:
	@echo ''
	@echo 'Usage:'
	@echo '    make (TARGET) [EXTRA ARGUMENTS]'
	@echo ''
	@echo 'TARGET can be:'	
	@echo 'image       - generates the Docker image using a build command.'
	@echo 'push        - push the Docker image to specified registry.'
	@echo 'release     - generates the Docker image and pushes to registry'	
	@echo 'help        - this message.'

image:
	docker build -t "$(DOCKER_IMAGE)" .
push:
	docker push "$(DOCKER_IMAGE)"
release:
	make image push	