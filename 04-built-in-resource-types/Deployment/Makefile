apply-minimal:
	kubectl apply -f Deployment.nginx-minimal.yaml

port-forward-minimal:
	kubectl port-forward deployment/nginx-minimal 8080:80

delete-minimal:
	kubectl delete -f Deployment.nginx-minimal.yaml

apply-better:
	kubectl apply -f Deployment.nginx-better.yaml

port-forward-better:
	kubectl port-forward -n non-default deployment/nginx-better 8080:8080

delete-better:
	kubectl delete -f Deployment.nginx-better.yaml