{{/*
Expand the name of the chart.
*/}}
{{- define "colorbot.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified php name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "colorbot.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "colorbot.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "colorbot.labels" -}}
helm.sh/chart: {{ include "colorbot.chart" . }}
{{ include "colorbot.selectorLabels" . }}
{{- if .Values.app.image.tag }}
app.kubernetes.io/version: {{ .Values.app.image.tag | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}

{{- define "colorbot.selectorLabels" -}}
app.kubernetes.io/name: {{ include "colorbot.name" . }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "colorbot.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "colorbot.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "colorbot.image" -}}
{{- if and .Values.global .Values.global.imagePrivateRegistry }}
{{- printf "%s/%s:%s" .Values.global.imagePrivateRegistry .Values.app.image.repository .Values.app.image.tag | quote }}
{{- else if .Values.image.registry }}
{{- printf "%s/%s:%s" .Values.app.image.registry .Values.app.image.repository .Values.app.image.tag | quote }}
{{- else }}
{{- printf "%s:%s" .Values.app.image.repository .Values.app.image.tag | quote }}
{{- end }}
{{- end }}
