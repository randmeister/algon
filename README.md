# algon

![GitHub Workflow Status](https://img.shields.io/github/workflow/status/randmeister/algon/release)

Algorand node stable channel helm chart compatible with testnet and mainnet. The motivitation to integrate the Algorand node into the k8s stack is to leverage DevOps tooling such as Grafana and Loki.

## Features

- Fast catchup https://developer.algorand.org/docs/run-a-node/setup/install/#sync-node-network-using-fast-catchup
- Node config.json management
- ${ALGORAND_DATA} persistence with k8s persistent volumes https://kubernetes.io/docs/concepts/storage/persistent-volumes/

### Roadmap

- Grafana dashboards
- Ingress with TLS
- Docker image is updated nightly and algod inside container is immutable
- Docker image tagging with Algorand node version
- Separate processes into containers with shared data volume (algod, node.log tailer, carpenter, goal node status, catchup) to allow feature-flagging
- kmd chart for management of participation keys

## Prerequisites

- Kubernetes cluster accessible https://birthday.play-with-docker.com/kubernetes-docker-desktop/
- kubectl https://kubernetes.io/docs/tasks/tools/install-kubectl/
- helm https://helm.sh/docs/intro/install/

## Run 

```sh
helm repo add algon https://randmeister.github.io/algon
helm repo update
helm upgrade --install algon algon/algon
```

### Helmfile

Helmfile is a tool to manage helm charts declaratively https://github.com/roboll/helmfile. Check out [example directory](./example) for full documentation.

```yaml
helmDefaults:
  verify: false
  wait: true
  historyMax: 3
  createNamespace: true
repositories:
  - name: algon
    url: https://randmeister.github.io/algon

releases:
  - name: algon
    namespace: algon
    chart: algon/algon
    values:
      - storage:
          size: 5Gi
```

## Docker Image

Algon docker imager hoster on docker hub

https://hub.docker.com/repository/docker/randmeister/algon
