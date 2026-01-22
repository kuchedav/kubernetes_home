# KUBERNETES_HOME

This repository is a basis for my home-setup.

Currently, I am running my setup solely on my MacBook on a single node minikube
Kubernetes cluster.

Start minikube:
```bash
minikube start
minikube addons enable ingress
minikube tunnel
````

## Naming convention

Folders which start with _* are not production ready and still experimental

## What this repo is

A local Kubernetes playground to learn core building blocks on a single-node
minikube cluster. The repo mixes plain manifests and Helm-based installs to
practice deployments, services, ingress, persistence, monitoring, logging, and
debugging workflows. Most components are meant to be brought up by hand as
learning exercises rather than as a cohesive production stack.

## Main components

- MongoDB + Mongo Express (`_mongodb/`) using Secrets and ConfigMaps.
- Jupyter notebook deployment (`_jupyter/`) with a persistent volume + claim.
- Ingress routing (`_ingress/`) for Jupyter and Mongo Express hosts.
- PostgreSQL via Helm (`postgres_db/`) with helper scripts and demo data.
- Prometheus + Grafana via Helm (`prometheus_grafana/`) and a custom scrape config.
- Cluster logging stack (`_kubernetes_logging/`) with Elasticsearch, Kibana, and
  Fluent Bit.
- Debug pod (`debug/`) for ad-hoc inspection in-cluster.
- Namespace templates (`_namespace_tmp/`) for quick experiments.
- A small kubectl cheat sheet (`cheatsheet.md`) to keep common commands handy.

## How I typically use it

- `Makefile` contains helper targets for Postgres and Prometheus/Grafana.
- Most manifests are applied directly with `kubectl apply -f ...`.
- For external access I rely on `minikube tunnel` and `kubectl port-forward`,
  plus the NGINX ingress addon and local `/etc/hosts` mapping for hostnames.

## Notes

- This is intentionally a learning sandbox; some configs are minimal, permissive,
  or non-production (e.g. example secrets, low resource requests).
- The `_` prefix marks experiments or work in progress.
