#!/usr/bin/env bash
source $(dirname $0)/lib.sh
cd $GIT_ROOT
bin/helmfile \
    --helm-binary $GIT_ROOT/bin/helm \
    --file apps/infra/gitlab \
    template --output-dir-template artefacts

bin/helmfile \
    --helm-binary $GIT_ROOT/bin/helm \
    --file apps/infra/gitlab \
    sync

GITLAB_ROOT_PASSWORD=$(./scripts/kubectl.sh get secret -n gitlab gitlab-gitlab-initial-root-password -o json | jq .data.password -r |base64 -d)

cat << EOF
url:      http://gitlab.scm.localhost
username: root
password: $GITLAB_ROOT_PASSWORD
EOF