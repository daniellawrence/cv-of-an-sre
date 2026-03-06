#!/usr/bin/env bash
source $(dirname $0)/lib.sh
cd $GIT_ROOT
bin/kind create cluster --config k8s/kind.cluster.yaml --kubeconfig k8s/kubeconfig.yaml
bin/kubectl cluster-info --context kind-kind --kubeconfig k8s/kubeconfig.yaml
bin/kubectl --context kind-kind --kubeconfig k8s/kubeconfig.yaml get ns