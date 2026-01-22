# Home Automation

This folder documents the home automation setup running on the main Raspberry Pi node.

## Overview

| Service        | Status  | Host          | Port | Version    |
|----------------|---------|---------------|------|------------|
| Home Assistant | Running | 192.168.0.249 | 8123 | 2023.8.1   |
| Homebridge     | Running | 192.168.0.249 | 8581 | 1.6.0      |

Both services run as Docker containers with `network_mode: host`.

## Quick Access

- **Home Assistant UI:** http://192.168.0.249:8123
- **Homebridge UI:** http://192.168.0.249:8581 (user: david)
- **HomeKit PIN:** 210-04-787

## Architecture

```
┌─────────────────────────────────────────────────┐
│            main-node (192.168.0.249)            │
│                                                 │
│  ┌─────────────────┐    ┌──────────────────┐   │
│  │  Home Assistant │    │    Homebridge    │   │
│  │   (Docker)      │    │    (Docker)      │   │
│  │   Port 8123     │    │    Port 8581     │   │
│  └────────┬────────┘    └────────┬─────────┘   │
│           │                      │             │
│           └──────────┬───────────┘             │
│                      │                         │
│              HomeKit Integration               │
│                      │                         │
└──────────────────────┼─────────────────────────┘
                       │
              ┌────────┴────────┐
              │  Apple HomeKit  │
              │  (iPhone/iPad)  │
              └─────────────────┘
```

## Connected Devices

- **5x Shelly motorized blinds/shutters** (via Homebridge Shelly plugin)

## Automations

| Name | Description | Trigger |
|------|-------------|---------|
| Close all Storen | Closes all 5 blinds | Manual |
| Open all Storen | Opens all 5 blinds | Manual |

## Folder Structure

```
home_automation/
├── README.md                  # This file
├── docker-compose.yml         # Combined Docker Compose for all services
├── configuration.yaml         # Home Assistant main config (backup)
├── automations.yaml           # Home Assistant automations (backup)
├── homebridge/                # Homebridge configuration
│   ├── README.md              # Homebridge-specific docs
│   ├── docker-compose.yml     # Homebridge Docker setup
│   ├── config.json.template   # Config template (credentials redacted)
│   ├── package.json           # Installed plugins
│   └── startup.sh             # Custom startup script
└── scripts/
    ├── backup.sh              # Backup both services
    └── update-ha.sh           # Update Home Assistant
```

## Maintenance

### View Logs

```bash
# Home Assistant
ssh pi@192.168.0.249 "docker logs -f homeassistant"

# Homebridge
ssh pi@192.168.0.249 "docker logs -f homebridge_homebridge_1"
```

### Restart Services

```bash
ssh pi@192.168.0.249 "docker restart homeassistant"
ssh pi@192.168.0.249 "docker restart homebridge_homebridge_1"
```

### Backup

Run from this directory:
```bash
./scripts/backup.sh
```

### Update

Home Assistant:
```bash
./scripts/update-ha.sh
```

Homebridge (via Web UI recommended):
1. Go to http://192.168.0.249:8581
2. Navigate to Plugins tab
3. Update plugins as needed

## Known Issues

- **DNS resolution on Pi:** The Raspberry Pi has intermittent DNS issues, causing npm registry timeouts in Homebridge. This doesn't affect normal operation.
- **Outdated versions:** Both services are running versions from 2023. Consider updating for security patches and new features.

## On the Raspberry Pi

Actual container data locations on `main-node`:
- Home Assistant config: Docker volume `homeassistant_config` → `/config`
- Homebridge config: `/home/pi/homebridge/volumes/homebridge` → `/homebridge`
