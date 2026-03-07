# cv

## -

Install the required tools in the bin directory

```sh
make install-all
```

## 0

setup the base k8s cluster

```sh
scripts/0_build_k8.sh
```

## 1

setup argo for a CD solution for supporting infra

```sh
scripts/1_argo_init.sh
```

## 2

deploy traefik as a better solution then port-fowarding

```sh
scripts/2_traefik.sh
```

- [traefik.localhost](http://traefik.localhost:8080/)
- [argocd.localhost](hthttp://argocd.localhost:8080/)

## 3

deploy gitea as a git-server, pre-work for CI

```sh
scripts/3_gitea.sh
```

- [git.localhost](hthttp://git.localhost:8080/)