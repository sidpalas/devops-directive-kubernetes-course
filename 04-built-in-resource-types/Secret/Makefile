create-dockerconfigjson:
	kubectl create secret docker-registry dockerconfigjson \    
		--docker-email=foo@bar.com \
		--docker-username=username \
		--docker-password=password \
		--docker-server=docker.io

base64-encode:
	@echo "🚨 Be careful using 'echo' here since it includes a newline by default"
	printf "bar" | base64

get-value:
	kubectl get secret base64-data -o yaml | yq '.data.foo' | base64 -d