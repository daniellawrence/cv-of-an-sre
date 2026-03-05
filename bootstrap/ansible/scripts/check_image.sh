#!/usr/bin/env bash

ANSIBLE_IMAGE=local-ansible-runner-aws:latest

if docker images --format '{{.Repository}}:{{.Tag}}' | grep -Fxq "$ANSIBLE_IMAGE"; then
    echo "Ansible image '$ANSIBLE_IMAGE' exists locally"
    exit 0
fi

echo "Ansible image '$ANSIBLE_IMAGE' not found locally"
exit 1