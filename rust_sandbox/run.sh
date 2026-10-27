#!/bin/bash

source .env
CONTAINER_HOME=/home/${USERNAME}
CONTAINER_WORKDIR=${CONTAINER_HOME}/rust_sandbox
CONTAINER_NAME=${IMAGE_NAME}
IMAGE_NAME=${REGISTRY}/${IMAGE_NAME}:${TAG}

docker run -it --rm \
  -v ~/projects/rust_sandbox/:${CONTAINER_WORKDIR} \
  --name ${CONTAINER_NAME} \
  --user ${USERNAME} \
  --workdir ${CONTAINER_WORKDIR} \
  ${IMAGE_NAME} bash