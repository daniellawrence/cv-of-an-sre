#!/usr/bin/env bash
source $(dirname $0)/lib.sh
cd $GIT_ROOT
bin/k3d cluster create k0 --config k8s/k3d.k0.yaml --k3s-arg "--disable=traefik@server:0"
bin/k3d kubeconfig write k0 --output=$KUBECONFIG
./scripts/kubectl.sh cluster-info
./scripts/kubectl.sh get ns