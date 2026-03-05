#!/usr/bin/env bash


source ./scripts/lib.sh

set -euo pipefail

if [ -z "${AWS_CLI:-}" ]; then
    echo "AWS_CLI environment variable not set"
    exit 1
fi

if [ -z "${TF_STATE_BUCKET:-}" ]; then
    echo "TF_STATE_BUCKET environment variable not set"
    exit 1
fi

if $AWS_CLI s3 ls "s3://$TF_STATE_BUCKET" >/dev/null 2>&1; then
    echo "Terraform bucket '$TF_STATE_BUCKET' exists"
    exit 0
fi

echo "Terraform bucket '$TF_STATE_BUCKET' not found"
exit 1