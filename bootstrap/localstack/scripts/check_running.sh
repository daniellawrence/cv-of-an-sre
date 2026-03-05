#!/usr/bin/env bash
if docker inspect -f '{{.State.Running}}' localstack >/dev/null 2>&1; then
    if [ "$(docker inspect -f '{{.State.Running}}' localstack 2>/dev/null)" = "true" ]; then
        echo "LocalStack container is running"
        exit 0
    fi
fi

echo "LocalStack container is not running"
exit 1