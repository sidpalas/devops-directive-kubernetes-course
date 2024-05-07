apply-minimal:
	kubectl apply -f ReplicaSet.nginx-minimal.yaml

port-forward-minimal:
	kubectl port-forward replicaset/nginx-minimal 8080:80

delete-minimal:
	kubectl delete -f ReplicaSet.nginx-minimal.yaml

apply-better:
	kubectl apply -f ReplicaSet.nginx-better.yaml

port-forward-better:
	kubectl port-forward -n non-default replicaset/nginx-better 8080:8080

delete-better:
	kubectl delete -f ReplicaSet.nginx-better.yaml