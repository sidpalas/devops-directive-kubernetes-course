# Deploying the Demo Application

This section defines kubernetes manifests to deploy:

- The services defined in `06-demo-application`
- Postgresql (via [a helm chart](https://github.com/bitnami/charts/tree/main/bitnami/postgresql)
- Traefik ingress controller (and config to route traffic to the application)

## Layout

The following shows the layout of this directory:

```
├── api-golang
│   ├── Deployment.yaml
│   ├── IngressRoute.yaml
│   ├── Secret.yml
│   └── Service.yaml
├── api-node
│   ├── Deployment.yaml
│   ├── IngressRoute.yaml
│   ├── Secret.yaml
│   └── Service.yaml
├── client-react
│   ├── ConfigMap.yaml
│   ├── Deployment.yaml
│   ├── IngressRoute.yaml
│   └── Service.yaml
├── common
│   ├── Middleware.yaml
│   ├── Namespace.yaml
├── load-generator-python
│   ├── ConfigMap.yaml
│   └── Deployment.yaml
└── postgresql
    ├── Job.db-migrator.yaml
    └── Secret.db-password.yaml
```

## Breakdown

Helm is used to install:

1. `Postgresql`
2. `Traefik` (ingress controller)

Each service effectively gets broken down into:

1. `Deployment`: Contains the application
2. `Secret`: Contains database credentials
3. `Service`: Internal load balancer routing traffic to the deployment pods.
4. `IngressRoute`: Configures Ingress controller to route traffic to the proper service

The database migration is structured as a Kubernetes `Job`.

## Tasks

The top level `Taskfile` provides all necessary commands to deploy the application:

```
❯ task --list-all
task: Available tasks for this project:
* apply-all:
* api-golang:apply:                                     Apply kubernetes resource manifests for api-golang application
* api-node:apply:                                       Apply kubernetes resource manifests for api-node application
* client-react:apply:                                   Apply kubernetes resource manifests for client-react application
* common:apply-namespace:                               Apply Kubernetes Namespace
* common:apply-traefik-middleware:                      Deploy Traefik middleware
* common:deploy-traefik:                                Deploy Traefik using Helm
* load-generator-python:apply:                          Apply kubernetes resource manifests for load-generator-python application
* load-generator-python:create-image-pull-secret:       Create image pull secret to pull from private registry
* postgresql:apply-initial-db-migration-job:            Run init.sql script against the DB
* postgresql:install-postgres:                          Deploy PostgreSQL using Helm
```
