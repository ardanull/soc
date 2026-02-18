# Mimari

Bileşenler:
- Wazuh manager: analiz, kural motoru, API
- Wazuh indexer: OpenSearch tabanlı indeksleme
- Wazuh dashboard: görselleştirme
- target.ssh: SSH servisi + Wazuh agent
- target.web: Nginx + Wazuh agent

Trafik akışı:
- Agentlar UDP 1514 ile manager'a event gönderir
- Manager Filebeat ile indexer'a iletir
- Dashboard indexer ve manager API ile konuşur
