# Use an official Ubuntu image as the base
FROM ubuntu:latest

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and install required system packages
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    git \
    && apt-get clean

# Install Python packages
RUN python3-pip install --no-cache-dir \
    requests \
    mysql-connector-python \
    flask \
    pytest
   

# Optional: Set Python3 as the default python command
RUN ln -sf /usr/bin/python3 /usr/bin/python

# Remove unnecessary packages after installation to further slim down the image
RUN apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set a working directory (optional)
WORKDIR /app

# Copy your application code into the container (optional)
# COPY . .

# Default command (optional)
# There can only be one CMD instruction in a Dockerfile or build stage. Only the last one will have an effect.
# CMD ["python", "--version"]

# Clone down the repository && Run the Python script when the container launches
CMD ["git","clone","-b","develop","https://github.com/254In61/query-countries.git","&&","python3", "./app/scripts/server.py"]


