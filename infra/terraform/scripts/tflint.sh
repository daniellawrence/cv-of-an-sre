#!/usr/bin/env bash
docker run --rm \
    -v $(pwd):/data \
    -t \
    --entrypoint /bin/sh ghcr.io/terraform-linters/tflint \
    -c "tflint --init && tflint --recursive --disable-rule=terraform_required_providers --disable-rule=terraform_required_version --format compact"