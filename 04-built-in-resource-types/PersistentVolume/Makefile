# https://github.com/rancher/local-path-provisioner

create-cluster-with-extra-mount:
	@echo in order for kind to successfully mount the local storage PVs, we need to specfy an allowed path in the kind config
	kind create cluster --config kind-config

get-storage-class:
	kubectl get storageclass standard -o yaml

show-provisioner-deployment:
	kubectl get -n local-path-storage deployment local-path-provisioner -o yaml | yq

# TODO: would this be more clear using a cloud cluster where we are provisioning new storage?... probably