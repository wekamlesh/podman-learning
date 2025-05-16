# Day 1: Hello Podman with Node.js

This project is a simple Node.js Express application containerized using Podman. It serves as an introduction to basic Podman commands and concepts.

## Prerequisites

* **Podman installed:** If you haven't installed Podman yet, please follow the official installation guide for your operating system: [https://podman.io/getting-started/installation](https://podman.io/getting-started/installation)

* **Node.js and npm (optional, for local testing outside container):** While not strictly necessary for running the containerized app, having Node.js installed locally can be helpful for initially creating `package.json` or testing `app.js` directly.

## Setup and Usage

1.  **Create the project files:**
    Manually create all the files (`app.js`, `package.json`, `Dockerfile`, `run_app.sh`, `README.md`) inside the `day1-hello-podman` directory with the content provided.

2.  **Make the script executable:**
    Open your terminal, navigate to the `day1-hello-podman` directory, and run:
    ```bash
    chmod +x run_app.sh
    ```

3.  **Run the application using the script:**
    Execute the script:
    ```bash
    ./run_app.sh
    ```
    This script will:
    * Build the Podman image tagged as `hello-node-podman:v1`.
    * Stop and remove any existing container named `hello-node-app` to avoid conflicts.
    * Run a new container named `hello-node-app` in detached mode.
    * Map port `8080` on your host machine to port `3000` inside the container.

4.  **Access the application:**
    Open your web browser and navigate to `http://localhost:8080`. You should see the message: "Hello Podman with Node.js! - Day 1".

## Podman Commands Demonstrated

* `podman build -t <image_name> .`: Builds an image from a `Dockerfile` in the current directory and tags it.
* `podman run -d -p <host_port>:<container_port> --name <container_name> <image_name>`: Runs a container in detached mode, with port mapping and a specific name.
* `podman ps`: Lists currently running containers.
* `podman logs <container_name>`: Shows the logs produced by the application inside the container.
* `podman stop <container_name>`: Stops a running container.
* `podman rm <container_name>`: Removes a stopped container.
* `podman container exists <container_name>`: Checks if a container with the given name exists (used in the script).
* `podman images`: Lists locally available images.
* `podman rmi <image_name>`: Removes an image.

## Troubleshooting

* **Podman not found:** Ensure Podman is correctly installed and accessible in your PATH. Run `podman version` to verify.
* **Port conflicts:** If port `8080` on your host machine is already in use by another application, you can change the `HOST_PORT` variable in the `run_app.sh` script to a different port (e.g., `8081`). Remember to access the app using the new port in your browser.
* **Build errors:** Carefully check the output from the `podman build` command. Errors often point to issues in your `Dockerfile` (like typos, incorrect commands) or problems with `npm install` (e.g., issues in `package.json` or network problems).
* **Container not starting or exiting immediately:** Use `podman logs hello-node-app` to see any error messages from within the container that might explain why it's not running as expected. If it exited, use `podman ps -a` to find it and then get its logs.