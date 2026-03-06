#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME=local-eks

if kind get clusters | grep -q "$CLUSTER_NAME"; then
  echo "Cluster already exists"
  tail -f /dev/null
  exit 0
fi

echo "Creating kind cluster..."
kind create cluster --config /config/kind-config.yaml || true

echo "Cluster created"
kubectl cluster-info  || true
tail -f /dev/null