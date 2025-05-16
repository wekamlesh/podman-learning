#!/bin/bash

IMAGE_NAME="hello-node-podman:v1"
CONTAINER_NAME="hello-node-app"
HOST_PORT=8080      # Port on your local machine
CONTAINER_PORT=3000 # Port the Node.js app listens on inside the container (from app.js and Dockerfile EXPOSE)

echo "Building Node.js application image..."
# The '.' indicates that the Dockerfile is in the current directory
podman build -t ${IMAGE_NAME} .

# Check if the build was successful
if [ $? -ne 0 ]; then
  echo "Error building image. Exiting."
  exit 1
fi

echo "Image ${IMAGE_NAME} built successfully."

# Check if a container with the same name already exists and stop/remove it
if podman container exists ${CONTAINER_NAME}; then
  echo "Container ${CONTAINER_NAME} exists. Stopping and removing..."
  podman stop ${CONTAINER_NAME}
  podman rm ${CONTAINER_NAME}
fi

echo "Running container ${CONTAINER_NAME}..."
podman run -d -p ${HOST_PORT}:${CONTAINER_PORT} --name ${CONTAINER_NAME} ${IMAGE_NAME}

# Check if the container started successfully
if [ $? -eq 0 ]; then
  echo "Container ${CONTAINER_NAME} started successfully."
  echo "Access your application at http://localhost:${HOST_PORT}"
  echo ""
  echo "Useful commands:"
  echo "  List running containers: podman ps"
  echo "  View container logs:     podman logs ${CONTAINER_NAME}"
  echo "  Follow container logs:   podman logs -f ${CONTAINER_NAME}"
  echo "  Stop the container:      podman stop ${CONTAINER_NAME}"
  echo "  Remove the container:    podman rm ${CONTAINER_NAME}"
  echo "  Remove the image:        podman rmi ${IMAGE_NAME}"
else
  echo "Error starting container ${CONTAINER_NAME}."
  echo "Check logs using: podman logs ${CONTAINER_NAME}"
fi
