# Auxillary Tooling

## CloudNativePG (https://cloudnative-pg.io/)

CloudNativePG makes deploying/operating PostgreSQL clusters on Kubernetes much easier. As described in `08-extending-kubernetes`, the project extends the Kubernetes API with custom resources and encodes the logic needed to operate those clusters into an application that run in the cluster.

The examples shown provide both a minimal configuration, as well as a configuration that takes periodic backups of the database and stores them in an object store (Google Cloud Storage and Civo Cloud object storage are shown).

## Trivy Operator (https://aquasecurity.github.io/trivy-operator/latest/)

The Trivy Operator automatically scans every container image that runs in the cluster and produces a report of CVEs an potential security implications of other cluster/application configurations.

It also re-scans each image at a specified interval which helps to catch potential vulnerabilities that were discovered after the image was initially built (if you are running a scan within a Continuous Integration pipeline for example).

## Cert Manager (https://cert-manager.io/)

Cert manager provides tooling for provisioning ands managing TLS certificates to enable encryption for traffic to your cluster and services. It integrates with certificate authorities like Let's encrypt and with Ingress Controllers to automate the process.

I have not implemented it within this repo, but it is common/important enough to mention here and setting it up would be a great exercise to test your Kubernetes knowledge.
