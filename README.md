# k8s_postgres
Example to create a deploy with k8s using postgres

First create the configMap with the following command:

#the files to create the configMap is in configure-postgres/configmap/

kubectl create configmap postgres-data --from-file=configure-postgres/configmap/

<p><b>Once completed, then deploy the postgres pod</b></p>
kubectl apply -f ./postgres-deployment.yaml
