GIT_ROOT=$(git rev-parse --show-toplevel)
BIN_DIR="${GIT_ROOT}/bin"
export KUBECONFIG=${GIT_ROOT}/k8s/kubeconfig.yaml


# Configuration
GITEA_URL="http://localhost:3000"
GITEA_USERNAME="admin"
GITEA_PASSWORD="admin"