# Change Log

## 20.8.0  ![AppVersion: v2.9.6](https://img.shields.io/static/v1?label=AppVersion&message=v2.9.6&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-12-08

* ✨ update chart to version 20.8.0
* ✨ add support for default entrypoints
* ✨ add support for OpenTelemetry and Traefik v3

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index b77539d..42a27f9 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -107,6 +107,8 @@ ingressClass:
 
 # Enable experimental features
 experimental:
+  v3:
+    enabled: false
   plugins:
     enabled: false
   kubernetesGateway:
@@ -347,7 +349,43 @@ metrics:
 #    # addRoutersLabels: true
 #    ## Enable metrics on services. Default=true
 #    # addServicesLabels: false
-
+#  openTelemetry:
+#    ## Address of the OpenTelemetry Collector to send metrics to.
+#    address: "localhost:4318"
+#    ## Enable metrics on entry points.
+#    addEntryPointsLabels: true
+#    ## Enable metrics on routers.
+#    addRoutersLabels: true
+#    ## Enable metrics on services.
+#    addServicesLabels: true
+#    ## Explicit boundaries for Histogram data points.
+#    explicitBoundaries:
+#      - "0.1"
+#      - "0.3"
+#      - "1.2"
+#      - "5.0"
+#    ## Additional headers sent with metrics by the reporter to the OpenTelemetry Collector.
+#    headers:
+#      foo: bar
+#      test: test
+#    ## Allows reporter to send metrics to the OpenTelemetry Collector without using a secured protocol.
+#    insecure: true
+#    ## Interval at which metrics are sent to the OpenTelemetry Collector.
+#    pushInterval: 10s
+#    ## Allows to override the default URL path used for sending metrics. This option has no effect when using gRPC transport.
+#    path: /foo/v1/traces
+#    ## Defines the TLS configuration used by the reporter to send metrics to the OpenTelemetry Collector.
+#    tls:
+#      ## The path to the certificate authority, it defaults to the system bundle.
+#      ca: path/to/ca.crt
+#      ## The path to the public certificate. When using this option, setting the key option is required.
+#      cert: path/to/foo.cert
+#      ## The path to the private key. When using this option, setting the cert option is required.
+#      key: path/to/key.key
+#      ## If set to true, the TLS connection accepts any certificate presented by the server regardless of the hostnames it covers.
+#      insecureSkipVerify: true
+#    ## This instructs the reporter to send metrics to the OpenTelemetry Collector using gRPC.
+#    grpc: true
 
 ##
 ##  enable optional CRDs for Prometheus Operator
@@ -510,6 +548,8 @@ ports:
     # The port protocol (TCP/UDP)
     protocol: TCP
   web:
+    ## Enable this entrypoint as a default entrypoint. When a service doesn't explicity set an entrypoint it will only use this entrypoint.
+    # asDefault: true
     port: 8000
     # hostPort: 8000
     expose: true
@@ -534,6 +574,8 @@ ports:
     #   trustedIPs: []
     #   insecure: false
   websecure:
+    ## Enable this entrypoint as a default entrypoint. When a service doesn't explicity set an entrypoint it will only use this entrypoint.
+    # asDefault: true
     port: 8443
     # hostPort: 8443
     expose: true
```

## 20.7.0  ![AppVersion: v2.9.6](https://img.shields.io/static/v1?label=AppVersion&message=v2.9.6&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-12-08

* ⬆️  Update default Traefik release to v2.9.6 (#758)
* 🐛 Don't fail when prometheus is disabled (#756)
* :bug: Fix typo on bufferingSize for access logs (#753)
* ✨ support for Gateway annotations
* add keywords [networking], for artifacthub category quering
* :adhesive_bandage: Add quotes for artifacthub changelog parsing (#748)

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 4f2fb2a..b77539d 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -120,6 +120,9 @@ experimental:
     # By default, Gateway would be created to the Namespace you are deploying Traefik to.
     # You may create that Gateway in another namespace, setting its name below:
     # namespace: default
+    # Additional gateway annotations (e.g. for cert-manager.io/issuer)
+    # annotations:
+    #   cert-manager.io/issuer: letsencrypt
 
 # Create an IngressRoute for the dashboard
 ingressRoute:
@@ -219,7 +222,8 @@ logs:
     # By default, the logs use a text format (common), but you can
     # also ask for the json format in the format option
     # format: json
-    # By default, the level is set to ERROR. Alternative logging levels are DEBUG, PANIC, FATAL, ERROR, WARN, and INFO.
+    # By default, the level is set to ERROR.
+    # Alternative logging levels are DEBUG, PANIC, FATAL, ERROR, WARN, and INFO.
     level: ERROR
   access:
     # To enable access logs
```

## 20.6.0  ![AppVersion: v2.9.5](https://img.shields.io/static/v1?label=AppVersion&message=v2.9.5&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-11-30

* 🔍️ Add filePath support on access logs (#747)
* :bug: Add missing scheme in help on Traefik Hub integration (#746)
* :memo: Improve documentation on using PVC with TLS certificates

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 15f1682..4f2fb2a 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -211,10 +211,10 @@ additionalVolumeMounts: []
   # - name: traefik-logs
   #   mountPath: /var/log/traefik
 
-# Logs
-# https://docs.traefik.io/observability/logs/
+## Logs
+## https://docs.traefik.io/observability/logs/
 logs:
-  # Traefik logs concern everything that happens to Traefik itself (startup, configuration, events, shutdown, and so on).
+  ## Traefik logs concern everything that happens to Traefik itself (startup, configuration, events, shutdown, and so on).
   general:
     # By default, the logs use a text format (common), but you can
     # also ask for the json format in the format option
@@ -224,31 +224,32 @@ logs:
   access:
     # To enable access logs
     enabled: false
-    # By default, logs are written using the Common Log Format (CLF).
-    # To write logs in JSON, use json in the format option.
-    # If the given format is unsupported, the default (CLF) is used instead.
+    ## By default, logs are written using the Common Log Format (CLF) on stdout.
+    ## To write logs in JSON, use json in the format option.
+    ## If the given format is unsupported, the default (CLF) is used instead.
     # format: json
-    # To write the logs in an asynchronous fashion, specify a bufferingSize option.
-    # This option represents the number of log lines Traefik will keep in memory before writing
-    # them to the selected output. In some cases, this option can greatly help performances.
+    # filePath: "/var/log/traefik/access.log
+    ## To write the logs in an asynchronous fashion, specify a bufferingSize option.
+    ## This option represents the number of log lines Traefik will keep in memory before writing
+    ## them to the selected output. In some cases, this option can greatly help performances.
     # bufferingSize: 100
-    # Filtering https://docs.traefik.io/observability/access-logs/#filtering
+    ## Filtering https://docs.traefik.io/observability/access-logs/#filtering
     filters: {}
       # statuscodes: "200,300-302"
       # retryattempts: true
       # minduration: 10ms
-    # Fields
-    # https://docs.traefik.io/observability/access-logs/#limiting-the-fieldsincluding-headers
+    ## Fields
+    ## https://docs.traefik.io/observability/access-logs/#limiting-the-fieldsincluding-headers
     fields:
       general:
         defaultmode: keep
         names: {}
-          # Examples:
+          ## Examples:
           # ClientUsername: drop
       headers:
         defaultmode: drop
         names: {}
-          # Examples:
+          ## Examples:
           # User-Agent: redact
           # Authorization: drop
           # Content-Type: keep
@@ -693,10 +694,7 @@ autoscaling:
 
 # Enable persistence using Persistent Volume Claims
 # ref: http://kubernetes.io/docs/user-guide/persistent-volumes/
-# After the pvc has been mounted, add the configs into traefik by using the `additionalArguments` list below, eg:
-# additionalArguments:
-# - "--certificatesresolvers.le.acme.storage=/data/acme.json"
-# It will persist TLS certificates.
+# It can be used to store TLS certificates, see `storage` in certResolvers
 persistence:
   enabled: false
   name: data
@@ -726,7 +724,7 @@ certResolvers: {}
 #     tlsChallenge: true
 #     httpChallenge:
 #       entryPoint: "web"
-#     # match the path to persistence
+#     # It has to match the path with a persistent volume
 #     storage: /data/acme.json
 
 # If hostNetwork is true, runs traefik in the host network namespace
```

## 20.5.3  ![AppVersion: v2.9.5](https://img.shields.io/static/v1?label=AppVersion&message=v2.9.5&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-11-25

* 🐛 Fix template issue with obsolete helm version + add helm version requirement (#743)


## 20.5.2  ![AppVersion: v2.9.5](https://img.shields.io/static/v1?label=AppVersion&message=v2.9.5&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-11-24

* ⬆️Update Traefik to v2.9.5 (#740)


## 20.5.1  ![AppVersion: v2.9.4](https://img.shields.io/static/v1?label=AppVersion&message=v2.9.4&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-11-23

* 🐛 Fix namespaceSelector on ServiceMonitor (#737)


## 20.5.0  ![AppVersion: v2.9.4](https://img.shields.io/static/v1?label=AppVersion&message=v2.9.4&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-11-23

* 🚀 Add complete support on metrics options (#735)
* 🐛 make tests use fixed version

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index e49d02d..15f1682 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -12,7 +12,7 @@ hub:
   ## Enabling Hub will:
   # * enable Traefik Hub integration on Traefik
   # * add `traefikhub-tunl` endpoint
-  # * enable addRoutersLabels on prometheus metrics
+  # * enable Prometheus metrics with addRoutersLabels
   # * enable allowExternalNameServices on KubernetesIngress provider
   # * enable allowCrossNamespace on KubernetesCRD provider
   # * add an internal (ClusterIP) Service, dedicated for Traefik Hub
@@ -254,16 +254,96 @@ logs:
           # Content-Type: keep
 
 metrics:
-  # datadog:
-  #   address: 127.0.0.1:8125
-  # influxdb:
-  #   address: localhost:8089
-  #   protocol: udp
+  ## Prometheus is enabled by default.
+  ## It can be disabled by setting "prometheus: null"
   prometheus:
+    ## Entry point used to expose metrics.
     entryPoint: metrics
-  #  addRoutersLabels: true
-  #  statsd:
-  #    address: localhost:8125
+    ## Enable metrics on entry points. Default=true
+    # addEntryPointsLabels: false
+    ## Enable metrics on routers. Default=false
+    # addRoutersLabels: true
+    ## Enable metrics on services. Default=true
+    # addServicesLabels: false
+    ## Buckets for latency metrics. Default="0.1,0.3,1.2,5.0"
+    # buckets: "0.5,1.0,2.5"
+    ## When manualRouting is true, it disables the default internal router in
+    ## order to allow creating a custom router for prometheus@internal service.
+    # manualRouting: true
+#  datadog:
+#    ## Address instructs exporter to send metrics to datadog-agent at this address.
+#    address: "127.0.0.1:8125"
+#    ## The interval used by the exporter to push metrics to datadog-agent. Default=10s
+#    # pushInterval: 30s
+#    ## The prefix to use for metrics collection. Default="traefik"
+#    # prefix: traefik
+#    ## Enable metrics on entry points. Default=true
+#    # addEntryPointsLabels: false
+#    ## Enable metrics on routers. Default=false
+#    # addRoutersLabels: true
+#    ## Enable metrics on services. Default=true
+#    # addServicesLabels: false
+#  influxdb:
+#    ## Address instructs exporter to send metrics to influxdb at this address.
+#    address: localhost:8089
+#    ## InfluxDB's address protocol (udp or http). Default="udp"
+#    protocol: udp
+#    ## InfluxDB database used when protocol is http. Default=""
+#    # database: ""
+#    ## InfluxDB retention policy used when protocol is http. Default=""
+#    # retentionPolicy: ""
+#    ## InfluxDB username (only with http). Default=""
+#    # username: ""
+#    ## InfluxDB password (only with http). Default=""
+#    # password: ""
+#    ## The interval used by the exporter to push metrics to influxdb. Default=10s
+#    # pushInterval: 30s
+#    ## Additional labels (influxdb tags) on all metrics.
+#    # additionalLabels:
+#    #   env: production
+#    #   foo: bar
+#    ## Enable metrics on entry points. Default=true
+#    # addEntryPointsLabels: false
+#    ## Enable metrics on routers. Default=false
+#    # addRoutersLabels: true
+#    ## Enable metrics on services. Default=true
+#    # addServicesLabels: false
+#  influxdb2:
+#    ## Address instructs exporter to send metrics to influxdb v2 at this address.
+#    address: localhost:8086
+#    ## Token with which to connect to InfluxDB v2.
+#    token: xxx
+#    ## Organisation where metrics will be stored.
+#    org: ""
+#    ## Bucket where metrics will be stored.
+#    bucket: ""
+#    ## The interval used by the exporter to push metrics to influxdb. Default=10s
+#    # pushInterval: 30s
+#    ## Additional labels (influxdb tags) on all metrics.
+#    # additionalLabels:
+#    #   env: production
+#    #   foo: bar
+#    ## Enable metrics on entry points. Default=true
+#    # addEntryPointsLabels: false
+#    ## Enable metrics on routers. Default=false
+#    # addRoutersLabels: true
+#    ## Enable metrics on services. Default=true
+#    # addServicesLabels: false
+#  statsd:
+#    ## Address instructs exporter to send metrics to statsd at this address.
+#    address: localhost:8125
+#    ## The interval used by the exporter to push metrics to influxdb. Default=10s
+#    # pushInterval: 30s
+#    ## The prefix to use for metrics collection. Default="traefik"
+#    # prefix: traefik
+#    ## Enable metrics on entry points. Default=true
+#    # addEntryPointsLabels: false
+#    ## Enable metrics on routers. Default=false
+#    # addRoutersLabels: true
+#    ## Enable metrics on services. Default=true
+#    # addServicesLabels: false
+
+
 ##
 ##  enable optional CRDs for Prometheus Operator
 ##
```

## 20.4.1  ![AppVersion: v2.9.4](https://img.shields.io/static/v1?label=AppVersion&message=v2.9.4&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-11-21

* 🐛 fix namespace references to support namespaceOverride


## 20.4.0  ![AppVersion: v2.9.4](https://img.shields.io/static/v1?label=AppVersion&message=v2.9.4&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-11-21

* Add (optional) dedicated metrics service (#727)

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index ca15f6a..e49d02d 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -267,6 +267,12 @@ metrics:
 ##
 ##  enable optional CRDs for Prometheus Operator
 ##
+  ## Create a dedicated metrics service for use with ServiceMonitor
+  ## When hub.enabled is set to true, it's not needed: it will use hub service.
+  #  service:
+  #    enabled: false
+  #    labels: {}
+  #    annotations: {}
   #  serviceMonitor:
   #    metricRelabelings: []
   #      - sourceLabels: [__name__]
```

## 20.3.1  ![AppVersion: v2.9.4](https://img.shields.io/static/v1?label=AppVersion&message=v2.9.4&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-11-21

* 🐛 Fix namespace override which was missing on `ServiceAccount` (#731)


## 20.3.0  ![AppVersion: v2.9.4](https://img.shields.io/static/v1?label=AppVersion&message=v2.9.4&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-11-17

* Add overwrite option for instance label value (#725)

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index c7f84a7..ca15f6a 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -731,3 +731,6 @@ extraObjects: []
 # This will override the default Release Namespace for Helm.
 # It will not affect optional CRDs such as `ServiceMonitor` and `PrometheusRules`
 # namespaceOverride: traefik
+#
+## This will override the default app.kubernetes.io/instance label for all Objects.
+# instanceLabelOverride: traefik
```

## 20.2.1  ![AppVersion: v2.9.4](https://img.shields.io/static/v1?label=AppVersion&message=v2.9.4&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-11-17

* 🙈 do not namespace ingress class (#723)
* ✨ copy LICENSE and README.md on release


## 20.2.0  ![AppVersion: v2.9.4](https://img.shields.io/static/v1?label=AppVersion&message=v2.9.4&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-11-15

* ✨ add support for namespace overrides (#718)
* Document recent changes in the README (#717)

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 97a1b71..c7f84a7 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -725,5 +725,9 @@ podSecurityContext:
 # Extra objects to deploy (value evaluated as a template)
 #
 # In some cases, it can avoid the need for additional, extended or adhoc deployments.
-# See #595 for more details and traefik/tests/extra.yaml for example.
+# See #595 for more details and traefik/tests/values/extra.yaml for example.
 extraObjects: []
+
+# This will override the default Release Namespace for Helm.
+# It will not affect optional CRDs such as `ServiceMonitor` and `PrometheusRules`
+# namespaceOverride: traefik
```

## 20.1.1  ![AppVersion: v2.9.4](https://img.shields.io/static/v1?label=AppVersion&message=v2.9.4&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-11-10

* fix: use consistent appVersion with Traefik Proxy


## 20.1.0  ![AppVersion: 2.9.4](https://img.shields.io/static/v1?label=AppVersion&message=2.9.4&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-11-09

* 🔧 Adds more settings for dashboard ingressRoute (#710)
* 🐛 fix chart releases

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 2ec3736..97a1b71 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -129,10 +129,14 @@ ingressRoute:
     annotations: {}
     # Additional ingressRoute labels (e.g. for filtering IngressRoute by custom labels)
     labels: {}
+    # The router match rule used for the dashboard ingressRoute
+    matchRule: PathPrefix(`/dashboard`) || PathPrefix(`/api`)
     # Specify the allowed entrypoints to use for the dashboard ingress route, (e.g. traefik, web, websecure).
     # By default, it's using traefik entrypoint, which is not exposed.
     # /!\ Do not expose your dashboard without any protection over the internet /!\
     entryPoints: ["traefik"]
+    # Additional ingressRoute middlewares (e.g. for authentication)
+    middlewares: []
 
 # Customize updateStrategy of traefik pods
 updateStrategy:
```

## 20.0.0  ![AppVersion: 2.9.4](https://img.shields.io/static/v1?label=AppVersion&message=2.9.4&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-11-08

* Allow updateStrategy to be configurable
* 🐛 remove old deployment workflow
* ✨ migrate to centralised helm repository

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 413aa88..2ec3736 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -134,9 +134,12 @@ ingressRoute:
     # /!\ Do not expose your dashboard without any protection over the internet /!\
     entryPoints: ["traefik"]
 
-rollingUpdate:
-  maxUnavailable: 0
-  maxSurge: 1
+# Customize updateStrategy of traefik pods
+updateStrategy:
+  type: RollingUpdate
+  rollingUpdate:
+    maxUnavailable: 0
+    maxSurge: 1
 
 # Customize liveness and readiness probe values.
 readinessProbe:
```

## 19.0.4  ![AppVersion: 2.9.4](https://img.shields.io/static/v1?label=AppVersion&message=2.9.4&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-11-08

* 🔧 Adds more settings & rename (wrong) scrapeInterval to (valid) interval on ServiceMonitor (#703)

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index b24c1cb..413aa88 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -261,10 +261,6 @@ metrics:
 ##  enable optional CRDs for Prometheus Operator
 ##
   #  serviceMonitor:
-  #    additionalLabels:
-  #      foo: bar
-  #    namespace: "another-namespace"
-  #    namespaceSelector: {}
   #    metricRelabelings: []
   #      - sourceLabels: [__name__]
   #        separator: ;
@@ -279,9 +275,17 @@ metrics:
   #        replacement: $1
   #        action: replace
   #    jobLabel: traefik
-  #    scrapeInterval: 30s
-  #    scrapeTimeout: 5s
+  #    interval: 30s
   #    honorLabels: true
+  #    # (Optional)
+  #    # scrapeTimeout: 5s
+  #    # honorTimestamps: true
+  #    # enableHttp2: true
+  #    # followRedirects: true
+  #    # additionalLabels:
+  #    #   foo: bar
+  #    # namespace: "another-namespace"
+  #    # namespaceSelector: {}
   #  prometheusRule:
   #    additionalLabels: {}
   #    namespace: "another-namespace"
```

## 19.0.3  ![AppVersion: 2.9.4](https://img.shields.io/static/v1?label=AppVersion&message=2.9.4&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-11-03

* 🎨 Don't require exposed Ports when enabling Hub (#700)


## 19.0.2  ![AppVersion: 2.9.4](https://img.shields.io/static/v1?label=AppVersion&message=2.9.4&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-11-03

* :speech_balloon: Support volume secrets with '.' in name (#695)


## 19.0.1  ![AppVersion: 2.9.4](https://img.shields.io/static/v1?label=AppVersion&message=2.9.4&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-11-03

* 🐛 Fix IngressClass install on EKS (#699)


## 19.0.0  ![AppVersion: 2.9.4](https://img.shields.io/static/v1?label=AppVersion&message=2.9.4&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-11-02

* ✨ Provides Default IngressClass for Traefik by default (#693)

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 69190f1..b24c1cb 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -100,11 +100,10 @@ podDisruptionBudget:
   # minAvailable: 0
   # minAvailable: 25%
 
-# Use ingressClass. Ignored if Traefik version < 2.3 / kubernetes < 1.18.x
+# Create a default IngressClass for Traefik
 ingressClass:
-  # true is not unit-testable yet, pending https://github.com/rancher/helm-unittest/pull/12
-  enabled: false
-  isDefaultClass: false
+  enabled: true
+  isDefaultClass: true
 
 # Enable experimental features
 experimental:
```

## 18.3.0  ![AppVersion: 2.9.4](https://img.shields.io/static/v1?label=AppVersion&message=2.9.4&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-10-31

* ⬆️  Update Traefik appVersion to 2.9.4 (#696)


## 18.2.0  ![AppVersion: 2.9.1](https://img.shields.io/static/v1?label=AppVersion&message=2.9.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-10-31

* 🚩 Add an optional "internal" service (#683)

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 8033a87..69190f1 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -416,7 +416,7 @@ ports:
     # The port protocol (TCP/UDP)
     protocol: TCP
     # Use nodeport if set. This is useful if you have configured Traefik in a
-    # LoadBalancer
+    # LoadBalancer.
     # nodePort: 32080
     # Port Redirections
     # Added in 2.2, you can make permanent redirects via entrypoints.
@@ -549,13 +549,24 @@ service:
     # - 172.16.0.0/16
   externalIPs: []
     # - 1.2.3.4
-  # One of SingleStack, PreferDualStack, or RequireDualStack.
+  ## One of SingleStack, PreferDualStack, or RequireDualStack.
   # ipFamilyPolicy: SingleStack
-  # List of IP families (e.g. IPv4 and/or IPv6).
-  # ref: https://kubernetes.io/docs/concepts/services-networking/dual-stack/#services
+  ## List of IP families (e.g. IPv4 and/or IPv6).
+  ## ref: https://kubernetes.io/docs/concepts/services-networking/dual-stack/#services
   # ipFamilies:
   #   - IPv4
   #   - IPv6
+  ##
+  ## An additionnal and optional internal Service.
+  ## Same parameters as external Service
+  # internal:
+  #   type: ClusterIP
+  #   # labels: {}
+  #   # annotations: {}
+  #   # spec: {}
+  #   # loadBalancerSourceRanges: []
+  #   # externalIPs: []
+  #   # ipFamilies: [ "IPv4","IPv6" ]
 
 ## Create HorizontalPodAutoscaler object.
 ##
```

## 18.1.0  ![AppVersion: 2.9.1](https://img.shields.io/static/v1?label=AppVersion&message=2.9.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-10-27

* 🚀 Add native support for Traefik Hub (#676)

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index acce704..8033a87 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -5,6 +5,27 @@ image:
   tag: ""
   pullPolicy: IfNotPresent
 
+#
+# Configure integration with Traefik Hub
+#
+hub:
+  ## Enabling Hub will:
+  # * enable Traefik Hub integration on Traefik
+  # * add `traefikhub-tunl` endpoint
+  # * enable addRoutersLabels on prometheus metrics
+  # * enable allowExternalNameServices on KubernetesIngress provider
+  # * enable allowCrossNamespace on KubernetesCRD provider
+  # * add an internal (ClusterIP) Service, dedicated for Traefik Hub
+  enabled: false
+  ## Default port can be changed
+  # tunnelPort: 9901
+  ## TLS is optional. Insecure is mutually exclusive with any other options
+  # tls:
+  #   insecure: false
+  #   ca: "/path/to/ca.pem"
+  #   cert: "/path/to/cert.pem"
+  #   key: "/path/to/key.pem"
+
 #
 # Configure the deployment
 #
@@ -505,6 +526,8 @@ tlsStore: {}
 # from.
 service:
   enabled: true
+  ## Single service is using `MixedProtocolLBService` feature gate.
+  ## When set to false, it will create two Service, one for TCP and one for UDP.
   single: true
   type: LoadBalancer
   # Additional annotations applied to both TCP and UDP services (e.g. for cloud provider specific config)
```

## 18.0.0  ![AppVersion: 2.9.1](https://img.shields.io/static/v1?label=AppVersion&message=2.9.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-10-26

* Refactor http3 and merge TCP with UDP ports into a single service (#656)

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 807bd09..acce704 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -87,8 +87,6 @@ ingressClass:
 
 # Enable experimental features
 experimental:
-  http3:
-    enabled: false
   plugins:
     enabled: false
   kubernetesGateway:
@@ -421,12 +419,19 @@ ports:
     # The port protocol (TCP/UDP)
     protocol: TCP
     # nodePort: 32443
-    # Enable HTTP/3.
-    # Requires enabling experimental http3 feature and tls.
-    # Note that you cannot have a UDP entrypoint with the same port.
-    # http3: true
-    # Set TLS at the entrypoint
-    # https://doc.traefik.io/traefik/routing/entrypoints/#tls
+    #
+    ## Enable HTTP/3 on the entrypoint
+    ## Enabling it will also enable http3 experimental feature
+    ## https://doc.traefik.io/traefik/routing/entrypoints/#http3
+    ## There are known limitations when trying to listen on same ports for
+    ## TCP & UDP (Http3). There is a workaround in this chart using dual Service.
+    ## https://github.com/kubernetes/kubernetes/issues/47249#issuecomment-587960741
+    http3:
+      enabled: false
+    # advertisedPort: 4443
+    #
+    ## Set TLS at the entrypoint
+    ## https://doc.traefik.io/traefik/routing/entrypoints/#tls
     tls:
       enabled: true
       # this is the name of a TLSOption definition
@@ -500,6 +505,7 @@ tlsStore: {}
 # from.
 service:
   enabled: true
+  single: true
   type: LoadBalancer
   # Additional annotations applied to both TCP and UDP services (e.g. for cloud provider specific config)
   annotations: {}
```

## 17.0.5  ![AppVersion: 2.9.1](https://img.shields.io/static/v1?label=AppVersion&message=2.9.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-10-21

* 📝 Add annotations changelog for artifacthub.io & update Maintainers


## 17.0.4  ![AppVersion: 2.9.1](https://img.shields.io/static/v1?label=AppVersion&message=2.9.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-10-21

* :art: Add helper function for label selector


## 17.0.3  ![AppVersion: 2.9.1](https://img.shields.io/static/v1?label=AppVersion&message=2.9.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-10-20

* 🐛 fix changing label selectors


## 17.0.2  ![AppVersion: 2.9.1](https://img.shields.io/static/v1?label=AppVersion&message=2.9.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-10-20

* fix: setting ports.web.proxyProtocol.insecure=true


## 17.0.1  ![AppVersion: 2.9.1](https://img.shields.io/static/v1?label=AppVersion&message=2.9.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-10-20

* :bug: Unify all labels selector with traefik chart labels (#681)

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 6a90bc6..807bd09 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -639,7 +639,7 @@ affinity: {}
 #      - labelSelector:
 #          matchLabels:
 #            app.kubernetes.io/name: '{{ template "traefik.name" . }}'
-#            app.kubernetes.io/instance: '{{ .Release.Name }}'
+#            app.kubernetes.io/instance: '{{ .Release.Name }}-{{ .Release.Namespace }}'
 #        topologyKey: kubernetes.io/hostname
 
 nodeSelector: {}
```

## 17.0.0  ![AppVersion: 2.9.1](https://img.shields.io/static/v1?label=AppVersion&message=2.9.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-10-20

* :bug: Fix `ClusterRole`, `ClusterRoleBinding` names and `app.kubernetes.io/instance` label (#662)


## 16.2.0  ![AppVersion: 2.9.1](https://img.shields.io/static/v1?label=AppVersion&message=2.9.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-10-20

* Add forwardedHeaders and proxyProtocol config (#673)

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 9b5afc4..6a90bc6 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -403,6 +403,16 @@ ports:
     # Added in 2.2, you can make permanent redirects via entrypoints.
     # https://docs.traefik.io/routing/entrypoints/#redirection
     # redirectTo: websecure
+    #
+    # Trust forwarded  headers information (X-Forwarded-*).
+    # forwardedHeaders:
+    #   trustedIPs: []
+    #   insecure: false
+    #
+    # Enable the Proxy Protocol header parsing for the entry point
+    # proxyProtocol:
+    #   trustedIPs: []
+    #   insecure: false
   websecure:
     port: 8443
     # hostPort: 8443
@@ -428,6 +438,16 @@ ports:
       #     - foo.example.com
       #     - bar.example.com
     #
+    # Trust forwarded  headers information (X-Forwarded-*).
+    # forwardedHeaders:
+    #   trustedIPs: []
+    #   insecure: false
+    #
+    # Enable the Proxy Protocol header parsing for the entry point
+    # proxyProtocol:
+    #   trustedIPs: []
+    #   insecure: false
+    #
     # One can apply Middlewares on an entrypoint
     # https://doc.traefik.io/traefik/middlewares/overview/
     # https://doc.traefik.io/traefik/routing/entrypoints/#middlewares
```

## 16.1.0  ![AppVersion: 2.9.1](https://img.shields.io/static/v1?label=AppVersion&message=2.9.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-10-19

* ✨ add optional ServiceMonitor & PrometheusRules CRDs (#425)

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 7e335b5..9b5afc4 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -237,8 +237,46 @@ metrics:
   prometheus:
     entryPoint: metrics
   #  addRoutersLabels: true
-  # statsd:
-  #   address: localhost:8125
+  #  statsd:
+  #    address: localhost:8125
+##
+##  enable optional CRDs for Prometheus Operator
+##
+  #  serviceMonitor:
+  #    additionalLabels:
+  #      foo: bar
+  #    namespace: "another-namespace"
+  #    namespaceSelector: {}
+  #    metricRelabelings: []
+  #      - sourceLabels: [__name__]
+  #        separator: ;
+  #        regex: ^fluentd_output_status_buffer_(oldest|newest)_.+
+  #        replacement: $1
+  #        action: drop
+  #    relabelings: []
+  #      - sourceLabels: [__meta_kubernetes_pod_node_name]
+  #        separator: ;
+  #        regex: ^(.*)$
+  #        targetLabel: nodename
+  #        replacement: $1
+  #        action: replace
+  #    jobLabel: traefik
+  #    scrapeInterval: 30s
+  #    scrapeTimeout: 5s
+  #    honorLabels: true
+  #  prometheusRule:
+  #    additionalLabels: {}
+  #    namespace: "another-namespace"
+  #    rules:
+  #      - alert: TraefikDown
+  #        expr: up{job="traefik"} == 0
+  #        for: 5m
+  #        labels:
+  #          context: traefik
+  #          severity: warning
+  #        annotations:
+  #          summary: "Traefik Down"
+  #          description: "{{ $labels.pod }} on {{ $labels.nodename }} is down"
 
 tracing: {}
   # instana:
```

## 16.0.0  ![AppVersion: 2.9.1](https://img.shields.io/static/v1?label=AppVersion&message=2.9.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-10-19

* :fire: Remove `Pilot` and `fallbackApiVersion` (#665)

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 03fdaed..7e335b5 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -84,15 +84,6 @@ ingressClass:
   # true is not unit-testable yet, pending https://github.com/rancher/helm-unittest/pull/12
   enabled: false
   isDefaultClass: false
-  # Use to force a networking.k8s.io API Version for certain CI/CD applications. E.g. "v1beta1"
-  fallbackApiVersion: ""
-
-# Activate Pilot integration
-pilot:
-  enabled: false
-  token: ""
-  # Toggle Pilot Dashboard
-  # dashboard: false
 
 # Enable experimental features
 experimental:
```

## 15.3.1  ![AppVersion: 2.9.1](https://img.shields.io/static/v1?label=AppVersion&message=2.9.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-10-18

* :art: Improve `IngressRoute` structure (#674)


## 15.3.0  ![AppVersion: 2.9.1](https://img.shields.io/static/v1?label=AppVersion&message=2.9.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-10-18

* 📌 Add capacity to enable User-facing role

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 76aac93..03fdaed 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -553,10 +553,12 @@ hostNetwork: false
 # Whether Role Based Access Control objects like roles and rolebindings should be created
 rbac:
   enabled: true
-
   # If set to false, installs ClusterRole and ClusterRoleBinding so Traefik can be used across namespaces.
   # If set to true, installs Role and RoleBinding. Providers will only watch target namespace.
   namespaced: false
+  # Enable user-facing roles
+  # https://kubernetes.io/docs/reference/access-authn-authz/rbac/#user-facing-roles
+  # aggregateTo: [ "admin" ]
 
 # Enable to create a PodSecurityPolicy and assign it to the Service Account via RoleBinding or ClusterRoleBinding
 podSecurityPolicy:
```

## 15.2.2  ![AppVersion: 2.9.1](https://img.shields.io/static/v1?label=AppVersion&message=2.9.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-10-17

* Fix provider namespace changes


## 15.2.1  ![AppVersion: 2.9.1](https://img.shields.io/static/v1?label=AppVersion&message=2.9.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-10-17

* 🐛 fix provider namespace changes


## 15.2.0  ![AppVersion: 2.9.1](https://img.shields.io/static/v1?label=AppVersion&message=2.9.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-10-17

* :bug: Allow to watch on specific namespaces without using rbac.namespaced (#666)

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 781ac15..76aac93 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -555,7 +555,7 @@ rbac:
   enabled: true
 
   # If set to false, installs ClusterRole and ClusterRoleBinding so Traefik can be used across namespaces.
-  # If set to true, installs namespace-specific Role and RoleBinding and requires provider configuration be set to that same namespace
+  # If set to true, installs Role and RoleBinding. Providers will only watch target namespace.
   namespaced: false
 
 # Enable to create a PodSecurityPolicy and assign it to the Service Account via RoleBinding or ClusterRoleBinding
```

## 15.1.1  ![AppVersion: 2.9.1](https://img.shields.io/static/v1?label=AppVersion&message=2.9.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-10-17

* :goal_net: Fail gracefully when http3 is not enabled correctly (#667)


## 15.1.0  ![AppVersion: 2.9.1](https://img.shields.io/static/v1?label=AppVersion&message=2.9.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-10-14

* :sparkles: add optional topologySpreadConstraints (#663)

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index fc2c371..781ac15 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -593,6 +593,15 @@ affinity: {}
 
 nodeSelector: {}
 tolerations: []
+topologySpreadConstraints: []
+# # This example topologySpreadConstraints forces the scheduler to put traefik pods
+# # on nodes where no other traefik pods are scheduled.
+#  - labelSelector:
+#      matchLabels:
+#        app: '{{ template "traefik.name" . }}'
+#    maxSkew: 1
+#    topologyKey: kubernetes.io/hostname
+#    whenUnsatisfiable: DoNotSchedule
 
 # Pods can have priority.
 # Priority indicates the importance of a Pod relative to other Pods.
```

## 15.0.0  ![AppVersion: 2.9.1](https://img.shields.io/static/v1?label=AppVersion&message=2.9.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-10-13

* :rocket: Enable TLS by default on `websecure` port (#657)

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 400a29a..fc2c371 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -389,7 +389,7 @@ ports:
     # Set TLS at the entrypoint
     # https://doc.traefik.io/traefik/routing/entrypoints/#tls
     tls:
-      enabled: false
+      enabled: true
       # this is the name of a TLSOption definition
       options: ""
       certResolver: ""
```

## 14.0.2  ![AppVersion: 2.9.1](https://img.shields.io/static/v1?label=AppVersion&message=2.9.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-10-13

* :memo: Add Changelog (#661)


## 14.0.1  ![AppVersion: 2.9.1](https://img.shields.io/static/v1?label=AppVersion&message=2.9.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-10-11

* :memo: Update workaround for permissions 660 on acme.json

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index a4e4ff2..400a29a 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -45,10 +45,10 @@ deployment:
   # Additional initContainers (e.g. for setting file permission as shown below)
   initContainers: []
     # The "volume-permissions" init container is required if you run into permission issues.
-    # Related issue: https://github.com/traefik/traefik/issues/6972
+    # Related issue: https://github.com/traefik/traefik/issues/6825
     # - name: volume-permissions
-    #   image: busybox:1.31.1
-    #   command: ["sh", "-c", "chmod -Rv 600 /data/*"]
+    #   image: busybox:1.35
+    #   command: ["sh", "-c", "touch /data/acme.json && chmod -Rv 600 /data/* && chown 65532:65532 /data/acme.json"]
     #   volumeMounts:
     #     - name: data
     #       mountPath: /data
```

## 14.0.0  ![AppVersion: 2.9.1](https://img.shields.io/static/v1?label=AppVersion&message=2.9.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-10-11

* Limit rbac to only required resources for Ingress and CRD providers


## 13.0.1  ![AppVersion: 2.9.1](https://img.shields.io/static/v1?label=AppVersion&message=2.9.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-10-11

* Add helper function for common labels


## 13.0.0  ![AppVersion: 2.9.1](https://img.shields.io/static/v1?label=AppVersion&message=2.9.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-10-11

* Moved list object to individual objects


## 12.0.7  ![AppVersion: 2.9.1](https://img.shields.io/static/v1?label=AppVersion&message=2.9.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-10-10

* :lipstick: Affinity templating and example (#557)

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 4431c36..a4e4ff2 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -578,19 +578,19 @@ resources: {}
   # limits:
   #   cpu: "300m"
   #   memory: "150Mi"
+
+# This example pod anti-affinity forces the scheduler to put traefik pods
+# on nodes where no other traefik pods are scheduled.
+# It should be used when hostNetwork: true to prevent port conflicts
 affinity: {}
-# # This example pod anti-affinity forces the scheduler to put traefik pods
-# # on nodes where no other traefik pods are scheduled.
-# # It should be used when hostNetwork: true to prevent port conflicts
-#   podAntiAffinity:
-#     requiredDuringSchedulingIgnoredDuringExecution:
-#       - labelSelector:
-#           matchExpressions:
-#             - key: app.kubernetes.io/name
-#               operator: In
-#               values:
-#                 - {{ template "traefik.name" . }}
-#         topologyKey: kubernetes.io/hostname
+#  podAntiAffinity:
+#    requiredDuringSchedulingIgnoredDuringExecution:
+#      - labelSelector:
+#          matchLabels:
+#            app.kubernetes.io/name: '{{ template "traefik.name" . }}'
+#            app.kubernetes.io/instance: '{{ .Release.Name }}'
+#        topologyKey: kubernetes.io/hostname
+
 nodeSelector: {}
 tolerations: []
 
```

## 12.0.6  ![AppVersion: 2.9.1](https://img.shields.io/static/v1?label=AppVersion&message=2.9.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-10-10

* :bug: Ignore kustomization file used for CRDs update (#653)


## 12.0.5  ![AppVersion: 2.9.1](https://img.shields.io/static/v1?label=AppVersion&message=2.9.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-10-10

* :memo: Establish Traefik & CRD update process

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 3526729..4431c36 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -342,6 +342,7 @@ ports:
 
     # Override the liveness/readiness port. This is useful to integrate traefik
     # with an external Load Balancer that performs healthchecks.
+    # Default: ports.traefik.port
     # healthchecksPort: 9000
 
     # Override the liveness/readiness scheme. Useful for getting ping to
```

## 12.0.4  ![AppVersion: 2.9.1](https://img.shields.io/static/v1?label=AppVersion&message=2.9.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-10-10

* Allows ingressClass to be used without semver-compatible image tag


## 12.0.3  ![AppVersion: 2.9.1](https://img.shields.io/static/v1?label=AppVersion&message=2.9.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-10-10

* :bug: Should check hostNetwork when hostPort != containerPort


## 12.0.2  ![AppVersion: 2.9.1](https://img.shields.io/static/v1?label=AppVersion&message=2.9.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-10-07

* :goal_net: Fail gracefully when hostNetwork is enabled and hostPort != containerPort


## 12.0.1  ![AppVersion: 2.9.1](https://img.shields.io/static/v1?label=AppVersion&message=2.9.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-10-07

* :bug: Fix a typo on `behavior` for HPA v2


## 12.0.0  ![AppVersion: 2.9.1](https://img.shields.io/static/v1?label=AppVersion&message=2.9.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-10-06

* Update default HPA API Version to `v2` and add support for behavior (#518)

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 2bd51f8..3526729 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -488,11 +488,22 @@ autoscaling:
 #   - type: Resource
 #     resource:
 #       name: cpu
-#       targetAverageUtilization: 60
+#       target:
+#         type: Utilization
+#         averageUtilization: 60
 #   - type: Resource
 #     resource:
 #       name: memory
-#       targetAverageUtilization: 60
+#       target:
+#         type: Utilization
+#         averageUtilization: 60
+#   behavior:
+#     scaleDown:
+#       stabilizationWindowSeconds: 300
+#       policies:
+#       - type: Pods
+#         value: 1
+#         periodSeconds: 60
 
 # Enable persistence using Persistent Volume Claims
 # ref: http://kubernetes.io/docs/user-guide/persistent-volumes/
```

## 11.1.1  ![AppVersion: 2.9.1](https://img.shields.io/static/v1?label=AppVersion&message=2.9.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-10-05

* 🔊 add failure message when using maxUnavailable 0 and hostNetwork


## 11.1.0  ![AppVersion: 2.9.1](https://img.shields.io/static/v1?label=AppVersion&message=2.9.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-10-04

* Update Traefik to v2.9.1


## 11.0.0  ![AppVersion: 2.8.7](https://img.shields.io/static/v1?label=AppVersion&message=2.8.7&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-10-04

* tweak default values to avoid downtime when updating

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 844cadc..2bd51f8 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -126,20 +126,20 @@ ingressRoute:
     entryPoints: ["traefik"]
 
 rollingUpdate:
-  maxUnavailable: 1
+  maxUnavailable: 0
   maxSurge: 1
 
 # Customize liveness and readiness probe values.
 readinessProbe:
   failureThreshold: 1
-  initialDelaySeconds: 10
+  initialDelaySeconds: 2
   periodSeconds: 10
   successThreshold: 1
   timeoutSeconds: 2
 
 livenessProbe:
   failureThreshold: 3
-  initialDelaySeconds: 10
+  initialDelaySeconds: 2
   periodSeconds: 10
   successThreshold: 1
   timeoutSeconds: 2
```

## 10.33.0  ![AppVersion: 2.8.7](https://img.shields.io/static/v1?label=AppVersion&message=2.8.7&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-10-04

* :rocket: Add `extraObjects` value that allows creating adhoc resources

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index c926bd9..844cadc 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -598,3 +598,10 @@ securityContext:
 
 podSecurityContext:
   fsGroup: 65532
+
+#
+# Extra objects to deploy (value evaluated as a template)
+#
+# In some cases, it can avoid the need for additional, extended or adhoc deployments.
+# See #595 for more details and traefik/tests/extra.yaml for example.
+extraObjects: []
```

## 10.32.0  ![AppVersion: 2.8.7](https://img.shields.io/static/v1?label=AppVersion&message=2.8.7&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-10-03

* Add support setting middleware on entrypoint

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 3957448..c926bd9 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -397,6 +397,16 @@ ports:
       #   sans:
       #     - foo.example.com
       #     - bar.example.com
+    #
+    # One can apply Middlewares on an entrypoint
+    # https://doc.traefik.io/traefik/middlewares/overview/
+    # https://doc.traefik.io/traefik/routing/entrypoints/#middlewares
+    # /!\ It introduces here a link between your static configuration and your dynamic configuration /!\
+    # It follows the provider naming convention: https://doc.traefik.io/traefik/providers/overview/#provider-namespace
+    # middlewares:
+    #   - namespace-name1@kubernetescrd
+    #   - namespace-name2@kubernetescrd
+    middlewares: []
   metrics:
     # When using hostNetwork, use another port to avoid conflict with node exporter:
     # https://github.com/prometheus/prometheus/wiki/Default-port-allocations
```

## 10.31.0  ![AppVersion: 2.8.7](https://img.shields.io/static/v1?label=AppVersion&message=2.8.7&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-10-03

* Support setting dashboard entryPoints for ingressRoute resource

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index c9feb76..3957448 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -120,6 +120,10 @@ ingressRoute:
     annotations: {}
     # Additional ingressRoute labels (e.g. for filtering IngressRoute by custom labels)
     labels: {}
+    # Specify the allowed entrypoints to use for the dashboard ingress route, (e.g. traefik, web, websecure).
+    # By default, it's using traefik entrypoint, which is not exposed.
+    # /!\ Do not expose your dashboard without any protection over the internet /!\
+    entryPoints: ["traefik"]
 
 rollingUpdate:
   maxUnavailable: 1
```

## 10.30.2  ![AppVersion: 2.8.7](https://img.shields.io/static/v1?label=AppVersion&message=2.8.7&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-10-03

* :test_tube: Fail gracefully when asked to provide a service without ports


## 10.30.1  ![AppVersion: 2.8.7](https://img.shields.io/static/v1?label=AppVersion&message=2.8.7&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-09-30

* :arrow_up: Upgrade helm, ct & unittest (#638)


## 10.30.0  ![AppVersion: 2.8.7](https://img.shields.io/static/v1?label=AppVersion&message=2.8.7&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-09-30

* Add support HTTPS scheme for healthcheks

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index fed4a8a..c9feb76 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -340,6 +340,10 @@ ports:
     # with an external Load Balancer that performs healthchecks.
     # healthchecksPort: 9000
 
+    # Override the liveness/readiness scheme. Useful for getting ping to
+    # respond on websecure entryPoint.
+    # healthchecksScheme: HTTPS
+
     # Defines whether the port is exposed if service.type is LoadBalancer or
     # NodePort.
     #
```

## 10.29.0  ![AppVersion: 2.8.7](https://img.shields.io/static/v1?label=AppVersion&message=2.8.7&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-09-29

* Add missing tracing options

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index d1708cc..fed4a8a 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -247,12 +247,45 @@ metrics:
 
 tracing: {}
   # instana:
-  #   enabled: true
+  #   localAgentHost: 127.0.0.1
+  #   localAgentPort: 42699
+  #   logLevel: info
+  #   enableAutoProfile: true
   # datadog:
   #   localAgentHostPort: 127.0.0.1:8126
   #   debug: false
   #   globalTag: ""
   #   prioritySampling: false
+  # jaeger:
+  #   samplingServerURL: http://localhost:5778/sampling
+  #   samplingType: const
+  #   samplingParam: 1.0
+  #   localAgentHostPort: 127.0.0.1:6831
+  #   gen128Bit: false
+  #   propagation: jaeger
+  #   traceContextHeaderName: uber-trace-id
+  #   disableAttemptReconnecting: true
+  #   collector:
+  #      endpoint: ""
+  #      user: ""
+  #      password: ""
+  # zipkin:
+  #   httpEndpoint: http://localhost:9411/api/v2/spans
+  #   sameSpan: false
+  #   id128Bit: true
+  #   sampleRate: 1.0
+  # haystack:
+  #   localAgentHost: 127.0.0.1
+  #   localAgentPort: 35000
+  #   globalTag: ""
+  #   traceIDHeaderName: ""
+  #   parentIDHeaderName: ""
+  #   spanIDHeaderName: ""
+  #   baggagePrefixHeaderName: ""
+  # elastic:
+  #   serverURL: http://localhost:8200
+  #   secretToken: ""
+  #   serviceEnvironment: ""
 
 globalArguments:
   - "--global.checknewversion"
```

## 10.28.0  ![AppVersion: 2.8.7](https://img.shields.io/static/v1?label=AppVersion&message=2.8.7&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-09-29

* feat: add lifecycle for prestop and poststart

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 19a133c..d1708cc 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -59,6 +59,17 @@ deployment:
   # Additional imagePullSecrets
   imagePullSecrets: []
     # - name: myRegistryKeySecretName
+  # Pod lifecycle actions
+  lifecycle: {}
+    # preStop:
+    #   exec:
+    #     command: ["/bin/sh", "-c", "sleep 40"]
+    # postStart:
+    #   httpGet:
+    #     path: /ping
+    #     port: 9000
+    #     host: localhost
+    #     scheme: HTTP
 
 # Pod disruption budget
 podDisruptionBudget:
```

## 10.27.0  ![AppVersion: 2.8.7](https://img.shields.io/static/v1?label=AppVersion&message=2.8.7&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-09-29

* feat: add create gateway option

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index d9c745e..19a133c 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -91,6 +91,8 @@ experimental:
     enabled: false
   kubernetesGateway:
     enabled: false
+    gateway:
+      enabled: true
     # certificate:
     #   group: "core"
     #   kind: "Secret"
```

## 10.26.1  ![AppVersion: 2.8.7](https://img.shields.io/static/v1?label=AppVersion&message=2.8.7&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-09-28

* 🐛 fix rbac templating (#636)


## 10.26.0  ![AppVersion: 2.8.7](https://img.shields.io/static/v1?label=AppVersion&message=2.8.7&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-09-28

* :bug: Fix ingressClass support when rbac.namespaced=true (#499)


## 10.25.1  ![AppVersion: 2.8.7](https://img.shields.io/static/v1?label=AppVersion&message=2.8.7&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-09-28

* Add ingressclasses to traefik role


## 10.25.0  ![AppVersion: 2.8.7](https://img.shields.io/static/v1?label=AppVersion&message=2.8.7&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-09-27

* Add TLSStore resource to chart

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index d4011c3..d9c745e 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -373,6 +373,15 @@ ports:
 #       - CurveP384
 tlsOptions: {}
 
+# TLS Store are created as TLSStore CRDs. This is useful if you want to set a default certificate
+# https://doc.traefik.io/traefik/https/tls/#default-certificate
+# Example:
+# tlsStore:
+#   default:
+#     defaultCertificate:
+#       secretName: tls-cert
+tlsStore: {}
+
 # Options for the main traefik service, where the entrypoints traffic comes
 # from.
 service:
```

## 10.24.5  ![AppVersion: 2.8.7](https://img.shields.io/static/v1?label=AppVersion&message=2.8.7&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-09-27

* Suggest an alternative port for metrics

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 81f2e85..d4011c3 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -344,6 +344,8 @@ ports:
       #     - foo.example.com
       #     - bar.example.com
   metrics:
+    # When using hostNetwork, use another port to avoid conflict with node exporter:
+    # https://github.com/prometheus/prometheus/wiki/Default-port-allocations
     port: 9100
     # hostPort: 9100
     # Defines whether the port is exposed if service.type is LoadBalancer or
```

## 10.24.4  ![AppVersion: 2.8.7](https://img.shields.io/static/v1?label=AppVersion&message=2.8.7&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-09-26

* Update Traefik to v2.8.7


## 10.24.3  ![AppVersion: 2.8.5](https://img.shields.io/static/v1?label=AppVersion&message=2.8.5&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-09-14

* Update Traefik version to v2.8.5


## 10.24.2  ![AppVersion: 2.8.4](https://img.shields.io/static/v1?label=AppVersion&message=2.8.4&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-09-05

* Update Traefik version to v2.8.4


## 10.24.1  ![AppVersion: 2.8.0](https://img.shields.io/static/v1?label=AppVersion&message=2.8.0&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-08-29

* Update PodDisruptionBudget apiVersion to policy/v1


## 10.24.0  ![AppVersion: 2.8.0](https://img.shields.io/static/v1?label=AppVersion&message=2.8.0&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-06-30

* Update Traefik version to v2.8.0


## 10.23.0  ![AppVersion: 2.7.1](https://img.shields.io/static/v1?label=AppVersion&message=2.7.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-06-27

* Support environment variable usage for Datadog


## 10.22.0  ![AppVersion: 2.7.1](https://img.shields.io/static/v1?label=AppVersion&message=2.7.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-06-22

* Allow setting revisionHistoryLimit for Deployment and DaemonSet

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index d5785ab..81f2e85 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -14,6 +14,8 @@ deployment:
   kind: Deployment
   # Number of pods of the deployment (only applies when kind == Deployment)
   replicas: 1
+  # Number of old history to retain to allow rollback (If not set, default Kubernetes value is set to 10)
+  # revisionHistoryLimit: 1
   # Amount of time (in seconds) before Kubernetes will send the SIGKILL signal if Traefik does not shut down
   terminationGracePeriodSeconds: 60
   # The minimum number of seconds Traefik needs to be up and running before the DaemonSet/Deployment controller considers it available
```

## 10.21.1  ![AppVersion: 2.7.1](https://img.shields.io/static/v1?label=AppVersion&message=2.7.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-06-15

* Update Traefik version to 2.7.1


## 10.21.0  ![AppVersion: 2.7.0](https://img.shields.io/static/v1?label=AppVersion&message=2.7.0&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-06-15

* Support allowEmptyServices config for KubernetesCRD

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index e141e29..d5785ab 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -133,6 +133,7 @@ providers:
     enabled: true
     allowCrossNamespace: false
     allowExternalNameServices: false
+    allowEmptyServices: false
     # ingressClass: traefik-internal
     # labelSelector: environment=production,method=traefik
     namespaces: []
```

## 10.20.1  ![AppVersion: 2.7.0](https://img.shields.io/static/v1?label=AppVersion&message=2.7.0&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-06-01

* Add Acme certificate resolver configuration

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index a16b107..e141e29 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -433,6 +433,27 @@ persistence:
   annotations: {}
   # subPath: "" # only mount a subpath of the Volume into the pod
 
+certResolvers: {}
+#   letsencrypt:
+#     # for challenge options cf. https://doc.traefik.io/traefik/https/acme/
+#     email: email@example.com
+#     dnsChallenge:
+#       # also add the provider's required configuration under env
+#       # or expand then from secrets/configmaps with envfrom
+#       # cf. https://doc.traefik.io/traefik/https/acme/#providers
+#       provider: digitalocean
+#       # add futher options for the dns challenge as needed
+#       # cf. https://doc.traefik.io/traefik/https/acme/#dnschallenge
+#       delayBeforeCheck: 30
+#       resolvers:
+#         - 1.1.1.1
+#         - 8.8.8.8
+#     tlsChallenge: true
+#     httpChallenge:
+#       entryPoint: "web"
+#     # match the path to persistence
+#     storage: /data/acme.json
+
 # If hostNetwork is true, runs traefik in the host network namespace
 # To prevent unschedulabel pods due to port collisions, if hostNetwork=true
 # and replicas>1, a pod anti-affinity is recommended and will be set if the
```

## 10.20.0  ![AppVersion: 2.7.0](https://img.shields.io/static/v1?label=AppVersion&message=2.7.0&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-05-25

* Update Traefik Proxy to v2.7.0


## 10.19.5  ![AppVersion: 2.6.6](https://img.shields.io/static/v1?label=AppVersion&message=2.6.6&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-05-04

* Upgrade Traefik to 2.6.6


## 10.19.4  ![AppVersion: 2.6.3](https://img.shields.io/static/v1?label=AppVersion&message=2.6.3&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-03-31

* Update Traefik dependency version to 2.6.3


## 10.19.3  ![AppVersion: 2.6.2](https://img.shields.io/static/v1?label=AppVersion&message=2.6.2&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-03-30

* Update CRDs to match the ones defined in the reference documentation


## 10.19.2  ![AppVersion: 2.6.2](https://img.shields.io/static/v1?label=AppVersion&message=2.6.2&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-03-30

* Revert Traefik version to 2.6.2


## 10.19.1  ![AppVersion: 2.6.3](https://img.shields.io/static/v1?label=AppVersion&message=2.6.3&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-03-30

* Update Traefik version to 2.6.3


## 10.19.0  ![AppVersion: 2.6.2](https://img.shields.io/static/v1?label=AppVersion&message=2.6.2&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-03-28

* Support ingressClass option for KubernetesIngress provider

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 02ab704..a16b107 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -142,6 +142,7 @@ providers:
     enabled: true
     allowExternalNameServices: false
     allowEmptyServices: false
+    # ingressClass: traefik-internal
     # labelSelector: environment=production,method=traefik
     namespaces: []
       # - "default"
```

## 10.18.0  ![AppVersion: 2.6.2](https://img.shields.io/static/v1?label=AppVersion&message=2.6.2&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-03-28

* Support liveness and readyness probes customization

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 15f1103..02ab704 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -110,6 +110,20 @@ rollingUpdate:
   maxUnavailable: 1
   maxSurge: 1
 
+# Customize liveness and readiness probe values.
+readinessProbe:
+  failureThreshold: 1
+  initialDelaySeconds: 10
+  periodSeconds: 10
+  successThreshold: 1
+  timeoutSeconds: 2
+
+livenessProbe:
+  failureThreshold: 3
+  initialDelaySeconds: 10
+  periodSeconds: 10
+  successThreshold: 1
+  timeoutSeconds: 2
 
 #
 # Configure providers
```

## 10.17.0  ![AppVersion: 2.6.2](https://img.shields.io/static/v1?label=AppVersion&message=2.6.2&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-03-28

* Support Datadog tracing

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 4dccd1a..15f1103 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -217,6 +217,11 @@ metrics:
 tracing: {}
   # instana:
   #   enabled: true
+  # datadog:
+  #   localAgentHostPort: 127.0.0.1:8126
+  #   debug: false
+  #   globalTag: ""
+  #   prioritySampling: false
 
 globalArguments:
   - "--global.checknewversion"
```

## 10.16.1  ![AppVersion: 2.6.2](https://img.shields.io/static/v1?label=AppVersion&message=2.6.2&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-03-28

* Update Traefik version to 2.6.2


## 10.16.0  ![AppVersion: 2.6.1](https://img.shields.io/static/v1?label=AppVersion&message=2.6.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-03-28

* Support allowEmptyServices for KubernetesIngress provider

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 1f9dbbe..4dccd1a 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -127,6 +127,7 @@ providers:
   kubernetesIngress:
     enabled: true
     allowExternalNameServices: false
+    allowEmptyServices: false
     # labelSelector: environment=production,method=traefik
     namespaces: []
       # - "default"
```

## 10.15.0  ![AppVersion: 2.6.1](https://img.shields.io/static/v1?label=AppVersion&message=2.6.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-03-08

* Add metrics.prometheus.addRoutersLabels option

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index cd4d49b..1f9dbbe 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -209,6 +209,7 @@ metrics:
   #   protocol: udp
   prometheus:
     entryPoint: metrics
+  #  addRoutersLabels: true
   # statsd:
   #   address: localhost:8125
 
```

## 10.14.2  ![AppVersion: 2.6.1](https://img.shields.io/static/v1?label=AppVersion&message=2.6.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-02-18

* Update Traefik to v2.6.1


## 10.14.1  ![AppVersion: 2.6.0](https://img.shields.io/static/v1?label=AppVersion&message=2.6.0&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-02-09

* Add missing inFlightConn TCP middleware CRD


## 10.14.0  ![AppVersion: 2.6.0](https://img.shields.io/static/v1?label=AppVersion&message=2.6.0&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-02-03

* Add experimental HTTP/3 support

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index d49122f..cd4d49b 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -83,6 +83,8 @@ pilot:
 
 # Enable experimental features
 experimental:
+  http3:
+    enabled: false
   plugins:
     enabled: false
   kubernetesGateway:
@@ -300,6 +302,10 @@ ports:
     # The port protocol (TCP/UDP)
     protocol: TCP
     # nodePort: 32443
+    # Enable HTTP/3.
+    # Requires enabling experimental http3 feature and tls.
+    # Note that you cannot have a UDP entrypoint with the same port.
+    # http3: true
     # Set TLS at the entrypoint
     # https://doc.traefik.io/traefik/routing/entrypoints/#tls
     tls:
```

## 10.13.0  ![AppVersion: 2.6.0](https://img.shields.io/static/v1?label=AppVersion&message=2.6.0&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-02-01

* Add support for ipFamilies

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 32fce6f..d49122f 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -366,6 +366,11 @@ service:
     # - 1.2.3.4
   # One of SingleStack, PreferDualStack, or RequireDualStack.
   # ipFamilyPolicy: SingleStack
+  # List of IP families (e.g. IPv4 and/or IPv6).
+  # ref: https://kubernetes.io/docs/concepts/services-networking/dual-stack/#services
+  # ipFamilies:
+  #   - IPv4
+  #   - IPv6
 
 ## Create HorizontalPodAutoscaler object.
 ##
```

## 10.12.0  ![AppVersion: 2.6.0](https://img.shields.io/static/v1?label=AppVersion&message=2.6.0&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-02-01

* Add shareProcessNamespace option to podtemplate

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index ab25456..32fce6f 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -50,6 +50,8 @@ deployment:
     #   volumeMounts:
     #     - name: data
     #       mountPath: /data
+  # Use process namespace sharing
+  shareProcessNamespace: false
   # Custom pod DNS policy. Apply if `hostNetwork: true`
   # dnsPolicy: ClusterFirstWithHostNet
   # Additional imagePullSecrets
```

## 10.11.1  ![AppVersion: 2.6.0](https://img.shields.io/static/v1?label=AppVersion&message=2.6.0&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-01-31

* Fix anti-affinity example

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 8c72905..ab25456 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -438,13 +438,13 @@ affinity: {}
 # # It should be used when hostNetwork: true to prevent port conflicts
 #   podAntiAffinity:
 #     requiredDuringSchedulingIgnoredDuringExecution:
-#     - labelSelector:
-#         matchExpressions:
-#         - key: app
-#           operator: In
-#           values:
-#           - {{ template "traefik.name" . }}
-#       topologyKey: failure-domain.beta.kubernetes.io/zone
+#       - labelSelector:
+#           matchExpressions:
+#             - key: app.kubernetes.io/name
+#               operator: In
+#               values:
+#                 - {{ template "traefik.name" . }}
+#         topologyKey: kubernetes.io/hostname
 nodeSelector: {}
 tolerations: []
 
```

## 10.11.0  ![AppVersion: 2.6.0](https://img.shields.io/static/v1?label=AppVersion&message=2.6.0&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-01-31

* Add setting to enable Instana tracing

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 7fe4a2c..8c72905 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -208,6 +208,10 @@ metrics:
   # statsd:
   #   address: localhost:8125
 
+tracing: {}
+  # instana:
+  #   enabled: true
+
 globalArguments:
   - "--global.checknewversion"
   - "--global.sendanonymoususage"
```

## 10.10.0  ![AppVersion: 2.6.0](https://img.shields.io/static/v1?label=AppVersion&message=2.6.0&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2022-01-31

* Update Traefik to v2.6

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 8ae4bd8..7fe4a2c 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -85,9 +85,8 @@ experimental:
     enabled: false
   kubernetesGateway:
     enabled: false
-    appLabelSelector: "traefik"
-    certificates: []
-    # - group: "core"
+    # certificate:
+    #   group: "core"
     #   kind: "Secret"
     #   name: "mysecret"
     # By default, Gateway would be created to the Namespace you are deploying Traefik to.
```

## 10.9.1  ![AppVersion: 2.5.6](https://img.shields.io/static/v1?label=AppVersion&message=2.5.6&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-12-24

* Bump traefik version to 2.5.6


## 10.9.0  ![AppVersion: 2.5.4](https://img.shields.io/static/v1?label=AppVersion&message=2.5.4&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-12-20

* feat: add allowExternalNameServices to KubernetesIngress provider

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 79df205..8ae4bd8 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -123,6 +123,7 @@ providers:
 
   kubernetesIngress:
     enabled: true
+    allowExternalNameServices: false
     # labelSelector: environment=production,method=traefik
     namespaces: []
       # - "default"
```

## 10.8.0  ![AppVersion: 2.5.4](https://img.shields.io/static/v1?label=AppVersion&message=2.5.4&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-12-20

* Add support to specify minReadySeconds on Deployment/DaemonSet

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 7e9186b..79df205 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -16,6 +16,8 @@ deployment:
   replicas: 1
   # Amount of time (in seconds) before Kubernetes will send the SIGKILL signal if Traefik does not shut down
   terminationGracePeriodSeconds: 60
+  # The minimum number of seconds Traefik needs to be up and running before the DaemonSet/Deployment controller considers it available
+  minReadySeconds: 0
   # Additional deployment annotations (e.g. for jaeger-operator sidecar injection)
   annotations: {}
   # Additional deployment labels (e.g. for filtering deployment by custom labels)
```

## 10.7.1  ![AppVersion: 2.5.4](https://img.shields.io/static/v1?label=AppVersion&message=2.5.4&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-12-06

* Fix pod disruption when using percentages

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index e0655c8..7e9186b 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -52,13 +52,15 @@ deployment:
   # dnsPolicy: ClusterFirstWithHostNet
   # Additional imagePullSecrets
   imagePullSecrets: []
-   # - name: myRegistryKeySecretName
+    # - name: myRegistryKeySecretName
 
 # Pod disruption budget
 podDisruptionBudget:
   enabled: false
   # maxUnavailable: 1
+  # maxUnavailable: 33%
   # minAvailable: 0
+  # minAvailable: 25%
 
 # Use ingressClass. Ignored if Traefik version < 2.3 / kubernetes < 1.18.x
 ingressClass:
```

## 10.7.0  ![AppVersion: 2.5.4](https://img.shields.io/static/v1?label=AppVersion&message=2.5.4&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-12-06

* Add support for ipFamilyPolicy

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 3ec7105..e0655c8 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -343,8 +343,8 @@ service:
   annotationsUDP: {}
   # Additional service labels (e.g. for filtering Service by custom labels)
   labels: {}
-  # Additional entries here will be added to the service spec. Cannot contains
-  # type, selector or ports entries.
+  # Additional entries here will be added to the service spec.
+  # Cannot contain type, selector or ports entries.
   spec: {}
     # externalTrafficPolicy: Cluster
     # loadBalancerIP: "1.2.3.4"
@@ -354,6 +354,8 @@ service:
     # - 172.16.0.0/16
   externalIPs: []
     # - 1.2.3.4
+  # One of SingleStack, PreferDualStack, or RequireDualStack.
+  # ipFamilyPolicy: SingleStack
 
 ## Create HorizontalPodAutoscaler object.
 ##
```

## 10.6.2  ![AppVersion: 2.5.4](https://img.shields.io/static/v1?label=AppVersion&message=2.5.4&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-11-15

* Bump Traefik version to 2.5.4


## 10.6.1  ![AppVersion: 2.5.3](https://img.shields.io/static/v1?label=AppVersion&message=2.5.3&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-11-05

* Add missing Gateway API resources to ClusterRole


## 10.6.0  ![AppVersion: 2.5.3](https://img.shields.io/static/v1?label=AppVersion&message=2.5.3&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-10-13

* feat: allow termination grace period to be configurable

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index f06ebc6..3ec7105 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -14,6 +14,8 @@ deployment:
   kind: Deployment
   # Number of pods of the deployment (only applies when kind == Deployment)
   replicas: 1
+  # Amount of time (in seconds) before Kubernetes will send the SIGKILL signal if Traefik does not shut down
+  terminationGracePeriodSeconds: 60
   # Additional deployment annotations (e.g. for jaeger-operator sidecar injection)
   annotations: {}
   # Additional deployment labels (e.g. for filtering deployment by custom labels)
```

## 10.5.0  ![AppVersion: 2.5.3](https://img.shields.io/static/v1?label=AppVersion&message=2.5.3&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-10-13

* feat: add allowExternalNameServices to Kubernetes CRD provider

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 3bcb350..f06ebc6 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -109,6 +109,7 @@ providers:
   kubernetesCRD:
     enabled: true
     allowCrossNamespace: false
+    allowExternalNameServices: false
     # ingressClass: traefik-internal
     # labelSelector: environment=production,method=traefik
     namespaces: []
```

## 10.4.2  ![AppVersion: 2.5.3](https://img.shields.io/static/v1?label=AppVersion&message=2.5.3&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-10-13

* fix(crd): add permissionsPolicy to headers middleware


## 10.4.1  ![AppVersion: 2.5.3](https://img.shields.io/static/v1?label=AppVersion&message=2.5.3&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-10-13

* fix(crd): add peerCertURI option to ServersTransport


## 10.4.0  ![AppVersion: 2.5.3](https://img.shields.io/static/v1?label=AppVersion&message=2.5.3&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-10-12

* Add Kubernetes CRD labelSelector and ingressClass options

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index f54f5fe..3bcb350 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -109,8 +109,11 @@ providers:
   kubernetesCRD:
     enabled: true
     allowCrossNamespace: false
+    # ingressClass: traefik-internal
+    # labelSelector: environment=production,method=traefik
     namespaces: []
       # - "default"
+
   kubernetesIngress:
     enabled: true
     # labelSelector: environment=production,method=traefik
```

## 10.3.6  ![AppVersion: 2.5.3](https://img.shields.io/static/v1?label=AppVersion&message=2.5.3&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-09-24

* Fix missing RequireAnyClientCert value to TLSOption CRD


## 10.3.5  ![AppVersion: 2.5.3](https://img.shields.io/static/v1?label=AppVersion&message=2.5.3&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-09-23

* Bump Traefik version to 2.5.3


## 10.3.4  ![AppVersion: 2.5.1](https://img.shields.io/static/v1?label=AppVersion&message=2.5.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-09-17

* Add allowCrossNamespace option on kubernetesCRD provider

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 7e3a579..f54f5fe 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -108,6 +108,7 @@ rollingUpdate:
 providers:
   kubernetesCRD:
     enabled: true
+    allowCrossNamespace: false
     namespaces: []
       # - "default"
   kubernetesIngress:
```

## 10.3.3  ![AppVersion: 2.5.1](https://img.shields.io/static/v1?label=AppVersion&message=2.5.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-09-17

* fix(crd): missing alpnProtocols in TLSOption


## 10.3.2  ![AppVersion: 2.5.1](https://img.shields.io/static/v1?label=AppVersion&message=2.5.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-08-23

* Releasing 2.5.1


## 10.3.1  ![AppVersion: 2.5.0](https://img.shields.io/static/v1?label=AppVersion&message=2.5.0&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-08-20

* Fix Ingress RBAC for namespaced scoped deployment


## 10.3.0  ![AppVersion: 2.5.0](https://img.shields.io/static/v1?label=AppVersion&message=2.5.0&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-08-18

* Releasing Traefik 2.5.0


## 10.2.0  ![AppVersion: 2.4.13](https://img.shields.io/static/v1?label=AppVersion&message=2.4.13&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-08-18

* Allow setting TCP and UDP service annotations separately

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 72a01ea..7e3a579 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -328,8 +328,12 @@ tlsOptions: {}
 service:
   enabled: true
   type: LoadBalancer
-  # Additional annotations (e.g. for cloud provider specific config)
+  # Additional annotations applied to both TCP and UDP services (e.g. for cloud provider specific config)
   annotations: {}
+  # Additional annotations for TCP service only
+  annotationsTCP: {}
+  # Additional annotations for UDP service only
+  annotationsUDP: {}
   # Additional service labels (e.g. for filtering Service by custom labels)
   labels: {}
   # Additional entries here will be added to the service spec. Cannot contains
```

## 10.1.6  ![AppVersion: 2.4.13](https://img.shields.io/static/v1?label=AppVersion&message=2.4.13&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-08-17

* fix: missing service labels


## 10.1.5  ![AppVersion: 2.4.13](https://img.shields.io/static/v1?label=AppVersion&message=2.4.13&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-08-17

* fix(pvc-annotaions): see traefik/traefik-helm-chart#471


## 10.1.4  ![AppVersion: 2.4.13](https://img.shields.io/static/v1?label=AppVersion&message=2.4.13&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-08-17

* fix(ingressclass): fallbackApiVersion default shouldn't be `nil`

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 04d336c..72a01ea 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -64,7 +64,7 @@ ingressClass:
   enabled: false
   isDefaultClass: false
   # Use to force a networking.k8s.io API Version for certain CI/CD applications. E.g. "v1beta1"
-  fallbackApiVersion:
+  fallbackApiVersion: ""
 
 # Activate Pilot integration
 pilot:
```

## 10.1.3  ![AppVersion: 2.4.13](https://img.shields.io/static/v1?label=AppVersion&message=2.4.13&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-08-16

* Move Prometheus annotations to Pods


## 10.1.2  ![AppVersion: 2.4.13](https://img.shields.io/static/v1?label=AppVersion&message=2.4.13&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-08-10

* Version bumped 2.4.13


## 10.1.1  ![AppVersion: 2.4.9](https://img.shields.io/static/v1?label=AppVersion&message=2.4.9&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-07-20

* Fixing Prometheus.io/port annotation


## 10.1.0  ![AppVersion: 2.4.9](https://img.shields.io/static/v1?label=AppVersion&message=2.4.9&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-07-20

* Add metrics framework, and prom annotations

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index f6e370a..04d336c 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -186,6 +186,17 @@ logs:
           # Authorization: drop
           # Content-Type: keep
 
+metrics:
+  # datadog:
+  #   address: 127.0.0.1:8125
+  # influxdb:
+  #   address: localhost:8089
+  #   protocol: udp
+  prometheus:
+    entryPoint: metrics
+  # statsd:
+  #   address: localhost:8125
+
 globalArguments:
   - "--global.checknewversion"
   - "--global.sendanonymoususage"
@@ -284,6 +295,20 @@ ports:
       #   sans:
       #     - foo.example.com
       #     - bar.example.com
+  metrics:
+    port: 9100
+    # hostPort: 9100
+    # Defines whether the port is exposed if service.type is LoadBalancer or
+    # NodePort.
+    #
+    # You may not want to expose the metrics port on production deployments.
+    # If you want to access it from outside of your cluster,
+    # use `kubectl port-forward` or create a secure ingress
+    expose: false
+    # The exposed port for this service
+    exposedPort: 9100
+    # The port protocol (TCP/UDP)
+    protocol: TCP
 
 # TLS Options are created as TLSOption CRDs
 # https://doc.traefik.io/traefik/https/tls/#tls-options
```

## 10.0.2  ![AppVersion: 2.4.9](https://img.shields.io/static/v1?label=AppVersion&message=2.4.9&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-07-14

* feat(gateway): introduces param / pick Namespace installing Gateway

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 9bf90ea..f6e370a 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -84,6 +84,9 @@ experimental:
     # - group: "core"
     #   kind: "Secret"
     #   name: "mysecret"
+    # By default, Gateway would be created to the Namespace you are deploying Traefik to.
+    # You may create that Gateway in another namespace, setting its name below:
+    # namespace: default
 
 # Create an IngressRoute for the dashboard
 ingressRoute:
```

## 10.0.1  ![AppVersion: 2.4.9](https://img.shields.io/static/v1?label=AppVersion&message=2.4.9&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-07-14

* Add RBAC for middlewaretcps


## 10.0.0  ![AppVersion: 2.4.9](https://img.shields.io/static/v1?label=AppVersion&message=2.4.9&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-07-07

* Update CRD versions


## 9.20.1  ![AppVersion: 2.4.8](https://img.shields.io/static/v1?label=AppVersion&message=2.4.8&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-07-05

* Revert CRD templating


## 9.20.0  ![AppVersion: 2.4.8](https://img.shields.io/static/v1?label=AppVersion&message=2.4.8&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-07-05

* Add support for apiextensions v1 CRDs


## 9.19.2  ![AppVersion: 2.4.8](https://img.shields.io/static/v1?label=AppVersion&message=2.4.8&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-06-16

* Add name-metadata for service "List" object


## 9.19.1  ![AppVersion: 2.4.8](https://img.shields.io/static/v1?label=AppVersion&message=2.4.8&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-05-13

* fix simple typo

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index b30afac..9bf90ea 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -363,7 +363,7 @@ rbac:
   # If set to true, installs namespace-specific Role and RoleBinding and requires provider configuration be set to that same namespace
   namespaced: false
 
-# Enable to create a PodSecurityPolicy and assign it to the Service Account via RoleBindin or ClusterRoleBinding
+# Enable to create a PodSecurityPolicy and assign it to the Service Account via RoleBinding or ClusterRoleBinding
 podSecurityPolicy:
   enabled: false
 
```

## 9.19.0  ![AppVersion: 2.4.8](https://img.shields.io/static/v1?label=AppVersion&message=2.4.8&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-04-29

* Fix IngressClass api version

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 0aa2d6b..b30afac 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -63,6 +63,8 @@ ingressClass:
   # true is not unit-testable yet, pending https://github.com/rancher/helm-unittest/pull/12
   enabled: false
   isDefaultClass: false
+  # Use to force a networking.k8s.io API Version for certain CI/CD applications. E.g. "v1beta1"
+  fallbackApiVersion:
 
 # Activate Pilot integration
 pilot:
```

## 9.18.3  ![AppVersion: 2.4.8](https://img.shields.io/static/v1?label=AppVersion&message=2.4.8&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-04-26

* Fix: ignore provider namespace args on disabled


## 9.18.2  ![AppVersion: 2.4.8](https://img.shields.io/static/v1?label=AppVersion&message=2.4.8&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-04-02

* Fix pilot dashboard deactivation


## 9.18.1  ![AppVersion: 2.4.8](https://img.shields.io/static/v1?label=AppVersion&message=2.4.8&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-03-29

* Do not disable Traefik Pilot in the dashboard by default


## 9.18.0  ![AppVersion: 2.4.8](https://img.shields.io/static/v1?label=AppVersion&message=2.4.8&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-03-24

* Add an option to toggle the pilot dashboard

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 017f771..0aa2d6b 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -68,6 +68,8 @@ ingressClass:
 pilot:
   enabled: false
   token: ""
+  # Toggle Pilot Dashboard
+  # dashboard: false
 
 # Enable experimental features
 experimental:
```

## 9.17.6  ![AppVersion: 2.4.8](https://img.shields.io/static/v1?label=AppVersion&message=2.4.8&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-03-24

* Bump Traefik to 2.4.8


## 9.17.5  ![AppVersion: 2.4.7](https://img.shields.io/static/v1?label=AppVersion&message=2.4.7&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-03-17

* feat(labelSelector): option matching Ingresses based on labelSelectors

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 868a985..017f771 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -105,6 +105,7 @@ providers:
       # - "default"
   kubernetesIngress:
     enabled: true
+    # labelSelector: environment=production,method=traefik
     namespaces: []
       # - "default"
     # IP used for Kubernetes Ingress endpoints
```

## 9.17.4  ![AppVersion: 2.4.7](https://img.shields.io/static/v1?label=AppVersion&message=2.4.7&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-03-17

* Add helm resource-policy annotation on PVC


## 9.17.3  ![AppVersion: 2.4.7](https://img.shields.io/static/v1?label=AppVersion&message=2.4.7&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-03-17

* Throw error with explicit latest tag


## 9.17.2  ![AppVersion: 2.4.7](https://img.shields.io/static/v1?label=AppVersion&message=2.4.7&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-03-10

* fix(keywords): removed by mistake


## 9.17.1  ![AppVersion: 2.4.7](https://img.shields.io/static/v1?label=AppVersion&message=2.4.7&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-03-10

* feat(healthchecksPort): Support for overriding the liveness/readiness probes port

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 56abb93..868a985 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -120,6 +120,8 @@ providers:
 # After the volume has been mounted, add the configs into traefik by using the `additionalArguments` list below, eg:
 # additionalArguments:
 # - "--providers.file.filename=/config/dynamic.toml"
+# - "--ping"
+# - "--ping.entrypoint=web"
 volumes: []
 # - name: public-cert
 #   mountPath: "/certs"
@@ -225,6 +227,10 @@ ports:
     # only.
     # hostIP: 192.168.100.10
 
+    # Override the liveness/readiness port. This is useful to integrate traefik
+    # with an external Load Balancer that performs healthchecks.
+    # healthchecksPort: 9000
+
     # Defines whether the port is exposed if service.type is LoadBalancer or
     # NodePort.
     #
```

## 9.16.2  ![AppVersion: 2.4.7](https://img.shields.io/static/v1?label=AppVersion&message=2.4.7&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-03-09

* Bump Traefik to 2.4.7


## 9.16.1  ![AppVersion: 2.4.6](https://img.shields.io/static/v1?label=AppVersion&message=2.4.6&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-03-09

* Adding custom labels to deployment

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index ba24be7..56abb93 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -16,6 +16,8 @@ deployment:
   replicas: 1
   # Additional deployment annotations (e.g. for jaeger-operator sidecar injection)
   annotations: {}
+  # Additional deployment labels (e.g. for filtering deployment by custom labels)
+  labels: {}
   # Additional pod annotations (e.g. for mesh injection or prometheus scraping)
   podAnnotations: {}
   # Additional Pod labels (e.g. for filtering Pod by custom labels)
```

## 9.15.2  ![AppVersion: 2.4.6](https://img.shields.io/static/v1?label=AppVersion&message=2.4.6&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-03-02

* Upgrade Traefik to 2.4.6


## 9.15.1  ![AppVersion: 2.4.5](https://img.shields.io/static/v1?label=AppVersion&message=2.4.5&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-03-02

* Configurable PVC name

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 1e0e5a9..ba24be7 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -327,6 +327,7 @@ autoscaling:
 # It will persist TLS certificates.
 persistence:
   enabled: false
+  name: data
 #  existingClaim: ""
   accessMode: ReadWriteOnce
   size: 128Mi
```

## 9.14.4  ![AppVersion: 2.4.5](https://img.shields.io/static/v1?label=AppVersion&message=2.4.5&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-03-02

* fix typo


## 9.14.3  ![AppVersion: 2.4.5](https://img.shields.io/static/v1?label=AppVersion&message=2.4.5&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-02-19

* Bump Traefik to 2.4.5


## 9.14.2  ![AppVersion: 2.4.2](https://img.shields.io/static/v1?label=AppVersion&message=2.4.2&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-02-03

* docs: indent nit for dsdsocket example

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 56485ad..1e0e5a9 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -33,7 +33,7 @@ deployment:
   additionalVolumes: []
     # - name: dsdsocket
     #   hostPath:
-    #   path: /var/run/statsd-exporter
+    #     path: /var/run/statsd-exporter
   # Additional initContainers (e.g. for setting file permission as shown below)
   initContainers: []
     # The "volume-permissions" init container is required if you run into permission issues.
```

## 9.14.1  ![AppVersion: 2.4.2](https://img.shields.io/static/v1?label=AppVersion&message=2.4.2&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-02-03

* Update Traefik to 2.4.2


## 9.14.0  ![AppVersion: 2.4.0](https://img.shields.io/static/v1?label=AppVersion&message=2.4.0&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-02-01

* Enable Kubernetes Gateway provider with an experimental flag

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 50cab94..56485ad 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -71,6 +71,13 @@ pilot:
 experimental:
   plugins:
     enabled: false
+  kubernetesGateway:
+    enabled: false
+    appLabelSelector: "traefik"
+    certificates: []
+    # - group: "core"
+    #   kind: "Secret"
+    #   name: "mysecret"
 
 # Create an IngressRoute for the dashboard
 ingressRoute:
```

## 9.13.0  ![AppVersion: 2.4.0](https://img.shields.io/static/v1?label=AppVersion&message=2.4.0&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2021-01-22

* Update Traefik to 2.4 and add resources


## 9.12.3  ![AppVersion: 2.3.6](https://img.shields.io/static/v1?label=AppVersion&message=2.3.6&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-12-31

* Revert API Upgrade


## 9.12.2  ![AppVersion: 2.3.6](https://img.shields.io/static/v1?label=AppVersion&message=2.3.6&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-12-31

* Bump Traefik to 2.3.6


## 9.12.1  ![AppVersion: 2.3.3](https://img.shields.io/static/v1?label=AppVersion&message=2.3.3&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-12-30

* Resolve #303, change CRD version from v1beta1 to v1


## 9.12.0  ![AppVersion: 2.3.3](https://img.shields.io/static/v1?label=AppVersion&message=2.3.3&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-12-30

* Implement support for DaemonSet

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 60a721d..50cab94 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -10,7 +10,9 @@ image:
 #
 deployment:
   enabled: true
-  # Number of pods of the deployment
+  # Can be either Deployment or DaemonSet
+  kind: Deployment
+  # Number of pods of the deployment (only applies when kind == Deployment)
   replicas: 1
   # Additional deployment annotations (e.g. for jaeger-operator sidecar injection)
   annotations: {}
```

## 9.11.0  ![AppVersion: 2.3.3](https://img.shields.io/static/v1?label=AppVersion&message=2.3.3&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-11-20

* add podLabels - custom labels

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index a187df7..60a721d 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -16,6 +16,8 @@ deployment:
   annotations: {}
   # Additional pod annotations (e.g. for mesh injection or prometheus scraping)
   podAnnotations: {}
+  # Additional Pod labels (e.g. for filtering Pod by custom labels)
+  podLabels: {}
   # Additional containers (e.g. for metric offloading sidecars)
   additionalContainers: []
     # https://docs.datadoghq.com/developers/dogstatsd/unix_socket/?tab=host
```

## 9.10.2  ![AppVersion: 2.3.3](https://img.shields.io/static/v1?label=AppVersion&message=2.3.3&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-11-20

* Bump Traefik to 2.3.3


## 9.10.1  ![AppVersion: 2.3.1](https://img.shields.io/static/v1?label=AppVersion&message=2.3.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-11-04

* Specify IngressClass resource when checking for cluster capability


## 9.10.0  ![AppVersion: 2.3.1](https://img.shields.io/static/v1?label=AppVersion&message=2.3.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-11-03

* Add list of watched provider namespaces

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index e6b85ca..a187df7 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -88,8 +88,12 @@ rollingUpdate:
 providers:
   kubernetesCRD:
     enabled: true
+    namespaces: []
+      # - "default"
   kubernetesIngress:
     enabled: true
+    namespaces: []
+      # - "default"
     # IP used for Kubernetes Ingress endpoints
     publishedService:
       enabled: false
```

## 9.9.0  ![AppVersion: 2.3.1](https://img.shields.io/static/v1?label=AppVersion&message=2.3.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-11-03

* Add additionalVolumeMounts for traefik container

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 37dd151..e6b85ca 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -111,6 +111,12 @@ volumes: []
 #   mountPath: "/config"
 #   type: configMap
 
+# Additional volumeMounts to add to the Traefik container
+additionalVolumeMounts: []
+  # For instance when using a logshipper for access logs
+  # - name: traefik-logs
+  #   mountPath: /var/log/traefik
+
 # Logs
 # https://docs.traefik.io/observability/logs/
 logs:
```

## 9.8.4  ![AppVersion: 2.3.1](https://img.shields.io/static/v1?label=AppVersion&message=2.3.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-11-03

* fix: multiple ImagePullSecrets


## 9.8.3  ![AppVersion: 2.3.1](https://img.shields.io/static/v1?label=AppVersion&message=2.3.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-10-30

* Add imagePullSecrets

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 87f60c0..37dd151 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -42,6 +42,9 @@ deployment:
     #       mountPath: /data
   # Custom pod DNS policy. Apply if `hostNetwork: true`
   # dnsPolicy: ClusterFirstWithHostNet
+  # Additional imagePullSecrets
+  imagePullSecrets: []
+   # - name: myRegistryKeySecretName
 
 # Pod disruption budget
 podDisruptionBudget:
```

## 9.8.2  ![AppVersion: 2.3.1](https://img.shields.io/static/v1?label=AppVersion&message=2.3.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-10-28

* Add chart repo to source


## 9.8.1  ![AppVersion: 2.3.1](https://img.shields.io/static/v1?label=AppVersion&message=2.3.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-10-23

* fix semver compare

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 4ca1f8f..87f60c0 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -1,7 +1,8 @@
 # Default values for Traefik
 image:
   name: traefik
-  tag: 2.3.1
+  # defaults to appVersion
+  tag: ""
   pullPolicy: IfNotPresent
 
 #
```

## 9.8.0  ![AppVersion: 2.3.1](https://img.shields.io/static/v1?label=AppVersion&message=2.3.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-10-20

* feat: Enable entrypoint tls config + TLSOption

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index eee3622..4ca1f8f 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -231,6 +231,31 @@ ports:
     # The port protocol (TCP/UDP)
     protocol: TCP
     # nodePort: 32443
+    # Set TLS at the entrypoint
+    # https://doc.traefik.io/traefik/routing/entrypoints/#tls
+    tls:
+      enabled: false
+      # this is the name of a TLSOption definition
+      options: ""
+      certResolver: ""
+      domains: []
+      # - main: example.com
+      #   sans:
+      #     - foo.example.com
+      #     - bar.example.com
+
+# TLS Options are created as TLSOption CRDs
+# https://doc.traefik.io/traefik/https/tls/#tls-options
+# Example:
+# tlsOptions:
+#   default:
+#     sniStrict: true
+#     preferServerCipherSuites: true
+#   foobar:
+#     curvePreferences:
+#       - CurveP521
+#       - CurveP384
+tlsOptions: {}
 
 # Options for the main traefik service, where the entrypoints traffic comes
 # from.
```

## 9.7.0  ![AppVersion: 2.3.1](https://img.shields.io/static/v1?label=AppVersion&message=2.3.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-10-15

* Add a configuration option for an emptyDir as plugin storage

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index b7153a1..eee3622 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -54,10 +54,16 @@ ingressClass:
   enabled: false
   isDefaultClass: false
 
+# Activate Pilot integration
 pilot:
   enabled: false
   token: ""
 
+# Enable experimental features
+experimental:
+  plugins:
+    enabled: false
+
 # Create an IngressRoute for the dashboard
 ingressRoute:
   dashboard:
```

## 9.6.0  ![AppVersion: 2.3.1](https://img.shields.io/static/v1?label=AppVersion&message=2.3.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-10-15

* Add additional volumes for init and additional containers

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 9bac45e..b7153a1 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -17,6 +17,18 @@ deployment:
   podAnnotations: {}
   # Additional containers (e.g. for metric offloading sidecars)
   additionalContainers: []
+    # https://docs.datadoghq.com/developers/dogstatsd/unix_socket/?tab=host
+    # - name: socat-proxy
+    # image: alpine/socat:1.0.5
+    # args: ["-s", "-u", "udp-recv:8125", "unix-sendto:/socket/socket"]
+    # volumeMounts:
+    #   - name: dsdsocket
+    #     mountPath: /socket
+  # Additional volumes available for use with initContainers and additionalContainers
+  additionalVolumes: []
+    # - name: dsdsocket
+    #   hostPath:
+    #   path: /var/run/statsd-exporter
   # Additional initContainers (e.g. for setting file permission as shown below)
   initContainers: []
     # The "volume-permissions" init container is required if you run into permission issues.
```

## 9.5.2  ![AppVersion: 2.3.1](https://img.shields.io/static/v1?label=AppVersion&message=2.3.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-10-15

* Replace extensions with policy because of deprecation


## 9.5.1  ![AppVersion: 2.3.1](https://img.shields.io/static/v1?label=AppVersion&message=2.3.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-10-14

* Template custom volume name

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 5a8d8ea..9bac45e 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -76,7 +76,7 @@ providers:
       # pathOverride: ""
 
 #
-# Add volumes to the traefik pod.
+# Add volumes to the traefik pod. The volume name will be passed to tpl.
 # This can be used to mount a cert pair or a configmap that holds a config.toml file.
 # After the volume has been mounted, add the configs into traefik by using the `additionalArguments` list below, eg:
 # additionalArguments:
@@ -85,7 +85,7 @@ volumes: []
 # - name: public-cert
 #   mountPath: "/certs"
 #   type: secret
-# - name: configs
+# - name: '{{ printf "%s-configs" .Release.Name }}'
 #   mountPath: "/config"
 #   type: configMap
 
```

## 9.5.0  ![AppVersion: 2.3.1](https://img.shields.io/static/v1?label=AppVersion&message=2.3.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-10-02

* Create PodSecurityPolicy and RBAC when needed.

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 8c4d866..5a8d8ea 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -281,6 +281,10 @@ rbac:
   # If set to true, installs namespace-specific Role and RoleBinding and requires provider configuration be set to that same namespace
   namespaced: false
 
+# Enable to create a PodSecurityPolicy and assign it to the Service Account via RoleBindin or ClusterRoleBinding
+podSecurityPolicy:
+  enabled: false
+
 # The service account the pods will use to interact with the Kubernetes API
 serviceAccount:
   # If set, an existing service account is used
```

## 9.4.3  ![AppVersion: 2.3.1](https://img.shields.io/static/v1?label=AppVersion&message=2.3.1&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-10-02

* Update traefik to v2.3.1

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 3df75a4..8c4d866 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -1,7 +1,7 @@
 # Default values for Traefik
 image:
   name: traefik
-  tag: 2.3.0
+  tag: 2.3.1
   pullPolicy: IfNotPresent
 
 #
```

## 9.4.2  ![AppVersion: 2.3.0](https://img.shields.io/static/v1?label=AppVersion&message=2.3.0&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-10-02

* Add Artifact Hub repository metadata file


## 9.4.1  ![AppVersion: 2.3.0](https://img.shields.io/static/v1?label=AppVersion&message=2.3.0&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-10-01

* Fix broken chart icon url


## 9.4.0  ![AppVersion: 2.3.0](https://img.shields.io/static/v1?label=AppVersion&message=2.3.0&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-10-01

* Allow to specify custom labels on Service

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index a6175ff..3df75a4 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -221,6 +221,8 @@ service:
   type: LoadBalancer
   # Additional annotations (e.g. for cloud provider specific config)
   annotations: {}
+  # Additional service labels (e.g. for filtering Service by custom labels)
+  labels: {}
   # Additional entries here will be added to the service spec. Cannot contains
   # type, selector or ports entries.
   spec: {}
```

## 9.3.0  ![AppVersion: 2.3.0](https://img.shields.io/static/v1?label=AppVersion&message=2.3.0&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-09-24

* Release Traefik 2.3

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index fba955d..a6175ff 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -1,7 +1,7 @@
 # Default values for Traefik
 image:
   name: traefik
-  tag: 2.2.8
+  tag: 2.3.0
   pullPolicy: IfNotPresent
 
 #
@@ -36,6 +36,16 @@ podDisruptionBudget:
   # maxUnavailable: 1
   # minAvailable: 0
 
+# Use ingressClass. Ignored if Traefik version < 2.3 / kubernetes < 1.18.x
+ingressClass:
+  # true is not unit-testable yet, pending https://github.com/rancher/helm-unittest/pull/12
+  enabled: false
+  isDefaultClass: false
+
+pilot:
+  enabled: false
+  token: ""
+
 # Create an IngressRoute for the dashboard
 ingressRoute:
   dashboard:
```

## 9.2.1  ![AppVersion: 2.2.8](https://img.shields.io/static/v1?label=AppVersion&message=2.2.8&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-09-18

* Add new helm url


## 9.2.0  ![AppVersion: 2.2.8](https://img.shields.io/static/v1?label=AppVersion&message=2.2.8&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-09-16

* chore: move to new organization.

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 9f52c39..fba955d 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -20,7 +20,7 @@ deployment:
   # Additional initContainers (e.g. for setting file permission as shown below)
   initContainers: []
     # The "volume-permissions" init container is required if you run into permission issues.
-    # Related issue: https://github.com/containous/traefik/issues/6972
+    # Related issue: https://github.com/traefik/traefik/issues/6972
     # - name: volume-permissions
     #   image: busybox:1.31.1
     #   command: ["sh", "-c", "chmod -Rv 600 /data/*"]
```

## 9.1.1  ![AppVersion: 2.2.8](https://img.shields.io/static/v1?label=AppVersion&message=2.2.8&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-09-04

* Update reference to using kubectl proxy to kubectl port-forward

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 7b74a39..9f52c39 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -175,7 +175,7 @@ ports:
     #
     # You SHOULD NOT expose the traefik port on production deployments.
     # If you want to access it from outside of your cluster,
-    # use `kubectl proxy` or create a secure ingress
+    # use `kubectl port-forward` or create a secure ingress
     expose: false
     # The exposed port for this service
     exposedPort: 9000
```

## 9.1.0  ![AppVersion: 2.2.8](https://img.shields.io/static/v1?label=AppVersion&message=2.2.8&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-08-24

* PublishedService option

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index e161a14..7b74a39 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -58,6 +58,12 @@ providers:
     enabled: true
   kubernetesIngress:
     enabled: true
+    # IP used for Kubernetes Ingress endpoints
+    publishedService:
+      enabled: false
+      # Published Kubernetes Service to copy status from. Format: namespace/servicename
+      # By default this Traefik service
+      # pathOverride: ""
 
 #
 # Add volumes to the traefik pod.
```

## 9.0.0  ![AppVersion: 2.2.8](https://img.shields.io/static/v1?label=AppVersion&message=2.2.8&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-08-21

* feat: Move Chart apiVersion: v2


## 8.13.3  ![AppVersion: 2.2.8](https://img.shields.io/static/v1?label=AppVersion&message=2.2.8&color=success&logo=) ![Helm: v2](https://img.shields.io/static/v1?label=Helm&message=v2&color=inactive&logo=helm) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-08-21

* bug: Check for port config


## 8.13.2  ![AppVersion: 2.2.8](https://img.shields.io/static/v1?label=AppVersion&message=2.2.8&color=success&logo=) ![Helm: v2](https://img.shields.io/static/v1?label=Helm&message=v2&color=inactive&logo=helm) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-08-19

* Fix log level configuration


## 8.13.1  ![AppVersion: 2.2.8](https://img.shields.io/static/v1?label=AppVersion&message=2.2.8&color=success&logo=) ![Helm: v2](https://img.shields.io/static/v1?label=Helm&message=v2&color=inactive&logo=helm) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-08-18

* Dont redirect to websecure by default

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 67276f7..e161a14 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -188,7 +188,7 @@ ports:
     # Port Redirections
     # Added in 2.2, you can make permanent redirects via entrypoints.
     # https://docs.traefik.io/routing/entrypoints/#redirection
-    redirectTo: websecure
+    # redirectTo: websecure
   websecure:
     port: 8443
     # hostPort: 8443
```

## 8.13.0  ![AppVersion: 2.2.8](https://img.shields.io/static/v1?label=AppVersion&message=2.2.8&color=success&logo=) ![Helm: v2](https://img.shields.io/static/v1?label=Helm&message=v2&color=inactive&logo=helm) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-08-18

* Add logging, and http redirect config

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 6f79580..67276f7 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -73,6 +73,48 @@ volumes: []
 #   mountPath: "/config"
 #   type: configMap
 
+# Logs
+# https://docs.traefik.io/observability/logs/
+logs:
+  # Traefik logs concern everything that happens to Traefik itself (startup, configuration, events, shutdown, and so on).
+  general:
+    # By default, the logs use a text format (common), but you can
+    # also ask for the json format in the format option
+    # format: json
+    # By default, the level is set to ERROR. Alternative logging levels are DEBUG, PANIC, FATAL, ERROR, WARN, and INFO.
+    level: ERROR
+  access:
+    # To enable access logs
+    enabled: false
+    # By default, logs are written using the Common Log Format (CLF).
+    # To write logs in JSON, use json in the format option.
+    # If the given format is unsupported, the default (CLF) is used instead.
+    # format: json
+    # To write the logs in an asynchronous fashion, specify a bufferingSize option.
+    # This option represents the number of log lines Traefik will keep in memory before writing
+    # them to the selected output. In some cases, this option can greatly help performances.
+    # bufferingSize: 100
+    # Filtering https://docs.traefik.io/observability/access-logs/#filtering
+    filters: {}
+      # statuscodes: "200,300-302"
+      # retryattempts: true
+      # minduration: 10ms
+    # Fields
+    # https://docs.traefik.io/observability/access-logs/#limiting-the-fieldsincluding-headers
+    fields:
+      general:
+        defaultmode: keep
+        names: {}
+          # Examples:
+          # ClientUsername: drop
+      headers:
+        defaultmode: drop
+        names: {}
+          # Examples:
+          # User-Agent: redact
+          # Authorization: drop
+          # Content-Type: keep
+
 globalArguments:
   - "--global.checknewversion"
   - "--global.sendanonymoususage"
@@ -143,6 +185,10 @@ ports:
     # Use nodeport if set. This is useful if you have configured Traefik in a
     # LoadBalancer
     # nodePort: 32080
+    # Port Redirections
+    # Added in 2.2, you can make permanent redirects via entrypoints.
+    # https://docs.traefik.io/routing/entrypoints/#redirection
+    redirectTo: websecure
   websecure:
     port: 8443
     # hostPort: 8443
```

## 8.12.0  ![AppVersion: 2.2.8](https://img.shields.io/static/v1?label=AppVersion&message=2.2.8&color=success&logo=) ![Helm: v2](https://img.shields.io/static/v1?label=Helm&message=v2&color=inactive&logo=helm) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-08-14

* Add image pull policy

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 10b3949..6f79580 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -2,6 +2,7 @@
 image:
   name: traefik
   tag: 2.2.8
+  pullPolicy: IfNotPresent
 
 #
 # Configure the deployment
```

## 8.11.0  ![AppVersion: 2.2.8](https://img.shields.io/static/v1?label=AppVersion&message=2.2.8&color=success&logo=) ![Helm: v2](https://img.shields.io/static/v1?label=Helm&message=v2&color=inactive&logo=helm) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-08-12

* Add dns policy option

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 80ddaaa..10b3949 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -26,6 +26,8 @@ deployment:
     #   volumeMounts:
     #     - name: data
     #       mountPath: /data
+  # Custom pod DNS policy. Apply if `hostNetwork: true`
+  # dnsPolicy: ClusterFirstWithHostNet
 
 # Pod disruption budget
 podDisruptionBudget:
```

## 8.10.0  ![AppVersion: 2.2.8](https://img.shields.io/static/v1?label=AppVersion&message=2.2.8&color=success&logo=) ![Helm: v2](https://img.shields.io/static/v1?label=Helm&message=v2&color=inactive&logo=helm) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-08-11

* Add hostIp to port configuration

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 936ab92..80ddaaa 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -112,6 +112,12 @@ ports:
     port: 9000
     # Use hostPort if set.
     # hostPort: 9000
+    #
+    # Use hostIP if set. If not set, Kubernetes will default to 0.0.0.0, which
+    # means it's listening on all your interfaces and all your IPs. You may want
+    # to set this value if you need traefik to listen on specific interface
+    # only.
+    # hostIP: 192.168.100.10
 
     # Defines whether the port is exposed if service.type is LoadBalancer or
     # NodePort.
```

## 8.9.2  ![AppVersion: 2.2.8](https://img.shields.io/static/v1?label=AppVersion&message=2.2.8&color=success&logo=) ![Helm: v2](https://img.shields.io/static/v1?label=Helm&message=v2&color=inactive&logo=helm) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-08-10

* Bump Traefik to 2.2.8

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 42ee893..936ab92 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -1,7 +1,7 @@
 # Default values for Traefik
 image:
   name: traefik
-  tag: 2.2.5
+  tag: 2.2.8
 
 #
 # Configure the deployment
```

## 8.9.1  ![AppVersion: 2.2.5](https://img.shields.io/static/v1?label=AppVersion&message=2.2.5&color=success&logo=) ![Helm: v2](https://img.shields.io/static/v1?label=Helm&message=v2&color=inactive&logo=helm) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-07-15

* Upgrade traefik version

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index a7fb668..42ee893 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -1,7 +1,7 @@
 # Default values for Traefik
 image:
   name: traefik
-  tag: 2.2.1
+  tag: 2.2.5
 
 #
 # Configure the deployment
```

## 8.9.0  ![AppVersion: 2.2.1](https://img.shields.io/static/v1?label=AppVersion&message=2.2.1&color=success&logo=) ![Helm: v2](https://img.shields.io/static/v1?label=Helm&message=v2&color=inactive&logo=helm) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-07-08

* run init container to set proper permissions on volume

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 62e3a77..a7fb668 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -16,6 +16,16 @@ deployment:
   podAnnotations: {}
   # Additional containers (e.g. for metric offloading sidecars)
   additionalContainers: []
+  # Additional initContainers (e.g. for setting file permission as shown below)
+  initContainers: []
+    # The "volume-permissions" init container is required if you run into permission issues.
+    # Related issue: https://github.com/containous/traefik/issues/6972
+    # - name: volume-permissions
+    #   image: busybox:1.31.1
+    #   command: ["sh", "-c", "chmod -Rv 600 /data/*"]
+    #   volumeMounts:
+    #     - name: data
+    #       mountPath: /data
 
 # Pod disruption budget
 podDisruptionBudget:
```

## 8.8.1  ![AppVersion: 2.2.1](https://img.shields.io/static/v1?label=AppVersion&message=2.2.1&color=success&logo=) ![Helm: v2](https://img.shields.io/static/v1?label=Helm&message=v2&color=inactive&logo=helm) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-07-02

* Additional container fix

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 85df29c..62e3a77 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -15,7 +15,7 @@ deployment:
   # Additional pod annotations (e.g. for mesh injection or prometheus scraping)
   podAnnotations: {}
   # Additional containers (e.g. for metric offloading sidecars)
-  additionalContainers: {}
+  additionalContainers: []
 
 # Pod disruption budget
 podDisruptionBudget:
```

## 8.8.0  ![AppVersion: 2.2.1](https://img.shields.io/static/v1?label=AppVersion&message=2.2.1&color=success&logo=) ![Helm: v2](https://img.shields.io/static/v1?label=Helm&message=v2&color=inactive&logo=helm) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-07-01

* added additionalContainers option to chart

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 6a9dfd8..85df29c 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -14,6 +14,8 @@ deployment:
   annotations: {}
   # Additional pod annotations (e.g. for mesh injection or prometheus scraping)
   podAnnotations: {}
+  # Additional containers (e.g. for metric offloading sidecars)
+  additionalContainers: {}
 
 # Pod disruption budget
 podDisruptionBudget:
```

## 8.7.2  ![AppVersion: 2.2.1](https://img.shields.io/static/v1?label=AppVersion&message=2.2.1&color=success&logo=) ![Helm: v2](https://img.shields.io/static/v1?label=Helm&message=v2&color=inactive&logo=helm) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-06-30

* Update image


## 8.7.1  ![AppVersion: 2.2.1](https://img.shields.io/static/v1?label=AppVersion&message=2.2.1&color=success&logo=) ![Helm: v2](https://img.shields.io/static/v1?label=Helm&message=v2&color=inactive&logo=helm) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-06-26

* Update values.yaml

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 05f9eab..6a9dfd8 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -196,7 +196,7 @@ rbac:
   # If set to true, installs namespace-specific Role and RoleBinding and requires provider configuration be set to that same namespace
   namespaced: false
 
-# The service account the pods will use to interact with the Kubernates API
+# The service account the pods will use to interact with the Kubernetes API
 serviceAccount:
   # If set, an existing service account is used
   # If not set, a service account is created automatically using the fullname template
```

## 8.7.0  ![AppVersion: 2.2.1](https://img.shields.io/static/v1?label=AppVersion&message=2.2.1&color=success&logo=) ![Helm: v2](https://img.shields.io/static/v1?label=Helm&message=v2&color=inactive&logo=helm) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-06-23

* Add option to disable providers

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 102ae00..05f9eab 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -34,6 +34,16 @@ rollingUpdate:
   maxUnavailable: 1
   maxSurge: 1
 
+
+#
+# Configure providers
+#
+providers:
+  kubernetesCRD:
+    enabled: true
+  kubernetesIngress:
+    enabled: true
+
 #
 # Add volumes to the traefik pod.
 # This can be used to mount a cert pair or a configmap that holds a config.toml file.
```

## 8.6.1  ![AppVersion: 2.2.1](https://img.shields.io/static/v1?label=AppVersion&message=2.2.1&color=success&logo=) ![Helm: v2](https://img.shields.io/static/v1?label=Helm&message=v2&color=inactive&logo=helm) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-06-18

* Fix read-only /tmp


## 8.6.0  ![AppVersion: 2.2.1](https://img.shields.io/static/v1?label=AppVersion&message=2.2.1&color=success&logo=) ![Helm: v2](https://img.shields.io/static/v1?label=Helm&message=v2&color=inactive&logo=helm) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-06-17

* Add existing PVC support(#158)

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index b2f4fc3..102ae00 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -164,6 +164,7 @@ autoscaling:
 # It will persist TLS certificates.
 persistence:
   enabled: false
+#  existingClaim: ""
   accessMode: ReadWriteOnce
   size: 128Mi
   # storageClass: ""
```

## 8.5.0  ![AppVersion: 2.2.1](https://img.shields.io/static/v1?label=AppVersion&message=2.2.1&color=success&logo=) ![Helm: v2](https://img.shields.io/static/v1?label=Helm&message=v2&color=inactive&logo=helm) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-06-16

* UDP support

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 9a9b668..b2f4fc3 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -100,11 +100,15 @@ ports:
     expose: false
     # The exposed port for this service
     exposedPort: 9000
+    # The port protocol (TCP/UDP)
+    protocol: TCP
   web:
     port: 8000
     # hostPort: 8000
     expose: true
     exposedPort: 80
+    # The port protocol (TCP/UDP)
+    protocol: TCP
     # Use nodeport if set. This is useful if you have configured Traefik in a
     # LoadBalancer
     # nodePort: 32080
@@ -113,6 +117,8 @@ ports:
     # hostPort: 8443
     expose: true
     exposedPort: 443
+    # The port protocol (TCP/UDP)
+    protocol: TCP
     # nodePort: 32443
 
 # Options for the main traefik service, where the entrypoints traffic comes
```

## 8.4.1  ![AppVersion: 2.2.1](https://img.shields.io/static/v1?label=AppVersion&message=2.2.1&color=success&logo=) ![Helm: v2](https://img.shields.io/static/v1?label=Helm&message=v2&color=inactive&logo=helm) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-06-10

* Fix PDB with minAvailable set

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index e812b98..9a9b668 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -18,7 +18,7 @@ deployment:
 # Pod disruption budget
 podDisruptionBudget:
   enabled: false
-  maxUnavailable: 1
+  # maxUnavailable: 1
   # minAvailable: 0
 
 # Create an IngressRoute for the dashboard
```

## 8.4.0  ![AppVersion: 2.2.1](https://img.shields.io/static/v1?label=AppVersion&message=2.2.1&color=success&logo=) ![Helm: v2](https://img.shields.io/static/v1?label=Helm&message=v2&color=inactive&logo=helm) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-06-09

* Add pod disruption budget (#192)

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 5f44e5c..e812b98 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -15,6 +15,12 @@ deployment:
   # Additional pod annotations (e.g. for mesh injection or prometheus scraping)
   podAnnotations: {}
 
+# Pod disruption budget
+podDisruptionBudget:
+  enabled: false
+  maxUnavailable: 1
+  # minAvailable: 0
+
 # Create an IngressRoute for the dashboard
 ingressRoute:
   dashboard:
```

## 8.3.0  ![AppVersion: 2.2.1](https://img.shields.io/static/v1?label=AppVersion&message=2.2.1&color=success&logo=) ![Helm: v2](https://img.shields.io/static/v1?label=Helm&message=v2&color=inactive&logo=helm) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-06-08

* Add option to disable RBAC and ServiceAccount

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 96bba18..5f44e5c 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -165,6 +165,20 @@ persistence:
 # affinity is left as default.
 hostNetwork: false
 
+# Whether Role Based Access Control objects like roles and rolebindings should be created
+rbac:
+  enabled: true
+
+  # If set to false, installs ClusterRole and ClusterRoleBinding so Traefik can be used across namespaces.
+  # If set to true, installs namespace-specific Role and RoleBinding and requires provider configuration be set to that same namespace
+  namespaced: false
+
+# The service account the pods will use to interact with the Kubernates API
+serviceAccount:
+  # If set, an existing service account is used
+  # If not set, a service account is created automatically using the fullname template
+  name: ""
+
 # Additional serviceAccount annotations (e.g. for oidc authentication)
 serviceAccountAnnotations: {}
 
```

## 8.2.1  ![AppVersion: 2.2.1](https://img.shields.io/static/v1?label=AppVersion&message=2.2.1&color=success&logo=) ![Helm: v2](https://img.shields.io/static/v1?label=Helm&message=v2&color=inactive&logo=helm) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-05-25

* Remove suggested providers.kubernetesingress value

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index e35bdf9..96bba18 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -50,9 +50,9 @@ globalArguments:
 # Configure Traefik static configuration
 # Additional arguments to be passed at Traefik's binary
 # All available options available on https://docs.traefik.io/reference/static-configuration/cli/
-## Use curly braces to pass values: `helm install --set="additionalArguments={--providers.kubernetesingress,--log.level=DEBUG}"`
+## Use curly braces to pass values: `helm install --set="additionalArguments={--providers.kubernetesingress.ingressclass=traefik-internal,--log.level=DEBUG}"`
 additionalArguments: []
-#  - "--providers.kubernetesingress"
+#  - "--providers.kubernetesingress.ingressclass=traefik-internal"
 #  - "--log.level=DEBUG"
 
 # Environment variables to be passed to Traefik's binary
```

## 8.2.0  ![AppVersion: 2.2.1](https://img.shields.io/static/v1?label=AppVersion&message=2.2.1&color=success&logo=) ![Helm: v2](https://img.shields.io/static/v1?label=Helm&message=v2&color=inactive&logo=helm) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-05-18

* Add kubernetes ingress by default


## 8.1.5  ![AppVersion: 2.2.1](https://img.shields.io/static/v1?label=AppVersion&message=2.2.1&color=success&logo=) ![Helm: v2](https://img.shields.io/static/v1?label=Helm&message=v2&color=inactive&logo=helm) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-05-18

* Fix example log params in values.yml

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index abe2334..e35bdf9 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -50,10 +50,10 @@ globalArguments:
 # Configure Traefik static configuration
 # Additional arguments to be passed at Traefik's binary
 # All available options available on https://docs.traefik.io/reference/static-configuration/cli/
-## Use curly braces to pass values: `helm install --set="additionalArguments={--providers.kubernetesingress,--logs.level=DEBUG}"`
+## Use curly braces to pass values: `helm install --set="additionalArguments={--providers.kubernetesingress,--log.level=DEBUG}"`
 additionalArguments: []
 #  - "--providers.kubernetesingress"
-#  - "--logs.level=DEBUG"
+#  - "--log.level=DEBUG"
 
 # Environment variables to be passed to Traefik's binary
 env: []
```

## 8.1.4  ![AppVersion: 2.2.1](https://img.shields.io/static/v1?label=AppVersion&message=2.2.1&color=success&logo=) ![Helm: v2](https://img.shields.io/static/v1?label=Helm&message=v2&color=inactive&logo=helm) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-04-30

* Update Traefik to v2.2.1

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 57cc7e1..abe2334 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -1,7 +1,7 @@
 # Default values for Traefik
 image:
   name: traefik
-  tag: 2.2.0
+  tag: 2.2.1
 
 #
 # Configure the deployment
```

## 8.1.3  ![AppVersion: 2.2.0](https://img.shields.io/static/v1?label=AppVersion&message=2.2.0&color=success&logo=) ![Helm: v2](https://img.shields.io/static/v1?label=Helm&message=v2&color=inactive&logo=helm) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-04-29

* Clarify additionnal arguments log

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index d639f72..57cc7e1 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -50,9 +50,10 @@ globalArguments:
 # Configure Traefik static configuration
 # Additional arguments to be passed at Traefik's binary
 # All available options available on https://docs.traefik.io/reference/static-configuration/cli/
-## Use curly braces to pass values: `helm install --set="additionalArguments={--providers.kubernetesingress,--global.checknewversion=true}"`
+## Use curly braces to pass values: `helm install --set="additionalArguments={--providers.kubernetesingress,--logs.level=DEBUG}"`
 additionalArguments: []
 #  - "--providers.kubernetesingress"
+#  - "--logs.level=DEBUG"
 
 # Environment variables to be passed to Traefik's binary
 env: []
```

## 8.1.2  ![AppVersion: 2.2.0](https://img.shields.io/static/v1?label=AppVersion&message=2.2.0&color=success&logo=) ![Helm: v2](https://img.shields.io/static/v1?label=Helm&message=v2&color=inactive&logo=helm) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-04-23

* Remove invalid flags. (#161)

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 0e7aaef..d639f72 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -34,8 +34,6 @@ rollingUpdate:
 # After the volume has been mounted, add the configs into traefik by using the `additionalArguments` list below, eg:
 # additionalArguments:
 # - "--providers.file.filename=/config/dynamic.toml"
-# - "--tls.certificates.certFile=/certs/tls.crt"
-# - "--tls.certificates.keyFile=/certs/tls.key"
 volumes: []
 # - name: public-cert
 #   mountPath: "/certs"
```

## 8.1.1  ![AppVersion: 2.2.0](https://img.shields.io/static/v1?label=AppVersion&message=2.2.0&color=success&logo=) ![Helm: v2](https://img.shields.io/static/v1?label=Helm&message=v2&color=inactive&logo=helm) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-04-23

* clarify project philosophy and guidelines


## 8.1.0  ![AppVersion: 2.2.0](https://img.shields.io/static/v1?label=AppVersion&message=2.2.0&color=success&logo=) ![Helm: v2](https://img.shields.io/static/v1?label=Helm&message=v2&color=inactive&logo=helm) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-04-22

* Add priorityClassName & securityContext

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index d55a40a..0e7aaef 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -191,3 +191,20 @@ affinity: {}
 #       topologyKey: failure-domain.beta.kubernetes.io/zone
 nodeSelector: {}
 tolerations: []
+
+# Pods can have priority.
+# Priority indicates the importance of a Pod relative to other Pods.
+priorityClassName: ""
+
+# Set the container security context
+# To run the container with ports below 1024 this will need to be adjust to run as root
+securityContext:
+  capabilities:
+    drop: [ALL]
+  readOnlyRootFilesystem: true
+  runAsGroup: 65532
+  runAsNonRoot: true
+  runAsUser: 65532
+
+podSecurityContext:
+  fsGroup: 65532
```

## 8.0.4  ![AppVersion: 2.2.0](https://img.shields.io/static/v1?label=AppVersion&message=2.2.0&color=success&logo=) ![Helm: v2](https://img.shields.io/static/v1?label=Helm&message=v2&color=inactive&logo=helm) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-04-20

* Possibility to bind environment variables via envFrom

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 7f8092e..d55a40a 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -71,6 +71,12 @@ env: []
 #       name: secret-name
 #       key: secret-key
 
+envFrom: []
+# - configMapRef:
+#     name: config-map-name
+# - secretRef:
+#     name: secret-name
+
 # Configure ports
 ports:
   # The name of this one can't be changed as it is used for the readiness and
```

## 8.0.3  ![AppVersion: 2.2.0](https://img.shields.io/static/v1?label=AppVersion&message=2.2.0&color=success&logo=) ![Helm: v2](https://img.shields.io/static/v1?label=Helm&message=v2&color=inactive&logo=helm) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-04-15

* Add support for data volume subPath. (#147)

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 152339b..7f8092e 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -152,6 +152,7 @@ persistence:
   # storageClass: ""
   path: /data
   annotations: {}
+  # subPath: "" # only mount a subpath of the Volume into the pod
 
 # If hostNetwork is true, runs traefik in the host network namespace
 # To prevent unschedulabel pods due to port collisions, if hostNetwork=true
```

## 8.0.2  ![AppVersion: 2.2.0](https://img.shields.io/static/v1?label=AppVersion&message=2.2.0&color=success&logo=) ![Helm: v2](https://img.shields.io/static/v1?label=Helm&message=v2&color=inactive&logo=helm) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-04-10

* Ability to add custom labels to dashboard's IngressRoute

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 5d294b7..152339b 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -21,6 +21,8 @@ ingressRoute:
     enabled: true
     # Additional ingressRoute annotations (e.g. for kubernetes.io/ingress.class)
     annotations: {}
+    # Additional ingressRoute labels (e.g. for filtering IngressRoute by custom labels)
+    labels: {}
 
 rollingUpdate:
   maxUnavailable: 1
```

## 8.0.1  ![AppVersion: 2.2.0](https://img.shields.io/static/v1?label=AppVersion&message=2.2.0&color=success&logo=) ![Helm: v2](https://img.shields.io/static/v1?label=Helm&message=v2&color=inactive&logo=helm) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-04-10

* rbac does not need "pods" per documentation


## 8.0.0  ![AppVersion: 2.2.0](https://img.shields.io/static/v1?label=AppVersion&message=2.2.0&color=success&logo=) ![Helm: v2](https://img.shields.io/static/v1?label=Helm&message=v2&color=inactive&logo=helm) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-04-07

* follow helm best practices

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index e61a9fd..5d294b7 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -10,7 +10,7 @@ deployment:
   enabled: true
   # Number of pods of the deployment
   replicas: 1
-  # Addtional deployment annotations (e.g. for jaeger-operator sidecar injection)
+  # Additional deployment annotations (e.g. for jaeger-operator sidecar injection)
   annotations: {}
   # Additional pod annotations (e.g. for mesh injection or prometheus scraping)
   podAnnotations: {}
@@ -19,7 +19,7 @@ deployment:
 ingressRoute:
   dashboard:
     enabled: true
-    # Addtional ingressRoute annotations (e.g. for kubernetes.io/ingress.class)
+    # Additional ingressRoute annotations (e.g. for kubernetes.io/ingress.class)
     annotations: {}
 
 rollingUpdate:
```

## 7.2.1  ![AppVersion: 2.2.0](https://img.shields.io/static/v1?label=AppVersion&message=2.2.0&color=success&logo=) ![Helm: v2](https://img.shields.io/static/v1?label=Helm&message=v2&color=inactive&logo=helm) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-04-07

* add annotations to ingressRoute

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 15d1c25..e61a9fd 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -19,6 +19,8 @@ deployment:
 ingressRoute:
   dashboard:
     enabled: true
+    # Addtional ingressRoute annotations (e.g. for kubernetes.io/ingress.class)
+    annotations: {}
 
 rollingUpdate:
   maxUnavailable: 1
```

## 7.2.0  ![AppVersion: 2.2.0](https://img.shields.io/static/v1?label=AppVersion&message=2.2.0&color=success&logo=) ![Helm: v2](https://img.shields.io/static/v1?label=Helm&message=v2&color=inactive&logo=helm) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-04-03

* Add support for helm 2


## 7.1.0  ![AppVersion: 2.2.0](https://img.shields.io/static/v1?label=AppVersion&message=2.2.0&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-03-31

* Add support for externalIPs

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 6d6d13f..15d1c25 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -116,6 +116,8 @@ service:
   loadBalancerSourceRanges: []
     # - 192.168.0.1/32
     # - 172.16.0.0/16
+  externalIPs: []
+    # - 1.2.3.4
 
 ## Create HorizontalPodAutoscaler object.
 ##
```

## 7.0.0  ![AppVersion: 2.2.0](https://img.shields.io/static/v1?label=AppVersion&message=2.2.0&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-03-27

* Remove secretsEnv value key

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 1ac720d..6d6d13f 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -52,18 +52,20 @@ globalArguments:
 additionalArguments: []
 #  - "--providers.kubernetesingress"
 
-# Secret to be set as environment variables to be passed to Traefik's binary
-secretEnv: []
-  # - name: SOME_VAR
-  #   secretName: my-secret-name
-  #   secretKey: my-secret-key
-
 # Environment variables to be passed to Traefik's binary
 env: []
-  # - name: SOME_VAR
-  #   value: some-var-value
-  # - name: SOME_OTHER_VAR
-  #   value: some-other-var-value
+# - name: SOME_VAR
+#   value: some-var-value
+# - name: SOME_VAR_FROM_CONFIG_MAP
+#   valueFrom:
+#     configMapRef:
+#       name: configmap-name
+#       key: config-key
+# - name: SOME_SECRET
+#   valueFrom:
+#     secretKeyRef:
+#       name: secret-name
+#       key: secret-key
 
 # Configure ports
 ports:
```

## 6.4.0  ![AppVersion: 2.2.0](https://img.shields.io/static/v1?label=AppVersion&message=2.2.0&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-03-27

* Add ability to set serviceAccount annotations

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 85abe42..1ac720d 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -151,6 +151,9 @@ persistence:
 # affinity is left as default.
 hostNetwork: false
 
+# Additional serviceAccount annotations (e.g. for oidc authentication)
+serviceAccountAnnotations: {}
+
 resources: {}
   # requests:
   #   cpu: "100m"
```

## 6.3.0  ![AppVersion: 2.2.0](https://img.shields.io/static/v1?label=AppVersion&message=2.2.0&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-03-27

* hpa

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 2f5d132..85abe42 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -115,6 +115,22 @@ service:
     # - 192.168.0.1/32
     # - 172.16.0.0/16
 
+## Create HorizontalPodAutoscaler object.
+##
+autoscaling:
+  enabled: false
+#   minReplicas: 1
+#   maxReplicas: 10
+#   metrics:
+#   - type: Resource
+#     resource:
+#       name: cpu
+#       targetAverageUtilization: 60
+#   - type: Resource
+#     resource:
+#       name: memory
+#       targetAverageUtilization: 60
+
 # Enable persistence using Persistent Volume Claims
 # ref: http://kubernetes.io/docs/user-guide/persistent-volumes/
 # After the pvc has been mounted, add the configs into traefik by using the `additionalArguments` list below, eg:
```

## 6.2.0  ![AppVersion: 2.2.0](https://img.shields.io/static/v1?label=AppVersion&message=2.2.0&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-03-26

* Update to v2.2 (#96)

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index ebd2fde..2f5d132 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -1,7 +1,7 @@
 # Default values for Traefik
 image:
   name: traefik
-  tag: 2.1.8
+  tag: 2.2.0
 
 #
 # Configure the deployment
```

## 6.1.2  ![AppVersion: 2.1.8](https://img.shields.io/static/v1?label=AppVersion&message=2.1.8&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-03-20

* Upgrade traefik version

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 65c7665..ebd2fde 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -1,7 +1,7 @@
 # Default values for Traefik
 image:
   name: traefik
-  tag: 2.1.4
+  tag: 2.1.8
 
 #
 # Configure the deployment
```

## 6.1.1  ![AppVersion: 2.1.4](https://img.shields.io/static/v1?label=AppVersion&message=2.1.4&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-03-20

* Upgrade traefik version

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 89c7ac1..65c7665 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -1,7 +1,7 @@
 # Default values for Traefik
 image:
   name: traefik
-  tag: 2.1.3
+  tag: 2.1.4
 
 #
 # Configure the deployment
```

## 6.1.0  ![AppVersion: 2.1.3](https://img.shields.io/static/v1?label=AppVersion&message=2.1.3&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-03-20

* Add ability to add annotations to deployment

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 8d66111..89c7ac1 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -10,6 +10,8 @@ deployment:
   enabled: true
   # Number of pods of the deployment
   replicas: 1
+  # Addtional deployment annotations (e.g. for jaeger-operator sidecar injection)
+  annotations: {}
   # Additional pod annotations (e.g. for mesh injection or prometheus scraping)
   podAnnotations: {}
 
```

## 6.0.2  ![AppVersion: 2.1.3](https://img.shields.io/static/v1?label=AppVersion&message=2.1.3&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-03-16

* Correct storage class key name


## 6.0.1  ![AppVersion: 2.1.3](https://img.shields.io/static/v1?label=AppVersion&message=2.1.3&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-03-16

* Change default values of arrays from objects to actual arrays

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 490b2b6..8d66111 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -51,13 +51,13 @@ additionalArguments: []
 #  - "--providers.kubernetesingress"
 
 # Secret to be set as environment variables to be passed to Traefik's binary
-secretEnv: {}
+secretEnv: []
   # - name: SOME_VAR
   #   secretName: my-secret-name
   #   secretKey: my-secret-key
 
 # Environment variables to be passed to Traefik's binary
-env: {}
+env: []
   # - name: SOME_VAR
   #   value: some-var-value
   # - name: SOME_OTHER_VAR
@@ -109,7 +109,7 @@ service:
     # externalTrafficPolicy: Cluster
     # loadBalancerIP: "1.2.3.4"
     # clusterIP: "2.3.4.5"
-  loadBalancerSourceRanges: {}
+  loadBalancerSourceRanges: []
     # - 192.168.0.1/32
     # - 172.16.0.0/16
 
```

## 6.0.0  ![AppVersion: 2.1.3](https://img.shields.io/static/v1?label=AppVersion&message=2.1.3&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-03-15

* Cleanup

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 7aebefe..490b2b6 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -18,15 +18,10 @@ ingressRoute:
   dashboard:
     enabled: true
 
-additional:
-  checkNewVersion: true
-  sendAnonymousUsage: true
-
 rollingUpdate:
   maxUnavailable: 1
   maxSurge: 1
 
-
 #
 # Add volumes to the traefik pod.
 # This can be used to mount a cert pair or a configmap that holds a config.toml file.
@@ -43,9 +38,14 @@ volumes: []
 #   mountPath: "/config"
 #   type: configMap
 
+globalArguments:
+  - "--global.checknewversion"
+  - "--global.sendanonymoususage"
+
 #
-# Configure Traefik entry points
+# Configure Traefik static configuration
 # Additional arguments to be passed at Traefik's binary
+# All available options available on https://docs.traefik.io/reference/static-configuration/cli/
 ## Use curly braces to pass values: `helm install --set="additionalArguments={--providers.kubernetesingress,--global.checknewversion=true}"`
 additionalArguments: []
 #  - "--providers.kubernetesingress"
@@ -63,7 +63,7 @@ env: {}
   # - name: SOME_OTHER_VAR
   #   value: some-other-var-value
 
-#
+# Configure ports
 ports:
   # The name of this one can't be changed as it is used for the readiness and
   # liveness probes, but you can adjust its config to your liking
@@ -94,7 +94,7 @@ ports:
     # hostPort: 8443
     expose: true
     exposedPort: 443
-  # nodePort: 32443
+    # nodePort: 32443
 
 # Options for the main traefik service, where the entrypoints traffic comes
 # from.
@@ -113,9 +113,6 @@ service:
     # - 192.168.0.1/32
     # - 172.16.0.0/16
 
-logs:
-  loglevel: WARN
-
 # Enable persistence using Persistent Volume Claims
 # ref: http://kubernetes.io/docs/user-guide/persistent-volumes/
 # After the pvc has been mounted, add the configs into traefik by using the `additionalArguments` list below, eg:
```

## 5.6.0  ![AppVersion: 2.1.3](https://img.shields.io/static/v1?label=AppVersion&message=2.1.3&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-03-12

* Add field enabled for resources

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 38bb263..7aebefe 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -7,11 +7,17 @@ image:
 # Configure the deployment
 #
 deployment:
+  enabled: true
   # Number of pods of the deployment
   replicas: 1
   # Additional pod annotations (e.g. for mesh injection or prometheus scraping)
   podAnnotations: {}
 
+# Create an IngressRoute for the dashboard
+ingressRoute:
+  dashboard:
+    enabled: true
+
 additional:
   checkNewVersion: true
   sendAnonymousUsage: true
@@ -93,6 +99,7 @@ ports:
 # Options for the main traefik service, where the entrypoints traffic comes
 # from.
 service:
+  enabled: true
   type: LoadBalancer
   # Additional annotations (e.g. for cloud provider specific config)
   annotations: {}
```

## 5.5.0  ![AppVersion: 2.1.3](https://img.shields.io/static/v1?label=AppVersion&message=2.1.3&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-03-12

* expose hostnetwork option

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index ecb2833..38bb263 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -123,6 +123,12 @@ persistence:
   path: /data
   annotations: {}
 
+# If hostNetwork is true, runs traefik in the host network namespace
+# To prevent unschedulabel pods due to port collisions, if hostNetwork=true
+# and replicas>1, a pod anti-affinity is recommended and will be set if the
+# affinity is left as default.
+hostNetwork: false
+
 resources: {}
   # requests:
   #   cpu: "100m"
@@ -131,5 +137,17 @@ resources: {}
   #   cpu: "300m"
   #   memory: "150Mi"
 affinity: {}
+# # This example pod anti-affinity forces the scheduler to put traefik pods
+# # on nodes where no other traefik pods are scheduled.
+# # It should be used when hostNetwork: true to prevent port conflicts
+#   podAntiAffinity:
+#     requiredDuringSchedulingIgnoredDuringExecution:
+#     - labelSelector:
+#         matchExpressions:
+#         - key: app
+#           operator: In
+#           values:
+#           - {{ template "traefik.name" . }}
+#       topologyKey: failure-domain.beta.kubernetes.io/zone
 nodeSelector: {}
 tolerations: []
```

## 5.4.0  ![AppVersion: 2.1.3](https://img.shields.io/static/v1?label=AppVersion&message=2.1.3&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-03-12

* Add support for hostport

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index ec1d619..ecb2833 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -63,6 +63,9 @@ ports:
   # liveness probes, but you can adjust its config to your liking
   traefik:
     port: 9000
+    # Use hostPort if set.
+    # hostPort: 9000
+
     # Defines whether the port is exposed if service.type is LoadBalancer or
     # NodePort.
     #
@@ -74,6 +77,7 @@ ports:
     exposedPort: 9000
   web:
     port: 8000
+    # hostPort: 8000
     expose: true
     exposedPort: 80
     # Use nodeport if set. This is useful if you have configured Traefik in a
@@ -81,6 +85,7 @@ ports:
     # nodePort: 32080
   websecure:
     port: 8443
+    # hostPort: 8443
     expose: true
     exposedPort: 443
   # nodePort: 32443
```

## 5.3.3  ![AppVersion: 2.1.3](https://img.shields.io/static/v1?label=AppVersion&message=2.1.3&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-03-12

* Fix replica check

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 7f31548..ec1d619 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -40,7 +40,7 @@ volumes: []
 #
 # Configure Traefik entry points
 # Additional arguments to be passed at Traefik's binary
-## Use curly braces to pass values: `helm install --set="{--providers.kubernetesingress,--global.checknewversion=true}" ."
+## Use curly braces to pass values: `helm install --set="additionalArguments={--providers.kubernetesingress,--global.checknewversion=true}"`
 additionalArguments: []
 #  - "--providers.kubernetesingress"
 
```

## 5.3.2  ![AppVersion: 2.1.3](https://img.shields.io/static/v1?label=AppVersion&message=2.1.3&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-03-11

* Fixed typo in README


## 5.3.1  ![AppVersion: 2.1.3](https://img.shields.io/static/v1?label=AppVersion&message=2.1.3&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-03-11

* Production ready


## 5.3.0  ![AppVersion: 2.1.3](https://img.shields.io/static/v1?label=AppVersion&message=2.1.3&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-03-11

* Not authorise acme if replica > 1


## 5.2.1  ![AppVersion: 2.1.3](https://img.shields.io/static/v1?label=AppVersion&message=2.1.3&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-03-11

* Fix volume mount


## 5.2.0  ![AppVersion: 2.1.3](https://img.shields.io/static/v1?label=AppVersion&message=2.1.3&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-03-11

* Add secret as env var

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index ccea845..7f31548 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -44,12 +44,18 @@ volumes: []
 additionalArguments: []
 #  - "--providers.kubernetesingress"
 
+# Secret to be set as environment variables to be passed to Traefik's binary
+secretEnv: {}
+  # - name: SOME_VAR
+  #   secretName: my-secret-name
+  #   secretKey: my-secret-key
+
 # Environment variables to be passed to Traefik's binary
 env: {}
-#  - name: SOME_VAR
-#    value: some-var-value
-#  - name: SOME_OTHER_VAR
-#    value: some-other-var-value
+  # - name: SOME_VAR
+  #   value: some-var-value
+  # - name: SOME_OTHER_VAR
+  #   value: some-other-var-value
 
 #
 ports:
```

## 5.1.0  ![AppVersion: 2.1.3](https://img.shields.io/static/v1?label=AppVersion&message=2.1.3&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-03-10

* Enhance security by add loadBalancerSourceRanges to lockdown ip address.

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 78bbee0..ccea845 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -91,6 +91,9 @@ service:
     # externalTrafficPolicy: Cluster
     # loadBalancerIP: "1.2.3.4"
     # clusterIP: "2.3.4.5"
+  loadBalancerSourceRanges: {}
+    # - 192.168.0.1/32
+    # - 172.16.0.0/16
 
 logs:
   loglevel: WARN
```

## 5.0.0  ![AppVersion: 2.1.3](https://img.shields.io/static/v1?label=AppVersion&message=2.1.3&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-03-10

* Expose dashboard by default but only on traefik entrypoint

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index a442fca..78bbee0 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -92,15 +92,6 @@ service:
     # loadBalancerIP: "1.2.3.4"
     # clusterIP: "2.3.4.5"
 
-dashboard:
-  # Enable the dashboard on Traefik
-  enable: true
-
-  # Expose the dashboard and api through an ingress route at /dashboard
-  # and /api This is not secure and SHOULD NOT be enabled on production
-  # deployments
-  ingressRoute: false
-
 logs:
   loglevel: WARN
 
```

## 4.1.3  ![AppVersion: 2.1.3](https://img.shields.io/static/v1?label=AppVersion&message=2.1.3&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-03-10

* Add annotations for PVC (#98)

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 8b2f4db..a442fca 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -116,6 +116,7 @@ persistence:
   size: 128Mi
   # storageClass: ""
   path: /data
+  annotations: {}
 
 resources: {}
   # requests:
```

## 4.1.2  ![AppVersion: 2.1.3](https://img.shields.io/static/v1?label=AppVersion&message=2.1.3&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-03-10

* Added persistent volume support. (#86)

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 2a2554f..8b2f4db 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -103,7 +103,20 @@ dashboard:
 
 logs:
   loglevel: WARN
-#
+
+# Enable persistence using Persistent Volume Claims
+# ref: http://kubernetes.io/docs/user-guide/persistent-volumes/
+# After the pvc has been mounted, add the configs into traefik by using the `additionalArguments` list below, eg:
+# additionalArguments:
+# - "--certificatesresolvers.le.acme.storage=/data/acme.json"
+# It will persist TLS certificates.
+persistence:
+  enabled: false
+  accessMode: ReadWriteOnce
+  size: 128Mi
+  # storageClass: ""
+  path: /data
+
 resources: {}
   # requests:
   #   cpu: "100m"
```

## 4.1.1  ![AppVersion: 2.1.3](https://img.shields.io/static/v1?label=AppVersion&message=2.1.3&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-03-10

* Add values to mount secrets or configmaps as volumes to the traefik pod (#84)

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 5401832..2a2554f 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -20,6 +20,23 @@ rollingUpdate:
   maxUnavailable: 1
   maxSurge: 1
 
+
+#
+# Add volumes to the traefik pod.
+# This can be used to mount a cert pair or a configmap that holds a config.toml file.
+# After the volume has been mounted, add the configs into traefik by using the `additionalArguments` list below, eg:
+# additionalArguments:
+# - "--providers.file.filename=/config/dynamic.toml"
+# - "--tls.certificates.certFile=/certs/tls.crt"
+# - "--tls.certificates.keyFile=/certs/tls.key"
+volumes: []
+# - name: public-cert
+#   mountPath: "/certs"
+#   type: secret
+# - name: configs
+#   mountPath: "/config"
+#   type: configMap
+
 #
 # Configure Traefik entry points
 # Additional arguments to be passed at Traefik's binary
```

## 4.1.0  ![AppVersion: 2.1.3](https://img.shields.io/static/v1?label=AppVersion&message=2.1.3&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-03-10

* Add podAnnotations to the deployment (#83)

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 5eab74b..5401832 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -9,6 +9,8 @@ image:
 deployment:
   # Number of pods of the deployment
   replicas: 1
+  # Additional pod annotations (e.g. for mesh injection or prometheus scraping)
+  podAnnotations: {}
 
 additional:
   checkNewVersion: true
```

## 4.0.0  ![AppVersion: 2.1.3](https://img.shields.io/static/v1?label=AppVersion&message=2.1.3&color=success&logo=) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-03-06

* Migrate to helm v3 (#94)


## 3.5.0  ![AppVersion: 2.1.3](https://img.shields.io/static/v1?label=AppVersion&message=2.1.3&color=success&logo=) ![Helm: v2](https://img.shields.io/static/v1?label=Helm&message=v2&color=inactive&logo=helm) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-02-18

* Publish helm chart (#81)


## 3.4.0  ![AppVersion: 2.1.3](https://img.shields.io/static/v1?label=AppVersion&message=2.1.3&color=success&logo=) ![Helm: v2](https://img.shields.io/static/v1?label=Helm&message=v2&color=inactive&logo=helm) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-02-13

* Enable configuration of global checknewversion and sendanonymoususage (#80)
* fix: tests.
* feat: bump traefik to v2.1.3

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index bcc42f8..5eab74b 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -1,7 +1,7 @@
 # Default values for Traefik
 image:
   name: traefik
-  tag: 2.1.1
+  tag: 2.1.3
 
 #
 # Configure the deployment
@@ -10,6 +10,10 @@ deployment:
   # Number of pods of the deployment
   replicas: 1
 
+additional:
+  checkNewVersion: true
+  sendAnonymousUsage: true
+
 rollingUpdate:
   maxUnavailable: 1
   maxSurge: 1
```

## 3.3.3  ![AppVersion: 2.1.1](https://img.shields.io/static/v1?label=AppVersion&message=2.1.1&color=success&logo=) ![Helm: v2](https://img.shields.io/static/v1?label=Helm&message=v2&color=inactive&logo=helm) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-02-05

* fix: chart version.
* fix: deployment environment variables.


## 3.3.2  ![AppVersion: 2.1.1](https://img.shields.io/static/v1?label=AppVersion&message=2.1.1&color=success&logo=) ![Helm: v2](https://img.shields.io/static/v1?label=Helm&message=v2&color=inactive&logo=helm) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-02-03

* ix: deployment environment variables.


## 3.3.1  ![AppVersion: 2.1.1](https://img.shields.io/static/v1?label=AppVersion&message=2.1.1&color=success&logo=) ![Helm: v2](https://img.shields.io/static/v1?label=Helm&message=v2&color=inactive&logo=helm) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-01-27

* fix: deployment environment variables.


## 3.3.0  ![AppVersion: 2.1.1](https://img.shields.io/static/v1?label=AppVersion&message=2.1.1&color=success&logo=) ![Helm: v2](https://img.shields.io/static/v1?label=Helm&message=v2&color=inactive&logo=helm) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-01-24

* Enable configuration of environment variables in traefik deployment (#71)

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index 4462359..bcc42f8 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -21,6 +21,13 @@ rollingUpdate:
 additionalArguments: []
 #  - "--providers.kubernetesingress"
 
+# Environment variables to be passed to Traefik's binary
+env: {}
+#  - name: SOME_VAR
+#    value: some-var-value
+#  - name: SOME_OTHER_VAR
+#    value: some-other-var-value
+
 #
 ports:
   # The name of this one can't be changed as it is used for the readiness and
```

## 3.2.1  ![AppVersion: 2.1.1](https://img.shields.io/static/v1?label=AppVersion&message=2.1.1&color=success&logo=) ![Helm: v2](https://img.shields.io/static/v1?label=Helm&message=v2&color=inactive&logo=helm) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-01-22

* Add Unit Tests for the chart (#60)


## 3.2.0  ![AppVersion: 2.1.1](https://img.shields.io/static/v1?label=AppVersion&message=2.1.1&color=success&logo=) ![Helm: v2](https://img.shields.io/static/v1?label=Helm&message=v2&color=inactive&logo=helm) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-01-22

* Make NodePort configurable (#67)

### Default value changes

```diff
diff --git a/traefik/values.yaml b/traefik/values.yaml
index b1fe42a..4462359 100644
--- a/traefik/values.yaml
+++ b/traefik/values.yaml
@@ -40,10 +40,14 @@ ports:
     port: 8000
     expose: true
     exposedPort: 80
+    # Use nodeport if set. This is useful if you have configured Traefik in a
+    # LoadBalancer
+    # nodePort: 32080
   websecure:
     port: 8443
     expose: true
     exposedPort: 443
+  # nodePort: 32443
 
 # Options for the main traefik service, where the entrypoints traffic comes
 # from.
```

## 3.1.0  ![AppVersion: 2.1.1](https://img.shields.io/static/v1?label=AppVersion&message=2.1.1&color=success&logo=) ![Helm: v2](https://img.shields.io/static/v1?label=Helm&message=v2&color=inactive&logo=helm) ![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

**Release date:** 2020-01-20

* Switch Chart linting to ct (#59)

### Default value changes

```diff
# Default values for Traefik
image:
  name: traefik
  tag: 2.1.1

#
# Configure the deployment
#
deployment:
  # Number of pods of the deployment
  replicas: 1

rollingUpdate:
  maxUnavailable: 1
  maxSurge: 1

#
# Configure Traefik entry points
# Additional arguments to be passed at Traefik's binary
## Use curly braces to pass values: `helm install --set="{--providers.kubernetesingress,--global.checknewversion=true}" ."
additionalArguments: []
#  - "--providers.kubernetesingress"

#
ports:
  # The name of this one can't be changed as it is used for the readiness and
  # liveness probes, but you can adjust its config to your liking
  traefik:
    port: 9000
    # Defines whether the port is exposed if service.type is LoadBalancer or
    # NodePort.
    #
    # You SHOULD NOT expose the traefik port on production deployments.
    # If you want to access it from outside of your cluster,
    # use `kubectl proxy` or create a secure ingress
    expose: false
    # The exposed port for this service
    exposedPort: 9000
  web:
    port: 8000
    expose: true
    exposedPort: 80
  websecure:
    port: 8443
    expose: true
    exposedPort: 443

# Options for the main traefik service, where the entrypoints traffic comes
# from.
service:
  type: LoadBalancer
  # Additional annotations (e.g. for cloud provider specific config)
  annotations: {}
  # Additional entries here will be added to the service spec. Cannot contains
  # type, selector or ports entries.
  spec: {}
    # externalTrafficPolicy: Cluster
    # loadBalancerIP: "1.2.3.4"
    # clusterIP: "2.3.4.5"

dashboard:
  # Enable the dashboard on Traefik
  enable: true

  # Expose the dashboard and api through an ingress route at /dashboard
  # and /api This is not secure and SHOULD NOT be enabled on production
  # deployments
  ingressRoute: false

logs:
  loglevel: WARN
#
resources: {}
  # requests:
  #   cpu: "100m"
  #   memory: "50Mi"
  # limits:
  #   cpu: "300m"
  #   memory: "150Mi"
affinity: {}
nodeSelector: {}
tolerations: []
```

---
Autogenerated from Helm Chart and git history using [helm-changelog](https://github.com/mogensen/helm-changelog)
