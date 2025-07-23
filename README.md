# Docker & Docker Compose Installer Script

This Bash script automates the installation of **Docker** and **Docker Compose** on Ubuntu-based systems.  
It checks whether Docker and Docker Compose are already installed and installs them if missing.

## ✅ What It Does

- Installs required dependencies
- Adds Docker's official GPG key and repository
- Installs the latest versions of:
  - `docker-ce`
  - `docker-ce-cli`
  - `containerd.io`
  - `docker-buildx-plugin`
  - `docker-compose-plugin`
- Installs `docker-compose` binary manually if not available via plugin

---

## 🧾 Prerequisites

- You must run the script as a user with **sudo privileges**
- Tested on **Ubuntu 22.04+ and 24.04 (Noble)**

---

## 🚀 How to Use

### 1. Clone or download the script

```bash
git clone git@github.com:devituz/docker-install-bash.git

chmod +x install-docker.sh

./install-docker.sh
