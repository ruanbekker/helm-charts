# Common Helm Chart

This Helm chart is used for deploying a simple application with customizable options for replica count, image settings, deployment strategy, probes, and more.

## Prerequisites

- Kubernetes 1.16+
- Helm 3+

## Installing the Chart

Add the helm repository:

```bash
helm repo add ruanbekker https://charts.ruan.dev
```

To install the chart with the release name `my-release`:

```sh
helm install my-release ruanbekker/common
```

## Uninstalling the Chart

To uninstall the `my-release` deployment:

```sh
helm uninstall my-release
```

## Configuration

The following table lists the configurable parameters of the Helm chart and their default values.

| Parameter                               | Description                                                                 | Default                             |
|-----------------------------------------|-----------------------------------------------------------------------------|-------------------------------------|
| `replicaCount`                          | Number of replicas                                                          | `1`                                 |
| `image.repository`                      | Image repository                                                            | `ruanbekker/hostname`               |
| `image.pullPolicy`                      | Image pull policy                                                           | `IfNotPresent`                      |
| `image.tag`                             | Image tag                                                                   | `""`                                |
| `imagePullSecrets`                      | Image pull secrets                                                          | `[]`                                |
| `nameOverride`                          | Override the name of the chart                                              | `""`                                |
| `fullnameOverride`                      | Override the full name of the chart                                         | `""`                                |
| `deploymentStrategy`                    | Deployment strategy                                                         | `{type: RollingUpdate, maxUnavailable: 1, maxSurge: 1}` |
| `livenessProbe`                         | Liveness probe settings                                                     | `{httpGet: {path: /, port: http}, initialDelaySeconds: 30, periodSeconds: 10, failureThreshold: 3}` |
| `readinessProbe`                        | Readiness probe settings                                                    | `{httpGet: {path: /, port: http}, initialDelaySeconds: 10, periodSeconds: 5, failureThreshold: 3}` |
| `serviceAccount.create`                 | Create service account                                                      | `true`                              |
| `serviceAccount.automount`              | Automount service account tokens                                            | `true`                              |
| `serviceAccount.annotations`            | Annotations for service account                                             | `{}`                                |
| `serviceAccount.name`                   | Service account name                                                        | `""`                                |
| `podAnnotations`                        | Annotations for pods                                                        | `{}`                                |
| `podLabels`                             | Labels for pods                                                             | `{}`                                |
| `podSecurityContext`                    | Pod security context                                                        | `{}`                                |
| `securityContext`                       | Security context                                                            | `{}`                                |
| `kind`                                  | Kind of deployment (Deployment or StatefulSet)                              | `Deployment`                        |
| `service.type`                          | Service type                                                                | `ClusterIP`                         |
| `service.port`                          | Service port                                                                | `80`                                |
| `ingress.enabled`                       | Enable ingress                                                              | `false`                             |
| `ingress.className`                     | Ingress class name                                                          | `""`                                |
| `ingress.annotations`                   | Annotations for ingress                                                     | `{}`                                |
| `ingress.hosts`                         | Hosts for ingress                                                           | `[chart-example.local]`             |
| `ingress.tls`                           | TLS configuration for ingress                                               | `[]`                                |
| `resources`                             | Resource requests and limits                                                | `{}`                                |
| `autoscaling.enabled`                   | Enable autoscaling                                                          | `false`                             |
| `autoscaling.minReplicas`               | Minimum number of replicas                                                  | `1`                                 |
| `autoscaling.maxReplicas`               | Maximum number of replicas                                                  | `100`                               |
| `autoscaling.targetCPUUtilizationPercentage` | Target CPU utilization percentage                                       | `80`                                |
| `env`                                   | Environment variables                                                       | `[]`                                |
| `secrets`                               | Secrets as environment variables                                            | `[]`                                |
| `volumes`                               | Additional volumes                                                          | `[]`                                |
| `volumeMounts`                          | Additional volume mounts                                                    | `[]`                                |
| `persistence.enabled`                   | Enable persistence                                                          | `false`                             |
| `persistence.storageClass`              | Storage class for persistence                                               | `local-path`                        |
| `persistence.accessMode`                | Access mode for persistence                                                 | `ReadWriteOnce`                     |
| `persistence.size`                      | Size of persistent volume                                                   | `1Gi`                               |
| `persistence.mountPath`                 | Mount path for persistence                                                  | `/data`                             |
| `persistence.name`                      | Name of the persistent volume                                               | `data`                              |
| `monitoring.enabled`                    | Enable Prometheus ServiceMonitor                                            | `false`                             |
| `monitoring.labels`                     | Labels for ServiceMonitor                                                   | `{release: kube-prometheus-stack}`  |
| `monitoring.interval`                   | Scrape interval for Prometheus                                              | `30s`                               |
| `monitoring.scrapeTimeout`              | Scrape timeout for Prometheus                                               | `10s`                               |
| `monitoring.path`                       | Metrics path for Prometheus                                                 | `/metrics`                          |
| `nodeSelector`                          | Node selector                                                               | `{}`                                |
| `tolerations`                           | Tolerations                                                                 | `[]`                                |
| `affinity`                              | Affinity settings                                                           | `{}`                                |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example:

```sh
helm install my-release --set replicaCount=2 ruanbekker/common
```

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example:

```sh
helm install my-release -f values.yaml ruanbekker/common
```

## Persistence

If persistence is enabled, a PersistentVolumeClaim will be created and mounted to the specified path. Ensure that the storage class and size are appropriate for your use case.

## Monitoring

Prometheus monitoring can be enabled by setting the `monitoring.enabled` flag to `true`. Customize the monitoring settings as needed.

## Ingress

To enable and configure ingress, set `ingress.enabled` to `true` and configure the `ingress.hosts` and `ingress.tls` settings.

## Autoscaling

Autoscaling can be enabled by setting `autoscaling.enabled` to `true`. Configure the `minReplicas`, `maxReplicas`, and `targetCPUUtilizationPercentage` settings as needed.

