create-the-wrong-way: 
	@echo "🚨 PLEASE DO NOT DO THIS 🚨"
	kubectl run --image=nginx:1.26.0 created-the-wrong-way

delete-created-the-wrong-way:
	kubectl delete pod created-the-wrong-way

apply-minimal:
	kubectl apply -f Pod.nginx-minimal.yaml

port-forward-minimal:
	kubectl port-forward nginx-minimal 8080:80

delete-minimal:
	kubectl delete -f Pod.nginx-minimal.yaml

apply-better:
	kubectl apply -f Pod.nginx-better.yaml

port-forward-better:
	kubectl port-forward -n non-default nginx-better 8080:8080

delete-better:
	kubectl delete -f Pod.nginx-better.yaml