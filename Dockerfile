# Use an official Ubuntu image as the base
FROM ubuntu:latest

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and install required system packages
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    git \
    curl \
    mysql-client \
    libmysqlclient-dev \
    && apt-get clean

# Create and activate a virtual environment for Python
# Check out README under issues
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Install Python packages inside the virtual environment
RUN pip install --no-cache-dir requests mysql-connector-python flask pytest
   
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
CMD ["python", "--version"]



