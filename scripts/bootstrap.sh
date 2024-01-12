#!/bin/bash

# Die on error
set -e

# Update then upgrade any available pre-installed packages
apt -y update
apt -y upgrade

# Docker stuff
# remove old docker installations
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done

# Install docker dependencies
# Add Docker's official GPG key:
apt-get install ca-certificates curl gnupg
install -m 0755 -d /etc/apt/keyrings

# Install Docker
apt -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update

# Install bettercap and its deps
apt -y install golang git build-essential libpcap-dev libusb-1.0-0-dev libnetfilter-queue-dev
go install github.com/bettercap/bettercap@latest