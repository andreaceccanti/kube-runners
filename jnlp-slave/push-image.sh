#!/bin/sh

set -xe

DOCKER_REGISTRY_HOST=${DOCKER_REGISTRY_HOST:-"cloud-vm114.cloud.cnaf.infn.it"}
TAG=${TAG:-"latest"}

docker tag italiangrid/jnlp-agent-alpine:$TAG ${DOCKER_REGISTRY_HOST}/italiangrid/jnlp-agent-alpine:$TAG
docker tag italiangrid/jnlp-slave-alpine:$TAG ${DOCKER_REGISTRY_HOST}/italiangrid/jnlp-slave-alpine:$TAG

docker push ${DOCKER_REGISTRY_HOST}/italiangrid/jnlp-agent-alpine:$TAG
docker push ${DOCKER_REGISTRY_HOST}/italiangrid/jnlp-slave-alpine:$TAG
