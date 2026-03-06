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
ADMIN_PASSWORD=$(./scripts/kubectl.sh -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
cat << EOF
bin/kubectl.sh port-forward service/argocd-server -n argocd 8080:443
user:      admin
password:  ${ADMIN_PASSWORD}
EOF