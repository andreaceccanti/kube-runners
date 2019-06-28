#!/busybox/sh
set -xe

IMAGE=${IMAGE:-"kubemwdevel/test"}
TAG=${TAG:-"latest"}

KANIKO_OPTS=${KANIKO_OPTS:-"--insecure --skip-tls-verify"}
KANIKO_EXECUTOR=${KANIKO_EXECUTOR:-"/kaniko/executor"}

${KANIKO_EXECUTOR} -f "$(pwd)/Dockerfile" -c "$(pwd)" ${KANIKO_OPTS} \
  --destination ${DOCKER_REGISTRY_HOST}/${IMAGE}:${TAG}
