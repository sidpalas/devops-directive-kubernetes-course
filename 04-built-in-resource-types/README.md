# Built-In Resource Types

Kubernetes provides many resource types that cover many application deployment/operational needs.

This sections covers most of these resource types with working examples for each.

## How to use this section

Each directory represents a resource type and has a Taskfile containing all necessary commands.

The tasks are prefixed with numbers to indicate the proper order to run them in.

Each set of examples are deployed into their own namespace. This helps prevent naming conflicts and makes it easier to clean up (because deleting a namesapce deletes the resources within it)

```
task 01-create-namespace

### OTHER TASKS

task 07-delete-namespace
```

## Resource Types

🚨 **Note:** You should follow this ordering (and this is the order they are covered in the video course)

- **Namespace**: Provides a way to divide cluster resources between multiple users.
- **Pod**: The smallest and simplest Kubernetes object. Represents a set of running containers on your cluster.
- **ReplicaSet**: Ensures that a specified number of pod replicas are running at any given time.
- **Deployment**: Manages stateless applications, providing features such as rolling updates and rollbacks.
- **Service**: Defines a logical set of pods and a policy by which to access them.
- **Job**: Creates one or more pods that run to completion.
- **CronJob**: Schedules jobs to run at specified times or intervals.
- **DaemonSet**: Ensures that a copy of a pod runs on all (or some) nodes in the cluster.
- **StatefulSet**: Manages stateful applications, providing guarantees about the ordering and uniqueness of pods.
- **ConfigMap**: Store configuration data that can be consumed by pods.
- **Secret**: Manages sensitive information, such as passwords, OAuth tokens, and ssh keys.
- **Ingress**: Manages external access to the services in a cluster, typically HTTP.
- **GatewayAPI**: Manages traffic routing within the cluster, providing advanced routing capabilities.
- **PersistentVolume and PersistentVolumeClaim**: Manages persistent storage for pods.
- **RBAC (Role-Based Access Control)**: Manages permissions within the cluster.

### Out of Scope Resource Types

- **LimitRange**: Specifies resource constraints for resources within a namespace.
- **NetworkPolicy**: Controls the network traffic flow at the IP address or port level within the Kubernetes cluster.
- **MutatingWebhookConfiguration**: Defines webhooks that can mutate incoming requests to the Kubernetes API server.
- **ValidatingWebhookConfiguration**: Defines webhooks that can validate incoming requests to the Kubernetes API server.
- **HorizontalPodAutoscaler**: Automatically scales the number of pods in a deployment or replica set based on observed CPU utilization or other custom metrics.
- **CustomResourceDefinition**: Allows users to define their own resource types and make the Kubernetes API server handle them (covered in a later section!).
