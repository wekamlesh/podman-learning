#!/bin/bash

IMAGE_NAME="node-env-app:v1"
CONTAINER_NAME="node-env-app"

if podman image exists ${IMAGE_NAME}; then
    echo "Removing image ${IMAGE_NAME}..."
    podman rmi ${IMAGE_NAME}
fi

if podman container exists ${CONTAINER_NAME}; then
    echo "Stopping and removing container ${CONTAINER_NAME}..."
    podman stop ${CONTAINER_NAME}
    podman rm ${CONTAINER_NAME}
fi

echo "Pruning all containers and images..."
podman system prune -f

echo "Cleanup complete."