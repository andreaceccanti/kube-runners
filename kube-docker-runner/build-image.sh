#!/bin/sh

set -xe

TAG=${TAG:-"latest"}
DOCKER_GID=${DOCKER_GID:-"994"}

docker build --build-arg DOCKER_GID=${DOCKER_GID} --no-cache -t italiangrid/kube-docker-runner:${TAG} .
