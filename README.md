# Running guide

## Create Secret
- Connect to cloud shell on the GKE
- run command kubectl create secret generic pgpassword --from-literal PGPASSWORD=@PASSWORD@

## Installing Helm / tiller:
- Connect to cloud shell
- Run the following commands:

```
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get > get_helm.sh
chmod 700 get_helm.sh
./get_helm.sh
kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
helm init --service-account tiller --upgrade
```

- install nginx-ingress (https://kubernetes.github.io/ingress-nginx/deploy/#using-helm):

```helm install stable/nginx-ingress --name my-nginx --set rbac.create=true```
