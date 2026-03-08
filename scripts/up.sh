#!/usr/bin/env bash
source $(dirname $0)/lib.sh
cd $GIT_ROOT

./scripts/0_*
./scripts/1_*
./scripts/2_*
./scripts/3_*