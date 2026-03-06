GIT_ROOT=$(git rev-parse --show-toplevel)
BIN_DIR="${GIT_ROOT}/bin"
KUBECONFIG=${GIT_ROOT}/k8s/kubeconfig.yaml