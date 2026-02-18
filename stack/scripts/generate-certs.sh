#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
CERTS_DIR="${ROOT_DIR}/stack/certs"

mkdir -p "${CERTS_DIR}/indexer" "${CERTS_DIR}/manager" "${CERTS_DIR}/dashboard"

openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 -nodes \
  -subj "/C=US/ST=CA/L=California/O=Wazuh/OU=Wazuh/CN=root-ca" \
  -keyout "${CERTS_DIR}/root-ca.key" \
  -out "${CERTS_DIR}/root-ca.pem"

openssl req -newkey rsa:4096 -nodes \
  -subj "/C=US/ST=CA/L=California/O=Wazuh/OU=Wazuh/CN=admin" \
  -keyout "${CERTS_DIR}/admin.key" \
  -out "${CERTS_DIR}/admin.csr"

openssl x509 -req -in "${CERTS_DIR}/admin.csr" -CA "${CERTS_DIR}/root-ca.pem" -CAkey "${CERTS_DIR}/root-ca.key" -CAcreateserial \
  -out "${CERTS_DIR}/admin.pem" -days 3650 -sha256

openssl req -newkey rsa:4096 -nodes \
  -subj "/C=US/ST=CA/L=California/O=Wazuh/OU=Wazuh/CN=wazuh.indexer" \
  -keyout "${CERTS_DIR}/indexer/indexer.key" \
  -out "${CERTS_DIR}/indexer/indexer.csr"

openssl x509 -req -in "${CERTS_DIR}/indexer/indexer.csr" -CA "${CERTS_DIR}/root-ca.pem" -CAkey "${CERTS_DIR}/root-ca.key" -CAcreateserial \
  -out "${CERTS_DIR}/indexer/indexer.pem" -days 3650 -sha256

cp "${CERTS_DIR}/root-ca.pem" "${CERTS_DIR}/indexer/root-ca.pem"

openssl req -newkey rsa:4096 -nodes \
  -subj "/C=US/ST=CA/L=California/O=Wazuh/OU=Wazuh/CN=filebeat" \
  -keyout "${CERTS_DIR}/manager/filebeat.key" \
  -out "${CERTS_DIR}/manager/filebeat.csr"

openssl x509 -req -in "${CERTS_DIR}/manager/filebeat.csr" -CA "${CERTS_DIR}/root-ca.pem" -CAkey "${CERTS_DIR}/root-ca.key" -CAcreateserial \
  -out "${CERTS_DIR}/manager/filebeat.pem" -days 3650 -sha256

cp "${CERTS_DIR}/root-ca.pem" "${CERTS_DIR}/manager/root-ca.pem"

openssl req -newkey rsa:4096 -nodes \
  -subj "/C=US/ST=CA/L=California/O=Wazuh/OU=Wazuh/CN=wazuh.dashboard" \
  -keyout "${CERTS_DIR}/dashboard/dashboard.key" \
  -out "${CERTS_DIR}/dashboard/dashboard.csr"

openssl x509 -req -in "${CERTS_DIR}/dashboard/dashboard.csr" -CA "${CERTS_DIR}/root-ca.pem" -CAkey "${CERTS_DIR}/root-ca.key" -CAcreateserial \
  -out "${CERTS_DIR}/dashboard/dashboard.pem" -days 3650 -sha256

cp "${CERTS_DIR}/root-ca.pem" "${CERTS_DIR}/dashboard/root-ca.pem"
cp "${CERTS_DIR}/admin.pem" "${CERTS_DIR}/dashboard/admin.pem"
cp "${CERTS_DIR}/admin.key" "${CERTS_DIR}/dashboard/admin.key"

chmod 600 "${CERTS_DIR}/root-ca.key" "${CERTS_DIR}/admin.key" "${CERTS_DIR}/indexer/indexer.key" "${CERTS_DIR}/manager/filebeat.key" "${CERTS_DIR}/dashboard/dashboard.key"
