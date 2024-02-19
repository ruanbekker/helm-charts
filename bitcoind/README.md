# bitcoind-chart

## Secret

To create a secret for bitcoind to use as a rpc password:

```bash
kubectl create secret generic bitcoind-secrets \
  --from-literal=password="bitcoinrpcpassword" \
  --namespace blockchain
```

## Usage

Option 1: Deploy in AWS environment, set the username and reference a existing secret as password

```bash
helm upgrade --install bitcoind ruanbekker/bitcoind \
  --namespace blockchain --create-namespace \
  --set configuration.rpcuser=user \
  --set configuration.passwordSecret=bitcoind-secrets 
```

Option 2: Deploy in a Non-AWS environment, set a username and reference a existing secret as password

```bash
helm upgrade --install bitcoind ruanbekker/bitcoind \
  --namespace blockchain --create-namespace \
  --set persistence.storageClass=longhorn \
  --set configuration.rpcuser=user \
  --set configuration.passwordSecret=bitcoind-secrets 
```

Option 3: Deploy in a AWS environment, generate a username and password for me

```bash
helm upgrade --install bitcoind ruanbekker/bitcoind \
  --namespace blockchain --create-namespace 
```

The password will be in the container environment
