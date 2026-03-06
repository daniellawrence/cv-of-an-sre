#!/usr/bin/env bash
# Pass args into kubectl that is pre-configured to connect to the local kind cluster.

ENTRYPOINT="/opt/bitnami/kubectl/bin/kubectl"
ARGS="--insecure-skip-tls-verify $@"

if [[ $1 == "--debug" ]];then
	echo 1
	ENTRYPOINT="/bin/bash"
	ARGS=""
fi


cat ${PWD}/bootstrap/k8s/.kube/config | sed 's/127.0.0.1/local-control-plane/g' > $HOME/.kube/config


docker run \
	-v ${PWD}:/mnt \
	-v ${PWD}/bootstrap/k8s/.kube/:/.kube \
	-it --rm \
	--network cv_default \
	--user 1000:1000 \
	--entrypoint $ENTRYPOINT \
	bitnami/kubectl:latest $ARGS