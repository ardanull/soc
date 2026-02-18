#!/usr/bin/env bash
set -euo pipefail

WAZUH_MANAGER="${WAZUH_MANAGER:-wazuh.manager}"
WAZUH_AGENT_GROUP="${WAZUH_AGENT_GROUP:-web-nginx}"

sed -i "s#<address>MANAGER_IP</address>#<address>${WAZUH_MANAGER}</address>#g" /var/ossec/etc/ossec.conf || true

/var/ossec/bin/wazuh-control stop >/dev/null 2>&1 || true

if [ -n "${WAZUH_AGENT_GROUP}" ]; then
  sed -i "s#<config-profile>.*</config-profile>#<config-profile>${WAZUH_AGENT_GROUP}</config-profile>#g" /var/ossec/etc/ossec.conf || true
fi

service rsyslog start || true
service nginx start || true
/var/ossec/bin/wazuh-control start

tail -F /var/log/nginx/access.log /var/log/nginx/error.log /var/ossec/logs/ossec.log
