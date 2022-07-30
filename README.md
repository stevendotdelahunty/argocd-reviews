# Sample Code For Review Environments With Argo CD

Environments Based On Pull Requests (PRs): Using Argo CD To Apply GitOps Principles On Reviews


### Deployment
```bash
#!/usr/bin/env bash

echo "Creating argocd namespace"
kubectl create namespace argocd
echo "Installing argocd"
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo "Having a sleep before attempting port forward. Argo can be slow"
sleep 45
echo "starting the port forward"
nohup kubectl port-forward svc/argocd-server -n argocd 8080:443 &

echo "Log in to argocd cli"
argocd login localhost:8080 --username admin --password $(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d) --insecure

argocd repo add git@github.com:stevendotdelahunty/argocd-reviews.git --ssh-private-key-path ~/.ssh/ste_d_prk

kubectl apply -f project.yaml
kubectl apply -f apps.yaml
```

### Useful commands
`kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d ; echo`
