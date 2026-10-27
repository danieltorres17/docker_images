#!/bin/bash

source .env

docker build \
  --build-arg USERNAME=${USERNAME} \
  --build-arg USER_UID=$(id -u) \
  -t ${REGISTRY}/${IMAGE_NAME}:${TAG} \
  -f Dockerfile .