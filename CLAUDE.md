# Project: Kubernetes Home

## Infrastructure

### Raspberry Pi Nodes
Two Raspberry Pis accessible via SSH:
- `main-node` - Primary node (192.168.0.249) running control plane and Home Assistant
- `worker-1` - Worker node (192.168.0.6) for workloads

### Home Assistant
- URL: http://192.168.0.249:8123
- Running as Docker container on main-node
- Credentials stored in `home_automation/.credentials`
