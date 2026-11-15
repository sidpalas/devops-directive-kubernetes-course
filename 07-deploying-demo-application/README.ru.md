# Развёртывание демо-приложения

> 🌐 [English](README.md) | Русский

В этом разделе определены Kubernetes-манифесты для развёртывания:

- Сервисы, определённые в `06-demo-application`
- Postgresql (через [helm-чарт](https://github.com/bitnami/charts/tree/main/bitnami/postgresql)
- Traefik ingress controller (и конфигурация для маршрутизации трафика к приложению)

## Структура

Ниже показана структура этой директории:

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

## Состав

Helm используется для установки:

1. `Postgresql`
2. `Traefik` (ingress controller)

Фактически каждый сервис разбивается на:

1. `Deployment`: содержит приложение
2. `Secret`: содержит учётные данные базы данных
3. `Service`: внутренний балансировщик нагрузки, распределяющий трафик между Pod'ами Deployment'а.
4. `IngressRoute`: настраивает Ingress controller для маршрутизации трафика к нужному сервису

Миграция базы данных оформлена как Kubernetes `Job`.

## Задачи

Корневой `Taskfile` предоставляет все необходимые команды для развёртывания приложения:

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
