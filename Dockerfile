# Use Ubuntu 20.04 LTS as the base image
FROM ubuntu:20.04

# Update and install necessary tools
RUN apt-get update && \
    apt-get install -y \
    python3-pip \
    bedtools \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install MACS2 specifically for Python 3
RUN pip3 install MACS2

# Create a directory for scripts
RUN mkdir -p /scripts

# Set the working directory
WORKDIR /workspace

# Copy your application scripts
COPY peak_calling.sh /scripts/
COPY bedtools.sh /scripts/

# Make the scripts executable
RUN chmod +x /scripts/bedtools.sh
RUN chmod +x /scripts/peak_calling.sh

# Specify the command to run when the container starts
CMD ["/bin/bash"]
