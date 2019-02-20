# Fibonacci Calculator K8s
Kubernetes version of [Fibonacci Calculator](https://github.com/NFhbar/fib-calculator).

The app's architecture:

![Alt text](docs/k8s.png?raw=true "architecture")

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

## Issues
If `kubectl` times out, restart minikube:
```bash
$ minikube start
```