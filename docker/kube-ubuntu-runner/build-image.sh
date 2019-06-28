#!/bin/sh

set -xe

TAG=${TAG:-"16.04"}

docker build --no-cache -t italiangrid/kube-ubuntu-runner:$TAG .
