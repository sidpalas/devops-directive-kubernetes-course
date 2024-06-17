# Cluster and Node Upgrades

It is important to keep your control plane and worker nodes updated both to:

1. Patch security vulnerabilities
2. Use new features as they are released

Depending on which (if any) cloud provider you are using and whether you are using managed cluster or not, the exact procedure for performing such an upgrade will vary. Some providers (including GKE) handle most of this transparently, while others (such as AWS EKS) require a more hands on approach.

With GKE, you can generally just pick a release channel (`stable`, `regular`, or `rapid`) and allow the system to handle upgrades for you. That being said, there are times when you want to upgrade immediately for some reason and this section provide a process to do so.

## Process

The `Taskfile.yaml` contains steps to upgrade a cluster and its node-pool(s). The general approach is:

1. `Check for usage of deprecated APIs`: If you are using deprecated APIs that will be removed by a Kubernetes upgrade, you need to address those before upgrading
2. `Update the control plane`: The control plane version can be ahead of the worker nodes, but cannot be behind so it is updated first.
3. `Create a new nodepool`: Rather than update nodes in place, it can be safer to create a new node group. This way the new nodes will be fully operational before you shift workloads to them and if something goes wrong you can shift the workloads back to the old nodes.
4. `Drain and cordon the old nodes`: You can use kubernetes scheduling capabilities to shift all of the pods onto the newly provisioned nodes.
5. `Delete the old nodepool`: Once all of the workloads are successfully running on the new nodes, you can safely delete the old nodes.
