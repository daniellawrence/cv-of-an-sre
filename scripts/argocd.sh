#!/usr/bin/env bash
source $(dirname $0)/lib.sh
cd $GIT_ROOT
ARGOCD_ADMIN_PASSWORD=$(./scripts/kubectl.sh -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
bin/argocd login localhost:9999 --insecure  --username admin --password $ARGOCD_ADMIN_PASSWORD
bin/argocd --insecure --server localhost:9999 ${@}