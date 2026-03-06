#!/usr/bin/env bash

docker run --rm -it -v ${PWD}:/workspace -w /workspace \
    --network cv_default \
    -e AWS_ACCESS_KEY_ID=test \
    -e AWS_SECRET_ACCESS_KEY=test \
    -e AWS_DEFAULT_REGION=ap-southeast-2 \
    alpine/terragrunt:tf1.14.6 ${@}
