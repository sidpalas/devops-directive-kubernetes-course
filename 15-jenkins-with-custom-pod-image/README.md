# Installation and Setup

## Dependencies

### Docker Desktop

Please install Docker Desktop via their instructions (Install Docker Desktop on [Mac](https://docs.docker.com/desktop/install/mac-install/), [Windows](https://docs.docker.com/desktop/install/windows-install/), or [Linux](https://docs.docker.com/desktop/install/linux-install/).)

### Devbox

All other software dependencies for the course are defined in the `devbox.json` and `devbox.lock` files in the root directory.

Please install Devbox according to their instructions: https://www.jetify.com/devbox/docs/installing_devbox/

Once installed you can run:

```
devbox shell
```

from anywhere in the repo and devbox will use Nix package manager to install a copy of all of the required software in an isolated environment.

### Aliases

I suggest creating the following aliases:

```
k=kubectl
t=task
tl='task --list-all'
```

### Autocomplete:

Setting up tab completion for your shell of choice makes life much nicer:

- kubectl: https://kubernetes.io/docs/reference/kubectl/generated/kubectl_completion/
- task: https://taskfile.dev/installation/#setup-completions

## Cluster Set Up

This directory contains configurations and commands for setting up 3 kubernetes clusters. Any of the 3 can be used for most of the examples, with a few exceptions.

### KinD

Runs a kubernetes cluster locally within Docker! Great for testing and development purposes (and doesn't cost any additional money). Nearly all examples in the course can be run within this cluster, with the exception of things demonstrating cloud specific features or exposing services via public DNS.

To start the cluster run:

```
devbox shell # if you haven't already
task kind:up
task docker:build-jenkins-agent
task docker:push-jenkins-agent
task kind:jenkins-install
task kind:jenkins-creds
```
