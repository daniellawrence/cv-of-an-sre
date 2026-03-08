#!/usr/bin/env bash
source $(dirname $0)/lib.sh
cd $GIT_ROOT
bin/helmfile \
    --helm-binary $GIT_ROOT/bin/helm \
    --file apps/infra/grafana \
    template --output-dir-template artefacts

bin/helmfile \
    --helm-binary $GIT_ROOT/bin/helm \
    --file apps/infra/grafana \
    sync


GRAFANA_ADMIN_PASWORD=$(./scripts/kubectl.sh get secrets -n grafana -o json grafana | jq '.data["admin-password"]' -r | base64 -d)
cat << EOF
url:      http://grafana.localhost
username: admin
password: $GRAFANA_ADMIN_PASWORD
EOF