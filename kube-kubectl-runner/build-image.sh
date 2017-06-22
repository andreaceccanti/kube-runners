#!/bin/sh

set -xe

TAG=${TAG:-"1.4.6"}
JNLP_VERSION=${JNLP_VERSION:-"2.62"}

docker build --build-arg KUBE_VERSION=${TAG} --build-arg JNLP_VERSION=${JNLP_VERSION} --no-cache -t italiangrid/kube-kubectl-runner:$TAG .
