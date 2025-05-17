#!/bin/bash

IMAGE_NAME="node-env-app:v1"
CONTAINER_NAME="node-env-app"
HOST_PORT=8081
CONTAINER_PORT=3000

if ! podman image exists ${IMAGE_NAME}; then
    echo "Building Node.js application image..."
    podman build -t ${IMAGE_NAME} .
    if [ $? -ne 0 ]; then
        echo "Error building image. Exiting..."
        exit 1
    fi
    echo "Image ${IMAGE_NAME} built successfully."
else
    echo "Image ${IMAGE_NAME} already exists."
fi

if podman container exists ${CONTAINER_NAME}; then
    echo "Stopping and removing existing container ${CONTAINER_NAME}..."
    podman stop ${CONTAINER_NAME}
    podman rm ${CONTAINER_NAME}
fi

echo "Running container ${CONTAINER_NAME}..."
podman run -d --name ${CONTAINER_NAME} -p ${HOST_PORT}:${CONTAINER_PORT} ${IMAGE_NAME}

if [ $? -eq 0 ]; then
    echo "Container ${CONTAINER_NAME} started successfully on port ${HOST_PORT}."
    echo "Access the application at http://localhost:${HOST_PORT}"
    echo "To inspect: podman inspect ${CONTAINER_NAME}"
    echo "To see logs: podman logs ${CONTAINER_NAME}"
    echo "To stop: podman stop ${CONTAINER_NAME}"
else
    echo "Error starting container ${CONTAINER_NAME}."
fi

# Example of pushing (requires login and a valid registry/repo)
# REGISTRY_USER="your_username"
# REGISTRY_REPO="your_repo_name" # e.g., quay.io/your_username/node-env-app or docker.io/your_username/node-env-app
# if [ ! -z "${REGISTRY_USER}" ]; then
#     echo "Tagging image for registry: ${REGISTRY_REPO}:${IMAGE_NAME##*:}"
#     podman tag ${IMAGE_NAME} ${REGISTRY_REPO}:${IMAGE_NAME##*:}
#     echo "Attempting to push. You might need to 'podman login <registry>' first."
#     # podman login quay.io # or docker.io
#     podman push ${REGISTRY_REPO}:${IMAGE_NAME##*:}
# fi