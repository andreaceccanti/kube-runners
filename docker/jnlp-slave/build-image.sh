#!/bin/sh

set -xe

TAG=${TAG:-"latest"}

docker build --no-cache -t italiangrid/jnlp-agent-alpine:$TAG --file Dockerfile.agent .
docker build --no-cache -t italiangrid/jnlp-slave-alpine:$TAG --file Dockerfile.slave .
