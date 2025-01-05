# Overview
- Building a docker image that has the needed packages to run as Application server and also as end-client testing containers.

# Build the Docker Image

- Run the following command in the directory where the Dockerfile is located:
  $ podman build -t python3 .  

- Avoiding docker because of permission issues :
  $ docker build -t python3 .
   ERROR: permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Head "http://%2Fvar%2Frun%2Fdocker.sock/_ping": dial unix /var/run/docker.sock: connect: permission denied