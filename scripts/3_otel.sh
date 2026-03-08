#!/usr/bin/env bash
source $(dirname $0)/lib.sh
cd $GIT_ROOT
bin/helmfile \
    --helm-binary $GIT_ROOT/bin/helm \
    --file apps/infra/opentelemetry \
    template --output-dir-template artefacts

bin/helmfile \
    --helm-binary $GIT_ROOT/bin/helm \
    --file apps/infra/opentelemetry \
    sync