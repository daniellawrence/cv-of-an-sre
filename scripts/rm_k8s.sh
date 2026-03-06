#!/usr/bin/env bash
function usage () {
    cat << EOF
usage: $0 [--lethal]
delete the kind cluster, with all its hosted resources.
EOF
}

if [[ $1 != "--lethal" ]];then
    usage
    exit 1
fi

source $(dirname $0)/lib.sh
cd $GIT_ROOT
bin/kind delete cluster --kubeconfig k8s/kubeconfig.yaml
