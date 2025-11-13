{{- define "colorbot.env" }}
- name: TELEGRAM_BOT_TOKEN
  valueFrom:
    secretKeyRef:
      name: colorbot-secret
      key: telegram_bot_token
      optional: false
- name: COLORBOT_SECRET
  valueFrom:
    secretKeyRef:
      name: colorbot-secret
      key: colorbot_secret
      optional: false
- name: OWNER_IDS
  valueFrom:
    secretKeyRef:
      name: colorbot-secret
      key: owner_ids
      optional: false
- name: DATABASE_URL
  valueFrom:
    secretKeyRef:
      name: colorbot-secret
      key: database_url
      optional: false
- name: DEFAULT_LANG
  valueFrom:
    secretKeyRef:
      name: colorbot-secret
      key: default_lang
      optional: false
- name: LOG_LEVEL
  valueFrom:
    secretKeyRef:
      name: colorbot-secret
      key: log_level
      optional: false
- name: LOG_FORMAT
  valueFrom:
    secretKeyRef:
      name: colorbot-secret
      key: log_format
      optional: false
- name: DEBUG
  valueFrom:
    secretKeyRef:
      name: colorbot-secret
      key: debug
      optional: false
{{- end }}
