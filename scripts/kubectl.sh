#!/usr/bin/env bash
source $(dirname $0)/lib.sh
cd $GIT_ROOT
bin/kubectl --context kind-kind --kubeconfig k8s/kubeconfig.yaml ${@}