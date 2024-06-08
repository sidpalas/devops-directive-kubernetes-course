{{- define "traefik.service-internal-metadata" }}
  labels:
  {{- include "traefik.labels" . | nindent 4 -}}
  {{- with .Values.service.internal.labels }}
  {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end }}

{{- define "traefik.service-internal-spec" -}}
  {{- $type := default "ClusterIP" .Values.service.internal.type }}
  type: {{ $type }}
  {{- with .Values.service.internal.spec }}
  {{- toYaml . | nindent 2 }}
  {{- end }}
  selector:
    {{- include "traefik.labelselector" . | nindent 4 }}
  {{- if eq $type "LoadBalancer" }}
  {{- with .Values.service.internal.loadBalancerSourceRanges }}
  loadBalancerSourceRanges:
  {{- toYaml . | nindent 2 }}
  {{- end -}}
  {{- end -}}
  {{- with .Values.service.internal.externalIPs }}
  externalIPs:
  {{- toYaml . | nindent 2 }}
  {{- end -}}
  {{- with .Values.service.internal.ipFamilyPolicy }}
  ipFamilyPolicy: {{ . }}
  {{- end }}
  {{- with .Values.service.internal.ipFamilies }}
  ipFamilies:
  {{- toYaml . | nindent 2 }}
  {{- end -}}
{{- end }}

{{- define "traefik.service-internal-ports" }}
  {{- range $name, $config := . }}
  {{- if $config.expose }}
  - port: {{ default $config.port $config.exposedPort }}
    name: {{ $name | quote }}
    targetPort: {{ $name }}
    protocol: {{ default "TCP" $config.protocol }}
    {{- if $config.nodePort }}
    nodePort: {{ $config.nodePort }}
    {{- end }}
  {{- end }}
  {{- end }}
{{- end }}
