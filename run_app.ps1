$IMAGE_NAME = "hello-node-podman:v1"
$CONTAINER_NAME = "hello-node-app"
$HOST_PORT = 8080       # Port on your local machine
$CONTAINER_PORT = 3000  # Port the Node.js app listens on inside the container

Write-Host "Building Node.js application image..."
# The '.' indicates that the Dockerfile is in the current directory
podman build -t $IMAGE_NAME .

# Check if the build was successful
if ($LASTEXITCODE -ne 0) {
    Write-Host "Error building image. Exiting."
    exit 1
}

Write-Host "Image $IMAGE_NAME built successfully."

# Check if a container with the same name already exists and stop/remove it
$existingContainer = podman ps -a --filter name=$CONTAINER_NAME --format "{{.Names}}"
if ($existingContainer) {
    Write-Host "Container $CONTAINER_NAME exists. Stopping and removing..."
    podman stop $CONTAINER_NAME
    podman rm $CONTAINER_NAME
}

Write-Host "Running container $CONTAINER_NAME..."
podman run -d -p ${HOST_PORT}:${CONTAINER_PORT} --name $CONTAINER_NAME $IMAGE_NAME

# Check if the container started successfully
if ($LASTEXITCODE -eq 0) {
    Write-Host "Container $CONTAINER_NAME started successfully."
    Write-Host "Access your application at http://localhost:$HOST_PORT"
    Write-Host ""
    Write-Host "Useful commands:"
    Write-Host "  List running containers: podman ps"
    Write-Host "  View container logs:     podman logs $CONTAINER_NAME"
    Write-Host "  Follow container logs:   podman logs -f $CONTAINER_NAME"
    Write-Host "  Stop the container:      podman stop $CONTAINER_NAME"
    Write-Host "  Remove the container:    podman rm $CONTAINER_NAME"
    Write-Host "  Remove the image:        podman rmi $IMAGE_NAME"
} else {
    Write-Host "Error starting container $CONTAINER_NAME."
    Write-Host "Check logs using: podman logs $CONTAINER_NAME"
}