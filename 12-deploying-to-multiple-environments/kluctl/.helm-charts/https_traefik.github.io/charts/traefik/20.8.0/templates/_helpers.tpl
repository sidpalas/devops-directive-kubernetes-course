{{/* vim: set filetype=mustache: */}}

{{/*
Expand the name of the chart.
*/}}
{{- define "traefik.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "traefik.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create the chart image name.
*/}}

{{- define "traefik.image-name" -}}
{{- printf "%s:%s" .Values.image.name (.Values.image.tag | default .Chart.AppVersion) }}
{{- end -}}
{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "traefik.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Allow customization of the instance label value.
*/}}
{{- define "traefik.instance-name" -}}
{{- default (printf "%s-%s" .Release.Name .Release.Namespace) .Values.instanceLabelOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Shared labels used for selector*/}}
{{/* This is an immutable field: this should not change between upgrade */}}
{{- define "traefik.labelselector" -}}
app.kubernetes.io/name: {{ template "traefik.name" . }}
app.kubernetes.io/instance: {{ template "traefik.instance-name" . }}
{{- end }}

{{/* Shared labels used in metada */}}
{{- define "traefik.labels" -}}
{{ include "traefik.labelselector" . }}
helm.sh/chart: {{ template "traefik.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Construct the namespace for all namespaced resources
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
Preserve the default behavior of the Release namespace if no override is provided
*/}}
{{- define "traefik.namespace" -}}
{{- if .Values.namespaceOverride -}}
{{- .Values.namespaceOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- .Release.Namespace -}}
{{- end -}}
{{- end -}}

{{/*
The name of the service account to use
*/}}
{{- define "traefik.serviceAccountName" -}}
{{- default (include "traefik.fullname" .) .Values.serviceAccount.name -}}
{{- end -}}

{{/*
The name of the ClusterRole and ClusterRoleBinding to use.
Adds the namespace to name to prevent duplicate resource names when there
are multiple namespaced releases with the same release name.
*/}}
{{- define "traefik.clusterRoleName" -}}
{{- (printf "%s-%s" (include "traefik.fullname" .) .Release.Namespace) | trunc 63 | trimSuffix "-" }}
{{- end -}}

{{/*
Construct the path for the providers.kubernetesingress.ingressendpoint.publishedservice.
By convention this will simply use the <namespace>/<service-name> to match the name of the
service generated.
Users can provide an override for an explicit service they want bound via `.Values.providers.kubernetesIngress.publishedService.pathOverride`
*/}}
{{- define "providers.kubernetesIngress.publishedServicePath" -}}
{{- $defServiceName := printf "%s/%s" .Release.Namespace (include "traefik.fullname" .) -}}
{{- $servicePath := default $defServiceName .Values.providers.kubernetesIngress.publishedService.pathOverride }}
{{- print $servicePath | trimSuffix "-" -}}
{{- end -}}

{{/*
Construct a comma-separated list of whitelisted namespaces
*/}}
{{- define "providers.kubernetesIngress.namespaces" -}}
{{- default .Release.Namespace (join "," .Values.providers.kubernetesIngress.namespaces) }}
{{- end -}}
{{- define "providers.kubernetesCRD.namespaces" -}}
{{- default .Release.Namespace (join "," .Values.providers.kubernetesCRD.namespaces) }}
{{- end -}}

{{/*
Renders a complete tree, even values that contains template.
*/}}
{{- define "traefik.render" -}}
  {{- if typeIs "string" .value }}
    {{- tpl .value .context }}
  {{ else }}
    {{- tpl (.value | toYaml) .context }}
  {{- end }}
{{- end -}}
