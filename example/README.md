# algon helmfile example
 
## Run algon with Loki and Grafana

```
helmfile -f helmfile.yml apply
```

## Portforward Grafana

```
kubectl get secret --namespace loki loki-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
kubectl port-forward --namespace loki service/loki-grafana 3000:80
```

Open Grafana http://localhost:3000 and use Loki's log view to run LogQL queries https://grafana.com/docs/loki/latest/logql/

## Delete chart

```
helmfile -f helmfile.yml delete
```
