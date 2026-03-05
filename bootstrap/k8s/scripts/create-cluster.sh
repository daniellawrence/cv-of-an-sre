#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME=local-eks

if kind get clusters | grep -q "$CLUSTER_NAME"; then
  echo "Cluster already exists"
  exit 0
fi

echo "Creating kind cluster..."
kind create cluster --config /config/kind-config.yaml

echo "Cluster created"
kubectl cluster-info