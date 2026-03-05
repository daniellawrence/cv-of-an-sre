# --------------------------------------------------
# Config
# --------------------------------------------------
export NETWORK="cv_default"
export LOCALSTACK_ENDPOINT="http://localstack:4566"
export REGION="ap-southeast-2"
export ACCOUNT_ID="000000000000"

export CF_STACK_NAME="terraform-stack"

export TF_STATE_BUCKET="terraform-state-${ACCOUNT_ID}-${REGION}"
export LOCK_TABLE="terraform-lock-${ACCOUNT_ID}-${REGION}"
export BOUNDARY_POLICY="terraform-root-boundary-${ACCOUNT_ID}"
export STATE_ACCESS_POLICY="terraform-state-access-${ACCOUNT_ID}"
export PLAN_ROLE="terraform-root-plan-${ACCOUNT_ID}"
export APPLY_ROLE="terraform-root-apply-${ACCOUNT_ID}"

export AWS_CLI="docker run -v $PWD:/mnt --rm --network cv_default \
  -e AWS_ACCESS_KEY_ID=test \
  -e AWS_SECRET_ACCESS_KEY=test \
  -e AWS_DEFAULT_REGION=ap-southeast-2 \
  amazon/aws-cli:latest --endpoint-url=http://localstack:4566"

export KUBECTL="docker exec -it local-control-plane kubectl"