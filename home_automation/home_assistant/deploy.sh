#!/bin/bash
# Deploy Home Assistant configuration to the Raspberry Pi
# Run this from the home_assistant directory

set -e

PI_HOST="pi@192.168.0.249"
CONTAINER="homeassistant"
REMOTE_CONFIG_DIR="/tmp/ha_config"

echo "=== Deploying Home Assistant Configuration ==="

# Copy config files to Pi
echo "Copying configuration files to Pi..."
ssh "$PI_HOST" "mkdir -p $REMOTE_CONFIG_DIR"
scp configuration.yaml "$PI_HOST:$REMOTE_CONFIG_DIR/"
scp automations.yaml "$PI_HOST:$REMOTE_CONFIG_DIR/"
scp lovelace-dashboards.yaml "$PI_HOST:$REMOTE_CONFIG_DIR/"

# Copy files into container
echo "Copying files into Home Assistant container..."
ssh "$PI_HOST" "docker cp $REMOTE_CONFIG_DIR/configuration.yaml $CONTAINER:/config/"
ssh "$PI_HOST" "docker cp $REMOTE_CONFIG_DIR/automations.yaml $CONTAINER:/config/"
ssh "$PI_HOST" "docker cp $REMOTE_CONFIG_DIR/lovelace-dashboards.yaml $CONTAINER:/config/"

# Validate configuration
echo "Validating Home Assistant configuration..."
ssh "$PI_HOST" "docker exec $CONTAINER python -m homeassistant --config /config --script check_config" || {
    echo "WARNING: Config validation returned errors, but continuing..."
}

# Restart Home Assistant
echo "Restarting Home Assistant..."
ssh "$PI_HOST" "docker restart $CONTAINER"

# Cleanup
ssh "$PI_HOST" "rm -rf $REMOTE_CONFIG_DIR"

echo "=== Deployment complete ==="
echo "Home Assistant is restarting. Dashboard will be available at:"
echo "  http://192.168.0.249:8123"
echo ""
echo "The 'Smart Home' dashboard should appear in the sidebar."
