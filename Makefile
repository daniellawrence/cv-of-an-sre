# Tool versions
HELM_VERSION := v3.14.0
KUBECTL_VERSION := v1.29.0
KIND_VERSION := v0.22.0
K3D_VERSION := v5.8.3
TERRAGRUNT_VERSION := v0.56.0
TERRAFORM_VERSION := v1.14.6
ARGOCD_VERSION := v3.3.2
GITLAB_CLI := 1.89.0

# Hardcoded for Linux amd64
OS := linux
ARCH := amd64

.PHONY: help
help:
	@echo "Available targets:"
	@echo "  make install-helm           - Download and install Helm"
	@echo "  make install-helmfile       - Download and install Helmfile"
	@echo "  make install-kubectl        - Download and install kubectl"
	@echo "  make install-kind           - Download and install KinD"
	@echo "  make install-terragrunt     - Download and install Terragrunt"
	@echo "  make install-terraform      - Download and install Terraform"
	@echo "  make install-all            - Download and install all tools"

.PHONY: install-all
install-all: install-helm install-helmfile install-kubectl install-kind install-terragrunt install-terraform install-argocd install-cloud-provider-kind install-k3d install-glab
	@echo "✓ All tools installed!"

# Helm
.PHONY: install-helm
install-helm: bin/helm
bin/helm:
	@echo "Installing Helm $(HELM_VERSION)..."
	@mkdir -p bin/
	@curl -fsSL -o helm.tar.gz https://get.helm.sh/helm-$(HELM_VERSION)-$(OS)-$(ARCH).tar.gz
	@tar xzf helm.tar.gz -C bin/ --strip-components=1 $(OS)-$(ARCH)/helm
	@rm helm.tar.gz
	@chmod +x bin/helm
	@echo "✓ Helm installed: $$(bin/helm version --short)"

# Helmfile
.PHONY: install-helmfile
install-helmfile: bin/helmfile
bin/helmfile:
	@echo "Installing Helmfile..."
	@mkdir -p bin/
	@curl -fsSL -o bin/helmfile https://github.com/roboll/helmfile/releases/latest/download/helmfile_$(OS)_$(ARCH)
	@chmod +x bin/helmfile
	@echo "✓ Helmfile installed: $$(bin/helmfile version)"

# kubectl
.PHONY: install-kubectl
install-kubectl: bin/kubectl
bin/kubectl:
	@echo "Installing kubectl $(KUBECTL_VERSION)..."
	@mkdir -p bin/
	@curl -fsSL -o bin/kubectl https://dl.k8s.io/release/$(KUBECTL_VERSION)/bin/$(OS)/$(ARCH)/kubectl
	@chmod +x bin/kubectl
	@echo "✓ kubectl installed: $$(bin/kubectl version --client --short)"



# k3d
.PHONY: install-k3d
install-kind: bin/k3d
bin/k3d:
	@echo "Installing k3d $(K3D_VERSION)..."
	@mkdir -p bin/
	@curl -fsSL -o bin/k3d https://github.com/k3d-io/k3d/releases/download/v5.9.0-rc.0/k3d-linux-amd64
	@chmod +x bin/k3d
	@echo "✓ k3d installed: $$(bin/k3d version)"

# KinD
.PHONY: install-kind
install-kind: bin/kind
bin/kind:
	@echo "Installing KinD $(KIND_VERSION)..."
	@mkdir -p bin/
	@curl -fsSL -o bin/kind https://kind.sigs.k8s.io/dl/$(KIND_VERSION)/kind-$(OS)-$(ARCH)
	@chmod +x bin/kind
	@echo "✓ KinD installed: $$(bin/kind version)"

# Cloud Provider KinD
.PHONY: install-cloud-provider-kind
install-cloud-provider-kind: bin/cloud-provider-kind
bin/cloud-provider-kind:
	@echo "Installing cloud-provider-kind $(CLOUD_PROVIDER_KIND_VERSION)..."
	@mkdir -p bin/
	@curl -fsSL https://github.com/kubernetes-sigs/cloud-provider-kind/releases/download/v0.10.0/cloud-provider-kind_0.10.0_linux_amd64.tar.gz | tar xz -C bin/
	@chmod +x bin/cloud-provider-kind
	@echo "✓ cloud-provider-kind installed: $$(bin/cloud-provider-kind version 2>/dev/null || echo 'ready')"

# Terragrunt
.PHONY: install-terragrunt
install-terragrunt: bin/terragrunt
bin/terragrunt:
	@echo "Installing Terragrunt $(TERRAGRUNT_VERSION)..."
	@mkdir -p bin/
	@curl -fsSL -o bin/terragrunt https://github.com/gruntwork-io/terragrunt/releases/download/v0.99.4/terragrunt_linux_amd64
	@chmod +x bin/terragrunt
	@echo "✓ Terragrunt installed: $$(bin/terragrunt --version)"

# Terraform
.PHONY: install-terraform
install-terraform: bin/terraform
bin/terraform:
	@echo "Installing Terraform $(TERRAFORM_VERSION)..."
	@mkdir -p bin/
	@curl -fsSL -o terraform.zip https://releases.hashicorp.com/terraform/$(subst v,,$(TERRAFORM_VERSION))/terraform_$(subst v,,$(TERRAFORM_VERSION))_$(OS)_$(ARCH).zip
	@unzip -q -o terraform.zip -d bin/
	@rm terraform.zip
	@chmod +x bin/terraform
	@echo "✓ Terraform installed: $$(bin/terraform version)"

# argocd
.PHONY: install-argocd
install-argocd: bin/argocd
bin/argocd:
	@echo "Installing argocd $(ARGOCD_VERSION)..."
	@mkdir -p bin/
	@curl -sSL -o bin/argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
	@chmod +x bin/argocd
	@echo "✓ argocd installed: $$(./bin/argocd  version --short --client)"

# argocd
.PHONY: install-glab
install-glab: bin/glab
bin/glab:
	@echo "Installing glab $(GITLAB_CLI)..."
	@mkdir -p bin/
	@curl -sSL -o glab.tar.gz https://gitlab.com/gitlab-org/cli/-/releases/v1.89.0/downloads/glab_1.89.0_linux_amd64.tar.gz
	@tar xzf glab.tar.gz -C bin/ --strip-components=1 
	@rm glab.tar.gz
	@chmod +x bin/glab
	@echo "✓ glab installed: $(./bin/glab  --version)"






.PHONY: clean
clean:
	@echo "Removing bin/ directory..."
	@rm -rf bin/
	@echo "✓ Clean complete"

.PHONY: check-versions
check-versions:
	@echo "Checking installed versions..."
	@test -x bin/helm       && echo "Helm:       $$(bin/helm version --short)" || echo "Helm: not installed"
	@test -x bin/helmfile   && echo "Helmfile:   $$(bin/helmfile version)" || echo "Helmfile: not installed"
	@test -x bin/kubectl    && echo "kubectl:    $$(bin/kubectl version --client | head -1)" || echo "kubectl: not installed"
	@test -x bin/kind       && echo "KinD:       $$(bin/kind version)" || echo "KinD: not installed"
	@test -x bin/terragrunt && echo "Terragrunt: $$(bin/terragrunt --version | head -1)" || echo "Terragrunt: not installed"
	@test -x bin/terraform  && echo "Terraform:  $$(bin/terraform version | head -1)" || echo "Terraform: not installed"