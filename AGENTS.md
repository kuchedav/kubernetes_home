# Agent notes for kubernetes_home

This repo contains a hardware documentation area under `hardware_setup/`.

## What is documented

- `hardware_setup/README.md` describes the current at-home hardware layout at a
  high level (roles, responsibilities, and usage notes).
- `hardware_setup/ip_map.local.md` contains the private name-to-IP mapping for
  the nodes. This file is intentionally excluded from git.

## Where to find it

- Public overview: `hardware_setup/README.md`
- Private IP map: `hardware_setup/ip_map.local.md`

## Handling rules

- Do not commit `hardware_setup/ip_map.local.md`.
- Keep public docs free of IPs, usernames, or other sensitive details.
- Update both files when hardware roles or addresses change.
- If new hardware is added, use the same naming convention in both places.
- Never run commands on the Raspberry Pi nodes that could break or disrupt the
  laptop's SSH connectivity (e.g., network reconfiguration, interface resets).
