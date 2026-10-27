#!/bin/bash

source .env
CONTAINER_HOME=/home/${USERNAME}
CONTAINER_NAME=${IMAGE_NAME}
CONTAINER_WORKDIR=${CONTAINER_HOME}/cpp_sandbox
IMAGE_NAME=${REGISTRY}/${IMAGE_NAME}:${TAG}

xhost +local:docker > /dev/null 2>&1 

docker run -it --rm \
  --network host \
  --privileged \
  -e DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /etc/localtime:/etc/localtime:ro \
  -v ~/projects/cpp_sandbox/:${CONTAINER_WORKDIR} \
  --name ${CONTAINER_NAME} \
  --user ${USERNAME} \
  --workdir ${CONTAINER_WORKDIR} \
  ${IMAGE_NAME} bash