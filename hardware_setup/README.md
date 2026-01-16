# Hardware setup

This documents my current at-home hardware layout at a high level. It is meant
as a human-readable map of roles and responsibilities without listing sensitive
IP addresses. Use the private mapping file in this folder for exact addresses.

## Nodes

- main-node: Primary Raspberry Pi node that runs the control plane services.
- worker-1: First Raspberry Pi worker for running workloads.
  - Both nodes are dual-homed on `eth0` with addresses in two private subnets
    (details in the private IP map).
- DavidNAS: Synology NAS on the primary LAN.

## Cluster notes

- Kubernetes is currently run as a small learning cluster on the Raspberry Pis.
- Access is via SSH; hostnames are mapped in the private IP map.
- Add new nodes here using the same naming convention.

## Network

- Local LAN only; no public exposure intended.
- Primary LAN uses the `192.168.0.0/24` private subnet.
- A legacy secondary subnet (`192.168.50.0/24`) is no longer used on the Pis.
- Ingress and service exposure is handled inside the cluster as needed.

## Discovery snapshot (from the admin laptop)

- Admin laptop: MacBook Pro on Wi-Fi (`en0`) with a single IPv4 on the LAN.
- Default route points to the LAN gateway (see private map).
- ARP table shows multiple local devices; only the nodes tracked in docs are
  mapped in the private IP file.
- `nmap` is not installed locally, so no active scan was run.

## Raspberry Pi network notes

- `main-node`
  - `eth0` on the primary LAN; `wlan0` is down.
  - Default route uses the primary LAN gateway.
  - `docker0` bridge exists (`172.17.0.0/16`) but is currently down.
- `worker-1`
  - `eth0` on the primary LAN.
  - Default route uses the primary LAN gateway.
  - `docker0` bridge exists (`172.17.0.0/16`) but is currently down.

## Synology NAS network notes

- `DavidNAS`
  - `eth0` on the primary LAN.
  - `eth1` carries a link-local `169.254.0.0/16` address.
  - Default gateway is the primary LAN router.
  - Docker bridge `172.17.0.0/16` is present.

## Tools on Raspberry Pis

- `main-node`: Docker 23.0.4, Python 3.7.3, pip 18.1, net-tools 1.60+git20180626.aebd88e-1; `uv` not installed.
- `worker-1`: Docker 23.0.1, Python 3.7.3, pip 18.1, net-tools 1.60+git20180626.aebd88e-1; `uv` not installed.
- Latest-check attempt: `apt-get update` failed due to DNS resolution errors on
  both nodes, so package upgrades and `uv` installation could not be verified
  or completed.

## Update flow

- Update this file when hardware roles change or nodes are added.
- Update the private IP map whenever addresses change.
