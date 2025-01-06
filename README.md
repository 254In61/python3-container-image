# Overview
- Building a docker image that has the needed packages to run as Application server and also as end-client testing containers.
- Image was built for this project : https://github.com/254In61/query-countries.git

# Build the Docker Image

- Run the script build.sh
  $ ./build.sh

# noted issues
# Issue 1
STEP 4/8: RUN pip3 install --no-cache-dir requests mysql-connector-python flask pytest
error: externally-managed-environment

× This environment is externally managed
╰─> To install Python packages system-wide, try apt install
    python3-xyz, where xyz is the package you are trying to
    install.

    If you wish to install a non-Debian-packaged Python package,
    create a virtual environment using python3 -m venv path/to/venv.
    Then use path/to/venv/bin/python and path/to/venv/bin/pip. Make
    sure you have python3-full installed.

    If you wish to install a non-Debian packaged Python application,
    it may be easiest to use pipx install xyz, which will manage a
    virtual environment for you. Make sure you have pipx installed.

    See /usr/share/doc/python3.12/README.venv for more information.

note: If you believe this is a mistake, please contact your Python installation or OS distribution provider. You can override this, at the risk of breaking your Python installation or OS, by passing --break-system-packages.
hint: See PEP 668 for the detailed specification.
Error: error building at STEP "RUN pip3 install --no-cache-dir requests mysql-connector-python flask pytest": error while running runtime: exit status 1

## Explanation
The error occurs because Debian-based systems (like Ubuntu) have started enforcing PEP 668, which marks the system Python environment as externally managed. 
This prevents system-wide installations of Python packages using pip to avoid conflicts with the OS package manager.

## Best solution
Using a virtual environment is the cleanest and safest approach. It avoids interference with the system Python environment while still allowing you to manage your dependencies independently.

# Keeping container running.
When you start a container, it usually stops if there’s no long-running process or command running in the foreground. 
To ensure the container doesn't stop, you can run it with a long-lived process or execute a command that holds the container open.

Here are several ways to start a container that doesn't stop:

1. Run an Interactive Shell : You can start the container with a shell session that keeps running:

   $ podman run -it localhost/python3 /bin/bash

2. Use a Background Process that keeps the container alive.
   $ podman run -d localhost/python3 tail -f /dev/null

   tail -f /dev/null is a common trick to keep the container running indefinitely.

3. Use a Custom Entrypoint Script
If you’re building a custom image, add an entrypoint script that keeps the container running. For example, in a Dockerfile:

  FROM ubuntu:20.04

  CMD ["tail", "-f", "/dev/null"]

4. Run a Service or Daemon
Run a service (e.g., an HTTP server) to keep the container alive:
  $ podman run -d nginx

5. Keep the Container in Interactive Mode
Start the container in interactive mode and leave it open:
  $ podman run -it localhost/python3


# Stopping containers

podman stop <container_id>

podman rm <container_id>
