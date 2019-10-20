# Makefile for Docker and Kubernetes Projects

# Objective
The main purpose of this project is create a tool that do the work of manager docker more easier and faster.

# Using:

## Clone this repo

```
git@github.com:georgesouzafarias/makefile-docker-k8s.git

cd ./makefile-docker-k8s
```

## File project.ini
The file project.ini is very imporant for parameter the Makefile.

`cat./.config/project.ini`

```
IMAGEM_HUB  = <HUB_URL>
IMAGE_REPO = <REPO_NAME>
APPLICATION_NAME= <APPTICATION_NAME>
```
where:

IMAGEM_HUB: The adress of the local hub.
IMAGE_REPO: The name of repository.
APPLICATION_NAME: The name of the application.

## Genererate the Version Tag

`VERSION := $(shell git describe --tags --dirty --match="v*" 2> /dev/null || cat $(CURDIR)/.config/version 2> /dev/null || echo v0.1)`

The Version of image is generated looking for a git tag beginning with **v**, if wouldn't find, a tag **v0.1** will be create together with a new file in **.config/version**.

# The Options

Usage:  make (TARGET)

Where: 
TARGET can be:

- image: Generates the Docker image using a build command.
- push: Push the Docker image to specified registry.
- release: Generates the Docker image and pushes to registry.
- help: Print the help mensage.