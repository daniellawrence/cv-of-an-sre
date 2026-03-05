#!/usr/bin/env bash

set -euo pipefail

CLUSTER_NAME="${KIND_CLUSTER_NAME:-local-eks}"
CONTROL_PLANE="${CLUSTER_NAME}-control-plane"

# ---- Check container exists ----
if ! docker inspect "$CONTROL_PLANE" >/dev/null 2>&1; then
    echo "kind cluster '$CLUSTER_NAME' control-plane container not found"
    exit 1
fi

# ---- Check container is running ----
if [ "$(docker inspect -f '{{.State.Running}}' "$CONTROL_PLANE")" != "true" ]; then
    echo "kind cluster '$CLUSTER_NAME' control-plane container not running"
    exit 1
fi

# ---- Check kube-apiserver process exists inside container ----
if ! docker exec "$CONTROL_PLANE" pgrep kube-apiserver >/dev/null 2>&1; then
    echo "kube-apiserver not running inside '$CONTROL_PLANE'"
    exit 1
fi

echo "kind cluster '$CLUSTER_NAME' control-plane is running"
exit 0