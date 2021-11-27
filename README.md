# algon

![GitHub Workflow Status](https://img.shields.io/github/workflow/status/randmeister/algon/release)

Algorand node stable channel helm chart compatible with testnet and mainnet.

## Features

- Fast catchup https://developer.algorand.org/docs/run-a-node/setup/install/#sync-node-network-using-fast-catchup
- Node config.json management
- ${ALGORAND_DATA} persistence with k8s persistent volumes https://kubernetes.io/docs/concepts/storage/persistent-volumes/

### Roadmap

- Ingress with TLS
- Docker image is updated nightly and algod inside container is immutable
- Load-balancing several nodes
- Separate processes into containers with shared data volume (algod, node.log tailer, carpenter, goal node status, catchup) to allow feature-flagging
- kmd chart for management of participation keys

## Prerequisites

- Minikube https://minikube.sigs.k8s.io/docs/handbook/
- Minikube ingress https://kubernetes.io/docs/tasks/access-application-cluster/ingress-minikube/
- kubectl https://kubernetes.io/docs/tasks/tools/install-kubectl/
- helm https://helm.sh/docs/intro/install/
- jq https://stedolan.github.io/jq/download/

## Install

```sh
helm repo add algon https://randmeister.github.io/algon
helm repo update
helm upgrade --install algon algon/algon
```

## Usage

### Access node via ingress

Copy URL from minikube
```
minikube service list algon -n algon
```
|-----------|-------|-------------|----------------------------|
| NAMESPACE | NAME  | TARGET PORT |            URL             |
|-----------|-------|-------------|----------------------------|
| algon     | algon | http/8080   | http://192.168.64.12:31902 |
|-----------|-------|-------------|----------------------------|

Make request to node from localhost
```
export ALGON_API_TOKEN=`kubectl get secrets/algon-api-token --template="{{index .data \"algod.token\" | base64decode}}"`
curl http://192.168.64.12:31902/v2/status -H  "X-Algo-API-Token: $ALGON_API_TOKEN" -v | jq .
```

### Access node via minikube tunnel

1. Run `minikube tunnel`

1. In a new terminal run:

```
echo "`kubectl -n algon  get svc algon -o json | jq -r '.status.loadBalancer | .ingress[].ip'` algon.local" | sudo tee /etc/hosts
export ALGON_API_TOKEN=`kubectl get secrets/algon-api-token --template="{{index .data \"algod.token\" | base64decode}}"`
curl http://192.168.64.12:8080/v2/status -H  "X-Algo-API-Token: $ALGON_API_TOKEN" -v | jq .
```

1. The Algorand node is now accessible under **algon.local**.

## Docker Image

The algon docker image is hosted on docker hub: https://hub.docker.com/repository/docker/randmeister/algon
