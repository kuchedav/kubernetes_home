#!/bin/bash
# Backup Home Assistant and Homebridge configurations
# Run from local machine

set -e

REMOTE_HOST="pi@192.168.0.249"
BACKUP_DIR="./backups"
DATE=$(date +%Y%m%d_%H%M%S)

mkdir -p "$BACKUP_DIR"

echo "Backing up Home Assistant config..."
ssh "$REMOTE_HOST" "docker exec homeassistant tar -czf /tmp/ha-backup.tar.gz -C /config ."
scp "$REMOTE_HOST:/tmp/ha-backup.tar.gz" "$BACKUP_DIR/homeassistant-$DATE.tar.gz"
ssh "$REMOTE_HOST" "rm /tmp/ha-backup.tar.gz"

echo "Backing up Homebridge config..."
ssh "$REMOTE_HOST" "tar -czf /tmp/hb-backup.tar.gz -C /home/pi/homebridge/volumes/homebridge ."
scp "$REMOTE_HOST:/tmp/hb-backup.tar.gz" "$BACKUP_DIR/homebridge-$DATE.tar.gz"
ssh "$REMOTE_HOST" "rm /tmp/hb-backup.tar.gz"

echo "Backup complete:"
ls -la "$BACKUP_DIR"/*-$DATE.tar.gz
