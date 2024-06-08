{{- define "traefik.service-metadata" }}
  labels:
  {{- include "traefik.labels" . | nindent 4 -}}
  {{- with .Values.service.labels }}
  {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end }}

{{- define "traefik.service-spec" -}}
  {{- $type := default "LoadBalancer" .Values.service.type }}
  type: {{ $type }}
  {{- with .Values.service.spec }}
  {{- toYaml . | nindent 2 }}
  {{- end }}
  selector:
    {{- include "traefik.labelselector" . | nindent 4 }}
  {{- if eq $type "LoadBalancer" }}
  {{- with .Values.service.loadBalancerSourceRanges }}
  loadBalancerSourceRanges:
  {{- toYaml . | nindent 2 }}
  {{- end -}}
  {{- end -}}
  {{- with .Values.service.externalIPs }}
  externalIPs:
  {{- toYaml . | nindent 2 }}
  {{- end -}}
  {{- with .Values.service.ipFamilyPolicy }}
  ipFamilyPolicy: {{ . }}
  {{- end }}
  {{- with .Values.service.ipFamilies }}
  ipFamilies:
  {{- toYaml . | nindent 2 }}
  {{- end -}}
{{- end }}

{{- define "traefik.service-ports" }}
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
  {{- if $config.http3 }}
  {{- if $config.http3.enabled }}
  {{- $http3Port := default $config.exposedPort $config.http3.advertisedPort }}
  - port: {{ $http3Port }}
    name: "{{ $name }}-http3"
    targetPort: {{ $config.port }}
    protocol: UDP
    {{- if $config.nodePort }}
    nodePort: {{ $config.nodePort }}
    {{- end }}
  {{- end }}
  {{- end }}
  {{- end }}
{{- end }}
