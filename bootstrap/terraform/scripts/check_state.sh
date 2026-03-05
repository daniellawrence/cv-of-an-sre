#!/usr/bin/env bash

set -euo pipefail

if [ -z "${AWS_CLI:-}" ]; then
    echo "AWS_CLI environment variable not set"
    exit 1
fi

if [ -z "${TF_STATE_BUCKET:-}" ]; then
    echo "TF_STATE_BUCKET environment variable not set"
    exit 1
fi

TF_STATE_KEY=global/terraform.tfstate

if $AWS_CLI s3 ls "s3://$TF_STATE_BUCKET/$TF_STATE_KEY" >/dev/null 2>&1; then
    echo "Terraform state file found in bucket"
    exit 0
fi

echo "Terraform state file not found in bucket"
exit 1