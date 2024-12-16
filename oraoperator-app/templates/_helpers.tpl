{{/*
Expand the name of the chart.
*/}}
{{- define "oraoperator.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "oraoperator.fullname" -}}
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
{{- define "oraoperator.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "oraoperator.labels" -}}
helm.sh/chart: {{ include "oraoperator.chart" . }}
{{ include "oraoperator.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "oraoperator.selectorLabels" -}}
app.kubernetes.io/name: {{ include "oraoperator.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "oraoperator.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "oraoperator.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Database name helper
*/}}
{{- define "oraoperator.dbname" -}}
{{- default (printf "%s-db" (include "oraoperator.fullname" .)) .Values.database.name }}
{{- end }}

{{/*
ORDS name helper
*/}}
{{- define "oraoperator.ordsname" -}}
{{- default (printf "%s-ords" (include "oraoperator.fullname" .)) .Values.ords.name }}
{{- end }}
