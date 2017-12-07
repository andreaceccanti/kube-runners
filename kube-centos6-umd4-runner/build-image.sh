#!/bin/sh

set -xe

TAG=${TAG:-"latest"}

docker build --no-cache -t italiangrid/kube-centos6-umd4-runner:$TAG .
