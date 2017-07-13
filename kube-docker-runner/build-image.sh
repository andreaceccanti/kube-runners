#!/bin/sh

set -xe

TAG=${TAG:-"latest"}
JNLP_VERSION=${JNLP_VERSION:-"3.7"}

docker build --build-arg JNLP_VERSION=${JNLP_VERSION} --no-cache -t italiangrid/kube-docker-runner:${TAG} .
