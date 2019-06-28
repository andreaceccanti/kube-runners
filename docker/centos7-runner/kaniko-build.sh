#!/busybox/sh
set -xe

TAG=${TAG:-"latest"}
IMAGE=${IMAGE:-"italiangrid/centos7-runner"}
KANIKO_OPTS=${KANIKO_OPTS:-"--insecure --skip-tls-verify"}
KANIKO_EXECUTOR=${KANIKO_EXECUTOR:-"/kaniko/executor"}

${KANIKO_EXECUTOR} -f "$(pwd)/Dockerfile" -c "$(pwd)" ${KANIKO_OPTS} \
  --destination https://${DOCKER_REGISTRY_HOST}/${IMAGE}:${TAG}
