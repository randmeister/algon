# Algon
 
Stable channel Algorand node helm chart.

## Features

- Fast Catchup https://developer.algorand.org/docs/run-a-node/setup/install/#sync-node-network-using-fast-catchup
- Node config.json management
- ${ALOGRAND_DATA} persistence with k8s persistent volumes https://kubernetes.io/docs/concepts/storage/persistent-volumes/

## Prerequisites

- Kubernetes cluster accessible https://birthday.play-with-docker.com/kubernetes-docker-desktop/
- kubectl https://kubernetes.io/docs/tasks/tools/install-kubectl/
- https://helm.sh/docs/intro/install/

## Run 

```sh
helm repo add algon https://randmeister.github.io/algon
helm repo update
helm upgrade --install algon algon/algon
```
