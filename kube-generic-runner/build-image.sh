#!/bin/sh

set -xe

TAG=${TAG:-"latest"}

docker build --no-cache -t italiangrid/kube-generic-runner:$TAG .
