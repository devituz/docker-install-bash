#!/bin/bash

echo "Checking and installing Docker and Docker Compose if needed..."

# === Check and install Docker ===
if ! command -v docker &> /dev/null; then
    echo "🔧 Docker is not installed. Installing Docker..."

    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common gnupg

    # Add Docker's official GPG key
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
        sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

    # Add Docker's repository (Ubuntu codename is detected automatically)
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
      https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update

    # Install latest Docker packages
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    if [ $? -ne 0 ]; then
        echo "❌ Docker installation failed. Exiting."
        exit 1
    else
        echo "✅ Docker installed successfully."
    fi
else
    echo "✅ Docker is already installed."
fi

# === Check and install Docker Compose (standalone binary if missing) ===
if ! command -v docker-compose &> /dev/null; then
    echo "🔧 docker-compose binary not found. Installing manually..."

    sudo curl -SL "https://github.com/docker/compose/releases/download/v2.27.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose

    if [ $? -ne 0 ]; then
        echo "❌ Docker Compose installation failed. Exiting."
        exit 1
    else
        echo "✅ Docker Compose installed successfully."
    fi
else
    echo "✅ Docker Compose is already installed."
fi

echo "🎉 Docker and Docker Compose are ready to use!"
