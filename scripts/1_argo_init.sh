#!/usr/bin/env bash
source $(dirname $0)/lib.sh
cd $GIT_ROOT
bin/helmfile \
    --helm-binary $GIT_ROOT/bin/helm \
    --file argocd/helmfile.yaml \
    template --output-dir-template artefacts
bin/helmfile \
    --helm-binary $GIT_ROOT/bin/helm \
    --file argocd/helmfile.yaml \
    sync

./scripts/kubectl.sh get all --namespace argocd