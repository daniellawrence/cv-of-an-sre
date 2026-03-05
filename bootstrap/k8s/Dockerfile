FROM alpine:3.19

RUN apk add --no-cache \
    curl \
    bash \
    docker-cli

# Install kind
RUN curl -Lo /usr/local/bin/kind \
    https://kind.sigs.k8s.io/dl/v0.22.0/kind-linux-amd64 && \
    chmod +x /usr/local/bin/kind

# Install kubectl
RUN curl -LO https://dl.k8s.io/release/v1.29.0/bin/linux/amd64/kubectl && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

WORKDIR /workspace