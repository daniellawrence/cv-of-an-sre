#!/usr/bin/env bash
# Pass args into aws-cli that is preconfigured to use the localstack instance.

docker run -v ${PWD}:/mnt -it --rm --network cv_default \
	-e AWS_ACCESS_KEY_ID=test \
	-e AWS_SECRET_ACCESS_KEY=test \
	-e AWS_DEFAULT_REGION=ap-southeast-2 \
	amazon/aws-cli:latest --endpoint-url=http://localstack:4566 $@