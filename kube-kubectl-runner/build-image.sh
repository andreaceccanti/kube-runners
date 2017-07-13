#!/bin/sh

set -xe

TAG=${TAG:-"1.6.4"}
JNLP_VERSION=${JNLP_VERSION:-"3.7"}

docker build --build-arg KUBE_VERSION=${TAG} --build-arg JNLP_VERSION=${JNLP_VERSION} --no-cache -t italiangrid/kube-kubectl-runner:$TAG .
