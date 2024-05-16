check-helm-version:
	helm version

### Helm repo

add-repo:
	helm repo add bitnami https://charts.bitnami.com/bitnami
	
search-repo:
	helm search repo bitnami/mysql --versions

### OCI registry 

login-oci-registry:
	@echo "Use dockerhub username and password"
	helm registry login registry-1.docker.io

list-registry:
	oras repo tags registry-1.docker.io/bitnamicharts/mysql

MYSQL_VERSION_1=10.2.1
MYSQL_VERSION_2=10.2.2
MYSQL_NAMESPACE=mysql

pull:
	helm pull bitnami/mysql --version=${MYSQL_VERSION_2}

untar:
	tar -xzf mysql-${MYSQL_VERSION_2}.tgz

show-values:
	helm show values bitnami/mysql --version=${MYSQL_VERSION_2}


install:
	helm install -n ${MYSQL_NAMESPACE} mysql bitnami/mysql \
		--version=${MYSQL_VERSION_1} \
		--create-namespace \
		--values=values.yaml

upgrade:
	helm upgrade --install -n ${MYSQL_NAMESPACE} mysql bitnami/mysql \
		--version=${MYSQL_VERSION_2} \
		--create-namespace \
		--values=values.yaml

rollback:
	helm rollback -n ${MYSQL_NAMESPACE} mysql

list:
	helm list -n ${MYSQL_NAMESPACE}

get-values:
	helm get values -n mysql mysql

get-manifests:
	helm get manifest -n mysql mysql

uninstall:
	helm uninstall -n ${MYSQL_NAMESPACE} mysql

