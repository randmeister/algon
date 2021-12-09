# Loadbalancer

For HA setup of your Algorand node load-balanced config see value file [load-balanced](values.yaml):

```
minikube start --vm=true --memory=4g --nodes=2
```

```
make helm_rebuild_replicas_2
```