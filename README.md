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
> helm install --name blue ruanbekker/hostname
```

Test:

```
> curl -i http://blue.localdns.xyz
Hostname: blue-hostname-cb596d4df-jh7xs
```

Overrides with cli:

```
> helm install --name green \
  --set nameOverride=green \
  --set replicaCount=3 \
  --set ingress.hosts[0].host=green \
  --set ingress.hosts[0].domain=example.com \
  --set ingress.hosts[0].paths[0]=/ \
  ruanbekker/hostname

> curl -H "Host: green.example.com" http://localhost
Hostname: green-5879d88869-tbtf8
```

Overrides with file:

```
> helm install --name yellow --values ./hostname/example/localhost.yml ./hostname

> curl -H "Host: yellow.example.com" http://localhost
Hostname: yellow-85c9c65875-lc976
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

## Custom Domains

You can make use of GitHub's page hosting for custom domains, like this repository hosts `https://charts.ruan.dev` and you can do that by heading to settings, then pages:

<img width="811" alt="image" src="https://user-images.githubusercontent.com/567298/195151030-f2f099e8-e733-4b37-ac12-7c1bf7661c9c.png">

Enable pages and set the root to `/` (depends on your setup), and under custom domains you can set your domain, but before you do you need to setup a CNAME record to `<your-github-username>.github.io`.

Then in my case we can use it as, the following, add the repo:

```bash
helm repo add ruanbekker https://charts.ruan.dev
"ruanbekker" has been added to your repositories
```

Then search the repo for charts:

```bash
helm search repo ruanbekker
NAME               	CHART VERSION	APP VERSION	DESCRIPTION
ruanbekker/hostname	0.1.0        	1.0        	A Helm chart for Kubernetes
```

And we can show the chart values:

```bash
helm show values ruanbekker/hostname

replicaCount: 1

image:
  repository: ruanbekker/hostname
  tag: latest
  pullPolicy: IfNotPresent

imagePullSecrets: []
nameOverride: ""
fullnameOverride: ""

service:
  type: ClusterIP
  port: 8000

ingress:
  enabled: true
  annotations:
    kubernetes.io/ingress.class: traefik
  hosts:
    - host: {}
      domain: "localdns.xyz"
      paths: [/]

resources: {}
nodeSelector: {}
tolerations: []
affinity: {}
```

## Resources:

- https://medium.com/containerum/how-to-make-and-share-your-own-helm-package-50ae40f6c221
- https://docs.bitnami.com/kubernetes/how-to/create-your-first-helm-chart/
