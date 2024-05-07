apply-minimal:
	kubectl apply -f Job.echo-minimal.yaml

port-forward-minimal:
	kubectl port-forward deployment/echo-minimal 8080:80

delete-minimal:
	kubectl delete -f Job.echo-minimal.yaml

apply-better:
	kubectl apply -f Job.echo-better.yaml

port-forward-better:
	kubectl port-forward -n non-default deployment/echo-better 8080:8080

delete-better:
	kubectl delete -f Job.echo-better.yaml