#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# Update package list and install prerequisites
sudo apt update
sudo apt install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev

# Define the Python version
VERSION=3.10.4

# Download and extract the Python source code
wget https://www.python.org/ftp/python/$VERSION/Python-$VERSION.tgz
tar -xf Python-$VERSION.tgz
cd Python-$VERSION/

# Configure and compile Python
./configure --enable-optimizations
make -j $(nproc)

# Install Python
sudo make altinstall

# Install pip for the new Python version
curl -sS https://bootstrap.pypa.io/get-pip.py | sudo python3.10

# Verify the installation
python3.10 --version
pip3.10 --version

