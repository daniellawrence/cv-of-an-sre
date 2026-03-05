#!/usr/bin/env bash

set -u

THIS_DIR=$(dirname $0)
LIB_FILE=${THIS_DIR}/lib.sh
if [[ ! -f $LIB_FILE ]];then
  echo "ERROR: missing lib.sh $LIB_FILE"
  exit 1
fi

source $LIB_FILE

# --------------------------------------------------
# Flags
# --------------------------------------------------
VERBOSE=0

while getopts ":v" opt; do
  case ${opt} in
    v)
      VERBOSE=1
      ;;
    \?)
      echo "Usage: $0 [-v]"
      exit 1
      ;;
  esac
done

shift $((OPTIND -1))


# --------------------------------------------------
# Directories
# --------------------------------------------------
SUBDIRS=(
  "localstack"
  "ansible"
  "cloudformation"
  "k8s"
  terraform
  argocd
)

MAX_FAILURES=3
FAILURES=0
TIMEOUT_SECONDS=30

# --------------------------------------------------
# Colours
# --------------------------------------------------
GREEN="\033[0;32m"
RED="\033[0;31m"
YELLOW="\033[1;33m"
NC="\033[0m"

tick()   { echo -e "${GREEN}✔${NC} $1"; }
cross()  { echo -e "${RED}✘${NC} $1"; }

fail_check() {
  cross "$1"
  FAILURES=$((FAILURES + 1))

  if [ "$FAILURES" -ge "$MAX_FAILURES" ]; then
    echo -e "\n${RED}Too many failures (${FAILURES}). Aborting.${NC}"
    exit 1
  fi
}


fail() {
    ((FAILURES++))
    if [ "$FAILURES" -ge "$MAX_FAILURES" ]; then
        echo
        echo "❌ Stopping early — reached ${MAX_FAILURES} failures."
        exit 1
    fi
}

# --------------------------------------------------
# Main loop
# --------------------------------------------------
for dir in "${SUBDIRS[@]}"; do
    echo "== Checking directory: $dir =="

    if [ ! -d "$dir/scripts" ]; then
        echo "  ✘ FAIL: missing scripts directory"
        fail
        echo
        break
    fi

    checks=( "$dir"/scripts/check_* )

    if [ ! -e "${checks[0]}" ]; then
        echo "  ✘ FAIL: no check_* files found"
        fail
        echo
        break
    fi

    IFS=$'\n' sorted_checks=($(printf "%s\n" "${checks[@]}" | sort))
    unset IFS

    for check in "${sorted_checks[@]}"; do
        [ -x "$check" ] || chmod +x "$check"

        if [ "$VERBOSE" -eq 1 ]; then
            output=$(timeout "${TIMEOUT_SECONDS}s" bash -x "$check" 2>&1)
        else
            output=$(timeout "${TIMEOUT_SECONDS}s" "$check" 2>&1)
        fi

        exit_code=$?

        case "$exit_code" in
            0)
                echo -e "  ${GREEN}✔ PASS${NC}: $(basename "$check") - $output"
                ;;
            124)
                echo -e "  ${RED}✘ FAIL${NC}: $(basename "$check") - Timed out after ${TIMEOUT_SECONDS}s"
                fail
                ;;
            *)
                echo -e "  ${RED}✘ FAIL${NC}: $(basename "$check") - $output"
                fail
                ;;
        esac
    done

    echo
done

# --------------------------------------------------
# Final exit
# --------------------------------------------------
if [ "$FAILURES" -gt 0 ]; then
    exit 1
else
    exit 0
fi