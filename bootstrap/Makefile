PROJECT_DIR := $(PWD)
ANSIBLE_IMAGE := local-ansible-runner-aws:latest
CF_PLAYBOOK := ansible/playbook.cloudformation.yaml

AWS_ENV := \
	-e AWS_ACCESS_KEY_ID=test \
	-e AWS_SECRET_ACCESS_KEY=test \
	-e AWS_DEFAULT_REGION=ap-southeast-2

AWS_CLI := docker run -v $(PWD):/mnt -it --rm --network cv_default \
	$(AWS_ENV) \
	amazon/aws-cli:latest --endpoint-url=http://localstack:4566

DOCKER_RUN := docker run --rm -it \
	-v $(PROJECT_DIR):/runner/project \
	--network cv_default \
	$(AWS_ENV) \
	$(ANSIBLE_IMAGE)

TG_IMAGE := alpine/terragrunt:tf1.14.6

TG := docker run --rm -it \
	-v $(PWD)/terraform:/workspace \
	-w /workspace \
	--network cv_default \
	$(AWS_ENV) \
	$(TG_IMAGE)

ansible-image:
	cd ansible && \
	docker build -t $(ANSIBLE_IMAGE) .

.PHONY: localstack
localstack:
	docker-compose up -d
	docker network connect cv_default local-control-plane 2>/dev/null || true
	docker network connect cv_default local-worker 2>/dev/null || true

.PHONY: localstack-reset
localstack-reset:
	docker-compose down
	docker-compose rm

.PHONY: ansible-deploy
ansible-deploy: localstack ansible-image
	$(DOCKER_RUN) ansible-playbook /runner/project/$(CF_PLAYBOOK) -i localhost, -c local

.PHONY: verbose
ansible-deploy-verbose: localstack ansible-image
	$(DOCKER_RUN) ansible-playbook /runner/project/$(CF_PLAYBOOK) -i localhost, -c local -vvv

check:
	./scripts/check.sh

up: ansible-deploy

