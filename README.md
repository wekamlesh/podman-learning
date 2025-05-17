# Day 2: Managing Podman Images and Containers

This project demonstrates managing Podman images and containers.

## Prerequisites

* Podman installed
* (Optional) Account on a container registry like Quay.io or Docker Hub for testing image pushing

## Setup and Usage

1. **Ensure scripts are executable:**
    ```bash
    chmod +x run_app_with_env.sh
    chmod +x cleanup.sh
    ```

2. **Run the application using the script:**
    ```bash
    ./run_app_with_env.sh
    ```
    This script will:
    * Build the Podman image `node-env-app:v1` if it doesn't exist
    * Stop and remove any existing container named `node-env-app`
    * Run a new container named `node-env-app`
    * Map port `8081` on the host to port `3000` in the container

3. **Access the application:**
    Open your web browser and go to `http://localhost:8081`

4. **Inspect the container:**
    ```bash
    podman inspect node-env-app
    ```

5. **Check logs:**
    ```bash
    podman logs node-env-app
    ```

6. **(Optional) Push to a Registry:**
    * Uncomment the push section in `run_app_with_env.sh`
    * Set `REGISTRY_USER` and `REGISTRY_REPO` variables
    * Log in to your registry: `podman login quay.io` (or `docker.io`)
    * Run `./run_app_with_env.sh` again. The script will attempt to tag and push the image

7. **Clean up:**
    To stop the container, remove it, remove the image, and prune unused Podman resources:
    ```bash
    ./cleanup.sh
    ```

## Podman Commands Learned/Used

* `podman image exists <image_name>`: Checks if an image exists locally
* `podman container exists <container_name>`: Checks if a container exists
* `podman run -d --name <name> -p <host_port>:<container_port> <image>`: Runs a container in detached mode
* `podman inspect <container_or_image>`: Displays detailed information
* `podman tag <source_image> <target_image>`: Tags an image (e.g., for a registry)
* `podman login <registry>`: Logs into a container registry
* `podman push <image_name>`: Pushes an image to a registry
* `podman system prune -f`: Removes unused data without prompting
* `podman rmi <image_name>`: Removes an image