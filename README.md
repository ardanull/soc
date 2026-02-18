# SOC-in-a-Box (İleri) — Purple Team Lab

Bu proje, Docker Compose ile tek makinede çalışan bir Wazuh tabanlı XDR+SIEM kurulumu ve iki hedef sistem (SSH ve Web) üzerinde saldırı simülasyonları, tespit kuralları ve IR playbook içerir.

## Gereksinimler
- Docker Engine
- Docker Compose v2
- En az 8 GB RAM önerilir (12 GB+ daha rahat)

## Kurulum
1) Dizine gir:
   cd soc-in-a-box-advanced

2) Sertifikaları üret:
   ./stack/scripts/generate-certs.sh

3) Stack'i kaldır:
   docker compose up -d

4) Dashboard:
   http://localhost:5601

Varsayılan kullanıcı/parola:
- admin / admin

## Hedef Servisler
- SSH hedef: localhost:2222
- Web hedef: http://localhost:8080

## Saldırı Simülasyonları
1) SSH brute force (güvenli demo):
   python3 attacks/ssh_bruteforce.py --host 127.0.0.1 --port 2222 --user victim --wordlist attacks/wordlists/ssh_passwords.txt --attempts 60 --delay-ms 50

2) Web saldırı probe (SQLi/LFI imzaları):
   bash attacks/web_probe.sh http://127.0.0.1:8080

## Beklenen Alarmlar
Wazuh içinde “Rules / Alerts” kısmında aşağıdaki başlıklara benzer alarmlar görmelisin:
- SOCBOX: SSH brute force (multiple failures)
- SOCBOX: Web exploit attempt pattern

## Agentlar
Hedef konteynerlerde Wazuh agent hazır gelir ve manager'a bağlanır. Agent listesi Dashboard'da görünür.

## IR (Olay Müdahalesi)
IR/runbooks klasöründe triage, containment, eradication ve recovery adımları vardır.

## Kaldırma
docker compose down -v

## Lisans
MIT
