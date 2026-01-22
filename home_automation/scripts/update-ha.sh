#!/bin/bash
# Update Home Assistant to latest stable version
# Run from local machine

set -e

REMOTE_HOST="pi@192.168.0.249"

echo "Pulling latest Home Assistant image..."
ssh "$REMOTE_HOST" "docker pull ghcr.io/home-assistant/home-assistant:stable"

echo "Current version:"
ssh "$REMOTE_HOST" "docker exec homeassistant cat /config/.HA_VERSION"

read -p "Stop and recreate container? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Stopping container..."
    ssh "$REMOTE_HOST" "docker stop homeassistant"

    echo "Removing old container..."
    ssh "$REMOTE_HOST" "docker rm homeassistant"

    echo "Starting new container..."
    ssh "$REMOTE_HOST" "docker run -d \
        --name homeassistant \
        --privileged \
        --restart=unless-stopped \
        --network=host \
        -e TZ=Europe/Busingen \
        -v homeassistant_config:/config \
        ghcr.io/home-assistant/home-assistant:stable"

    echo "New version:"
    sleep 10
    ssh "$REMOTE_HOST" "docker exec homeassistant cat /config/.HA_VERSION"
    echo "Update complete!"
else
    echo "Aborted."
fi
