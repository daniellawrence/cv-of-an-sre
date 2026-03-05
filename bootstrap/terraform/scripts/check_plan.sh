#!/usr/bin/env bash

set -euo pipefail

TG_IMAGE="${TG_IMAGE:-alpine/terragrunt:tf1.14.6}"
DOCKER_NETWORK="${DOCKER_NETWORK:-cv_default}"

if ! docker image inspect "$TG_IMAGE" >/dev/null 2>&1; then
    echo "Terragrunt image '$TG_IMAGE' not found"
    exit 1
fi

# Run plan and capture output
output="$(docker run --rm \
    -v "$(pwd)/terraform:/workspace" \
    -w /workspace \
    --network "$DOCKER_NETWORK" \
    -e AWS_ACCESS_KEY_ID=test \
    -e AWS_SECRET_ACCESS_KEY=test \
    -e AWS_DEFAULT_REGION=ap-southeast-2 \
    "$TG_IMAGE" \
    terragrunt plan -no-color 2>&1 || true)"

if echo "$output" | grep -q "No changes"; then
    echo "Terragrunt plan has no pending changes"
    exit 0
fi

echo "Terragrunt plan has pending changes"
exit 1