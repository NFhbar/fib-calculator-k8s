# Fibonacci Calculator K8s

[![Build Status](https://travis-ci.org/NFhbar/fib-calculator-k8s.svg?branch=master)](https://travis-ci.org/NFhbar/fib-calculator-k8s)

Kubernetes version of [Fibonacci Calculator](https://github.com/NFhbar/fib-calculator).

The app's architecture:

![Alt text](docs/k8s.png?raw=true "architecture")

## Local Development
Start `minikube`:
```bash
$ minikube start
```

To apply config files:
```bash
$ kubectl apply -f k8s
```

Ingress services through [ingress-nginx](https://kubernetes.github.io/ingress-nginx/deploy/#prerequisite-generic-deployment-command). 

Uses default backend:

```bash
$ kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/mandatory.yaml
$ kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/provider/cloud-generic.yaml
```

and minikube:
```bash
$ minikube addons enable ingress
```

To get the ip:
```bash
$ minikube ip
```

## Secrets
Postgres password:
```bash
$ kubectl create secret generic pgpassword --from-literal PGPASSWORD=value
```

## Production
App is deployed via Travis CI to Google Cloud, see [deploy.sh](./deploy.sh) and [.travis.yml](./.travis.yml). After setting up your Kubernetes cluster.

To apply secret to cluster in Google Cloud; in Google Cloud cluster shell - only on first deploy:
```bash
$ gcloud config set project PROJECT_ID
$ gcloud config set compute/zone PROJECT_ZONE
$ gcloud container cluster get-credentials PROJECT_NAME
$ kubectl create secret generic pgpassword --from-literal PGPASSWORD=value
```

To use Nginx in Google Cloud using [Helm](https://docs.helm.sh/using_helm/#from-script):

First get Helm; in Google Cloud cluster shell - only on first deploy:
```bash
$ curl https://raw.githubusercontent.com/helm/helm/master/scripts/get > get_helm.sh
$ chmod 700 get_helm.sh
$ ./get_helm.sh
```

Create services accounts and cluster role binding; in Google Cloud cluster shell - only on first deploy:
```bash
$ kubectl create serviceaccount --namespace kube-system tiller
$ kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
```

Initialize Helm; in Google Cloud cluster shell - only on first deploy:
```bash
$ helm init --service-account tiller --upgrade 
```

Install Nginx:
```bash
$ helm install stable/nginx-ingress --name my-nginx --set rbac.create=true
```




## Issues
If `kubectl` times out, restart minikube:
```bash
$ minikube start
```