#!/usr/bin/env bash
source $(dirname $0)/lib.sh
cd $GIT_ROOT
bin/helmfile \
    --helm-binary $GIT_ROOT/bin/helm \
    --file apps/infra/traefik \
    template --output-dir-template artefacts

bin/helmfile \
    --helm-binary $GIT_ROOT/bin/helm \
    --file apps/infra/traefik \
    sync

curl -vso /dev/null -H host:dashboard.localhost http://localhost:8080/dashboard/

