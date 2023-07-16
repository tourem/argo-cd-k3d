kubectl create namespace argocd

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

sleep 10

kubectl get pods -n argocd


# get password argocd server
kubectl -n argocd patch secret argocd-secret -p '{"stringData":  {"admin.password": "$2a$12$FD4i7SF33yV8fMrmeKzmruWfpiovTjwJWjKbxmSDsjQ.dEtn.LrEW", "admin.passwordMtime": "'$(date +%FT%T%Z)'" }}'

# port-forward for localhost
kubectl port-forward -n argocd svc/argocd-server 8080:443

# start local gitlab
docker run --detach \
    --publish 4433:443 --publish 8089:80 --publish 2222:22 \
    --name gitlab \
    --restart always \
    --volume /Users/mtoure/dev/argo-cd/gitlab/config:/etc/gitlab \
    --volume /Users/mtoure/dev/argo-cd/gitlab/logs:/var/log/gitlab \
    --volume /Users/mtoure/dev/argo-cd/gitlab/data:/var/opt/gitlab \
    gitlab/gitlab-ce:latest


# get password gitlab
docker exec -it gitlab grep 'Password:' /etc/gitlab/initial_root_password

# create access token to post helm package 
helm-repos-token: glpat-s7wzFhDzJZNKTDcDMSxz
values-repo-token: glpat-GFtT8JyDGosyob3GFGx2

kubectl port-forward svc/myapp-app-guestbook 9090:80

# create helm package for 0.1.0 version
cd charts-helm/
helm package app-0.1.0

# post helm package
curl --request POST \
     --form 'chart=@app-web-0.1.1.tgz' \
     --user root:glpat-s7wzFhDzJZNKTDcDMSxz \
     http://localhost:8089/api/v4/projects/2/packages/helm/api/stable/charts




- Project sync windows (SyncWindow) in ArgoCD:  programmation de synch (window) est configuré au niveau du project
- En cas d'erreur, le log du deploy est accessible.

argocd url : https://localhost:8081/
gitlab: http://localhost:8089/l

