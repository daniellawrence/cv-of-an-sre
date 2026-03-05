#!/usr/bin/env bash
docker run -it -v $PWD:/apps alpine/terragrunt:tf1.14.6 $@