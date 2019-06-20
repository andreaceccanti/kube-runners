#!/bin/sh

set -xe

TAG=${TAG:-"latest"}

docker build --no-cache -t italiangrid/centos7-runner:$TAG .
