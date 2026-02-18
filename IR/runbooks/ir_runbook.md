# IR Runbook — SOC-in-a-Box

## 1) Triage
- Alarm kimden geldi
- Etkilenen varlık
- Zaman aralığı
- Kaynak IP ve hedef servis
- Aynı kaynaktan başka alarmlar var mı

## 2) Containment
SSH brute force:
- Kaynak IP'yi firewall ile blokla
- Etkilenen kullanıcı için parola reset
- SSH için fail2ban benzeri rate limit uygula

Web exploit attempt:
- WAF/Reverse proxy ile imza bazlı blok
- Şüpheli IP blokla
- Uygulama loglarında 5xx artışı var mı kontrol et

## 3) Eradication
- Zayıf parolaları kaldır
- SSH parola yerine anahtar doğrulama
- Web uygulamasında input validation ve patch

## 4) Recovery
- Servis sağlık kontrolü
- Yeni kural/alert tuning
- Baseline trafik ölçümü

## 5) Lessons Learned
- Root cause
- Detection gap
- Playbook güncellemeleri
