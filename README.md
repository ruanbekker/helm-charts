# helm-charts
Helm Charts

## Usage

Example using the `hostname` chart with k3d:

```
> k3d create --name "test" --publish "80:80" --workers 0
> export KUBECONFIG="$(k3d get-kubeconfig --name='test')"
> kubectl create serviceaccount tiller --namespace kube-system
> kubectl create clusterrolebinding tiller-role-binding --clusterrole cluster-admin --serviceaccount=kube-system:tiller
> helm init --service-account tiller
> kubectl rollout status -n kube-system deployment/tiller-deploy
```

Adding the repo and installing a chart:

```
> helm repo add ruanbekker 'https://raw.githubusercontent.com/ruanbekker/helm-charts/master/'
> helm repo update
> helm install \
  --set ingress.enabled=true \
  --set ingress.annotations."kubernetes\.io/ingress\.class"=traefik \
  --set nameOverride=test \
  --set fullnameOverride=test \
  --set ingress.hosts[0].host=test.localdns.xyz \
  --set ingress.hosts[0].paths[0]=/ 
  ruanbekker/hostname
```

Test:

```
> curl -i http://test.localdns.xyz
HTTP/1.1 200 OK
Content-Length: 32
Content-Type: text/plain; charset=utf-8
Date: Thu, 20 Feb 2020 12:46:12 GMT
Vary: Accept-Encoding

Hostname: test-75fd7b6786-2zl65
```

## Creating a Helm Chart:

```
> helm create hostname
> helm install --dry-run --debug --set ingress.enabled=true --set ingress.annotations."kubernetes\.io/ingress\.class"=traefik --set nameOverride=blue --set fullnameOverride=blue --set ingress.hosts[0].host=blue.localdns.xyz --set ingress.hosts[0].paths[0]=/ ./hostname
> helm package ./hostname
> helm repo index . --url 'https://raw.githubusercontent.com/ruanbekker/helm-charts/master/'
> helm repo add reponame 'https://raw.githubusercontent.com/ruanbekker/helm-charts/master/'
> helm repo update 

> helm repo list
NAME  	    URL
reponame	https://raw.githubusercontent.com/ruanbekker/helm-charts/master/

> helm install --dry-run --debug reponame/hostname

> helm search foobar/
NAME               	CHART VERSION	APP VERSION	DESCRIPTION
reponame/hostname	0.1.0        	1.0        	A Helm chart for Kubernetes
```

## Resources:

- https://medium.com/containerum/how-to-make-and-share-your-own-helm-package-50ae40f6c221
- https://docs.bitnami.com/kubernetes/how-to/create-your-first-helm-chart/
