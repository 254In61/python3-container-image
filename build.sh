#!/usr/bin/bash

# Pull the to get the latest repo.

IMAGE_NAME=python3

git_pull(){
    # Function to update code base from git
    echo "" && echo "update the the code base" && echo ""
    git pull
}

build_image(){
    # Function to build the image
    # Avoiding docker because of permission issues :
    # $ docker build -t python3 .
    #    ERROR: permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Head "http://%2Fvar%2Frun%2Fdocker.sock/_ping": dial unix /var/run/docker.sock: connect: permission denied
    echo "" && echo "Build the image" && echo ""
    podman build -t $IMAGE_NAME .
}

registry(){
    # Upload image to the docker.io registry
    echo "" && echo "Set env variables and docker login" && echo ""

    source ~/secrets/env-vars # File contains env vars
    echo "$DOCKER_ACCESS_TOKEN" | docker login --username "$DOCKER_USER" --password-stdin
    # --password-stdin flag is used for secure login without exposing the password directly in the command.

    # Check login status
    # checks the exit status ($?) of the docker login command to confirm success or failure.
    if [ $? -eq 0 ]; then
        echo "Successfully logged into Docker Hub!"
    else
        echo "Docker login failed. Please check your credentials."
        exit 1
    fi

    
    # Docker Hub requires images to be tagged in the format <docker.io>/<username>/<repository>
    echo "" && echo "tag the Image" && echo ""
    podman tag localhost/$IMAGE_NAME docker.io/254in61/$IMAGE_NAME:latest
   
    # Push image to registry
    echo "" && echo "Push the tagged image to docker.io" && echo ""
    podman push docker.io/254in61/python3
}


git_pull
build_image
registry

