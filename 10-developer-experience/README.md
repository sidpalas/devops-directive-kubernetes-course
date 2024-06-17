# Developer Experience

## Inner Development Loop

When working with Kubernetes, ideally you have a development environment which can replicate your production environment as closely as possible.

We have shown how to deploy the demo application using `KinD` (and in a fast creating Civo cluster), but until now any change to the application would require a manual image rebuild.

There are a number of tools that can help with this including:

- Tilt (https://tilt.dev/)
- Skaffold (https://skaffold.dev/)
- Telepresence (https://www.telepresence.io/)
- mirrord (https://mirrord.dev/)

Tilt allows for configurating your application such that each service will automatically rebuild/reload within the cluster when changes are made.

I have not optimized the build times with all of the possible options, but these applications are small enough that it is still quite fast!

## Secrets Management

Managing sensitive information like database credentials is often one of the most painful parts of any application deployment. The rest of the configuration lives within version control (e.g. Git), but we cannot safely store these credentials there. There are a variety of ways people approach this problem.

1. `Manually create/update secrets out of band (🤮)`: The first approach people take is to manually create any secrets. This requires no setup, but quickly becomes unmanageable and will eventually lead to pain.

2. `External Secrets Operator` (https://external-secrets.io/latest/): ESO provides a way to mirror secrets fro an external provider (such as Google Cloud Secret Manager OR 1Pass) as Kubernetes secrets. This allows you to keep the sensitive information in a tool built for such a purpose and reference these with non-sensitive configurations which can live alongside your other configuration. This is the approach which is shown here!

3. `Sealed Secrets` (https://sealed-secrets.netlify.app/) and `SOPs` (https://github.com/getsops/sops): These projects enable you to encrypt secrets such that you can safely store the encrypted version in version control and decrypt them within the cluster for use by your applications.

4. `Skip k8s secrets entirely`: Some people prefer to avoid Kubernetes secrets whereever possible and load them directly from an external system such as Vault, AWS Secrets Manager, or Doppler.
