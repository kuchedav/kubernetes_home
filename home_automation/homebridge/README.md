# Homebridge

Homebridge exposes non-HomeKit smart home devices to Apple HomeKit.

## Status

| Property | Value |
|----------|-------|
| Status | Running |
| Container | homebridge_homebridge_1 |
| Image | oznu/homebridge:latest |
| Homebridge Version | 1.6.0 |
| Web UI Port | 8581 |
| Bridge Port | 51287 |
| HomeKit PIN | 210-04-787 |

## Access

- **Web UI:** http://192.168.0.249:8581
- **Username:** david
- **Password:** (set during initial setup)

## Installed Plugins

| Plugin | Version | Purpose |
|--------|---------|---------|
| homebridge-shelly | 0.19.1 | Integrates Shelly smart devices |

## HomeKit Pairing

To add Homebridge to Apple Home:

1. Open the Home app on your iPhone/iPad
2. Tap "+" > "Add Accessory"
3. Tap "More Options..." or scan the QR code from the Homebridge UI
4. Enter PIN: **210-04-787**
5. Bridge name: **Homebridge B61D**

## Configuration Files

```
homebridge/
├── docker-compose.yml       # Docker setup
├── config.json.template     # Main config (credentials redacted)
├── package.json             # Installed plugins
├── startup.sh               # Custom startup script
└── README.md                # This file
```

## Shelly Integration

The Shelly plugin connects to Shelly Cloud to control your devices. Currently integrated devices:
- 5 motorized blinds/shutters (Storen)

### Shelly Plugin Configuration

```json
{
    "name": "Shelly",
    "username": "<your-shelly-cloud-email>",
    "password": "<your-shelly-cloud-password>",
    "admin": {
        "enabled": true
    },
    "platform": "Shelly"
}
```

## Maintenance

### View Logs

```bash
ssh pi@192.168.0.249
docker logs -f homebridge_homebridge_1
```

### Restart Homebridge

```bash
ssh pi@192.168.0.249
docker restart homebridge_homebridge_1
```

### Update Homebridge

Via Web UI (recommended):
1. Go to http://192.168.0.249:8581
2. Navigate to Plugins tab
3. Click update for any outdated plugins

Via command line:
```bash
ssh pi@192.168.0.249
docker pull oznu/homebridge:latest
docker-compose -f /home/pi/homebridge/docker-compose.yml down
docker-compose -f /home/pi/homebridge/docker-compose.yml up -d
```

### Backup

Homebridge creates automatic backups daily at 02:56 AM. These are stored in `/homebridge/backups/`.

Manual backup:
```bash
ssh pi@192.168.0.249
docker exec homebridge_homebridge_1 tar -czf /tmp/hb-backup.tar.gz -C /homebridge .
docker cp homebridge_homebridge_1:/tmp/hb-backup.tar.gz ~/homebridge-backup.tar.gz
```

## Known Issues

- **NPM registry timeouts:** The Pi has DNS resolution issues, causing update checks to fail. This doesn't affect normal operation.

## Network Ports

| Port | Protocol | Purpose |
|------|----------|---------|
| 8581 | TCP | Web UI |
| 51287 | TCP | HomeKit bridge |
| 42372 | TCP | Shelly child bridge |
