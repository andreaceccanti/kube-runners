#!/bin/sh

set -xe

TAG=${TAG:-"latest"}
JNLP_VERSION=${JNLP_VERSION:-"3.7"}
DOCKER_GID=${DOCKER_GID:-"992"}

docker build --build-arg JNLP_VERSION=${JNLP_VERSION} --build-arg DOCKER_GID=${DOCKER_GID} --no-cache -t italiangrid/kube-docker-runner:${TAG} .
