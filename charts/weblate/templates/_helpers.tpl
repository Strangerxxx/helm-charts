{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "weblate.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "weblate.postgresql.fullname" -}}
{{- printf "%s-%s" .Release.Name "postgresql" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "weblate.redis.fullname" -}}
{{- printf "%s-%s" .Release.Name "redis" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "weblate.fullname" -}}
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
Set postgres host
*/}}
{{- define "weblate.postgresql.host" -}}
{{- if .Values.postgresql.enabled -}}
{{- template "weblate.postgresql.fullname" . -}}
{{- else -}}
{{- .Values.postgresql.postgresHost | quote -}}
{{- end -}}
{{- end -}}

{{/*
Set postgres secret
*/}}
{{- define "weblate.postgresql.secret" -}}
{{- if .Values.postgresql.enabled -}}
{{- template "weblate.postgresql.fullname" . -}}
{{- else -}}
{{- template "fullname" . -}}
{{- end -}}
{{- end -}}

{{/*
Set postgres port
*/}}
{{- define "weblate.postgresql.port" -}}
{{- if .Values.postgresql.enabled -}}
{{- default "5432" .Values.postgresql.service.port | quote -}}
{{- else -}}
{{- default "5432" .Values.postgresql.postgresPort | quote -}}
{{- end -}}
{{- end -}}

{{/*
Set redis host
*/}}
{{- define "weblate.redis.host" -}}
{{- if .Values.redis.enabled -}}
{{ template "weblate.redis.fullname" . }}-master
{{- else -}}
{{- .Values.redis.redisHost | quote -}}
{{- end -}}
{{- end -}}

{{/*
Set redis port
*/}}
{{- define "weblate.redis.port" -}}
{{- if .Values.redis.enabled -}}
{{- default "6379" .Values.redis.master.service.port | quote -}}
{{- else -}}
{{- default "6379" .Values.redis.redisPort | quote -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "weblate.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
