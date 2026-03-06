#!/usr/bin/env bash
# - nginx-ingress was removed
#   - ./scripts/kubectl.sh delete applications.argoproj.io -n argocd nginx-ingress
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

./scripts/kubectl.sh get applications.argoproj.io -n argocd traefik