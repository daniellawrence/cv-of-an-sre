FROM python:3.14-slim

RUN pip install --upgrade pip && \
    pip install ansible boto3 botocore

WORKDIR /workspace

# Install AWS collection + boto deps
ADD requirements.yml /workspace/requirements.yml
RUN ansible-galaxy collection install -r requirements.yml