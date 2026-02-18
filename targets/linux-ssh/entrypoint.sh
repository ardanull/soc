#!/usr/bin/env bash
set -euo pipefail

TARGET_USER="${TARGET_USER:-victim}"
TARGET_PASS="${TARGET_PASS:-Winter2026!}"
WAZUH_MANAGER="${WAZUH_MANAGER:-wazuh.manager}"
WAZUH_AGENT_GROUP="${WAZUH_AGENT_GROUP:-linux-ssh}"

if ! id -u "${TARGET_USER}" >/dev/null 2>&1; then
  useradd -m -s /bin/bash "${TARGET_USER}"
fi
echo "${TARGET_USER}:${TARGET_PASS}" | chpasswd

sed -i "s#<address>MANAGER_IP</address>#<address>${WAZUH_MANAGER}</address>#g" /var/ossec/etc/ossec.conf || true

grep -q "<client>" /var/ossec/etc/ossec.conf || true

/var/ossec/bin/wazuh-control stop >/dev/null 2>&1 || true

if [ -n "${WAZUH_AGENT_GROUP}" ]; then
  sed -i "s#<config-profile>.*</config-profile>#<config-profile>${WAZUH_AGENT_GROUP}</config-profile>#g" /var/ossec/etc/ossec.conf || true
fi

service rsyslog start || true
service ssh start || true
/var/ossec/bin/wazuh-control start

tail -F /var/log/auth.log /var/ossec/logs/ossec.log
