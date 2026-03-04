PROJECT_DIR := $(PWD)
ANSIBLE_IMAGE := local-ansible-runner-aws:latest
CF_PLAYBOOK := ansible/playbook.cloudformation.yaml

AWS_ENV := \
	-e AWS_ACCESS_KEY_ID=test \
	-e AWS_SECRET_ACCESS_KEY=test \
	-e AWS_DEFAULT_REGION=us-east-1

AWS_CLI := docker run -v $(PWD):/mnt -it --rm --network cv_default \
	$(AWS_ENV) \
	amazon/aws-cli:latest --endpoint-url=http://localstack:4566

DOCKER_RUN := docker run --rm -it \
	-v $(PROJECT_DIR):/runner/project \
	--network cv_default \
	$(AWS_ENV) \
	$(ANSIBLE_IMAGE)

ansible-image:
	cd ansible && \
	docker build -t $(ANSIBLE_IMAGE) .

localstack-up:
	docker-compose up -d

localstack-reset:
	docker-compose down
	docker-compose rm

.PHONY: ansible-deploy
ansible-deploy: localstack-up ansible-image
	$(DOCKER_RUN) ansible-playbook /runner/project/$(CF_PLAYBOOK) -i localhost, -c local

.PHONY: verbose
ansible-deploy-verbose: localstack-up ansible-image
	$(DOCKER_RUN) ansible-playbook /runner/project/$(CF_PLAYBOOK) -i localhost, -c local -vvv

check: localstack-up
	docker images | grep $(ANSIBLE_IMAGE)
	$(AWS_CLI) cloudformation list-stacks
	$(AWS_CLI) s3 ls
	