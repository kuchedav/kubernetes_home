# myStrom Devices

## Smart Plugs

| Name | MAC Address | Local IP | Location/Device |
|------|-------------|----------|-----------------|
| Coffee Machine | B4:E6:2D:E9:2A:11 | 192.168.0.106 | Kitchen |
| Dehumidifier | 30:AE:A4:59:36:B8 | 192.168.0.233 | Cellar |

## Local API

myStrom plugs expose a local REST API:

```bash
# Get plug status (returns JSON with all sensor data)
curl http://192.168.0.106/report

# Get device info
curl http://192.168.0.106/info

# Turn on
curl http://192.168.0.106/relay?state=1

# Turn off
curl http://192.168.0.106/relay?state=0

# Toggle
curl http://192.168.0.106/toggle
```

### API Response Fields

| Field | Description | Unit |
|-------|-------------|------|
| `power` | Current power consumption | Watts |
| `temperature` | Internal plug temperature | °C |
| `relay` | Switch state | true/false |
| `Ws` | Energy (current period) | Watt-seconds |
| `energy_since_boot` | Total energy since boot | Watt-seconds |
| `time_since_boot` | Uptime | seconds |

## Home Assistant Integration

### Entities Created

| Entity ID | Type | Description |
|-----------|------|-------------|
| `switch.coffee_machine` | Switch | On/off control |
| `sensor.coffee_machine_power` | Sensor | Current power (W) |
| `sensor.coffee_machine_temperature` | Sensor | Temperature (°C) |
| `sensor.coffee_machine_energy` | Sensor | Energy used (kWh) |
| `switch.dehumidifier` | Switch | On/off control |
| `sensor.dehumidifier_power` | Sensor | Current power (W) |
| `sensor.dehumidifier_temperature` | Sensor | Temperature (°C) |
| `sensor.dehumidifier_energy` | Sensor | Energy used (kWh) |

### Configuration

See `configuration.yaml` for the full setup using REST sensors for power monitoring.
