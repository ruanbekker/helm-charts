# helm-charts
Helm Charts

## Usage

```
```

## Creating a Helm Chart:

```
> helm create hostname
> helm install --dry-run --debug --set ingress.enabled=true --set ingress.annotations."kubernetes\.io/ingress\.class"=traefik --set nameOverride=blue --set fullnameOverride=blue --set ingress.hosts[0].host=blue.localdns.xyz --set ingress.hosts[0].paths[0]=/ ./hostname
> helm package ./hostname
> helm repo index . --url 'https://raw.githubusercontent.com/ruanbekker/helm-charts/master/'
```

## Resources:

- https://medium.com/containerum/how-to-make-and-share-your-own-helm-package-50ae40f6c221
- https://docs.bitnami.com/kubernetes/how-to/create-your-first-helm-chart/
