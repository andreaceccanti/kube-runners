#!/bin/sh

set -xe

TAG=${TAG:-"1.8.4"}

docker build --build-arg KUBE_VERSION=${TAG} --no-cache -t italiangrid/kube-kubectl-runner:$TAG .
