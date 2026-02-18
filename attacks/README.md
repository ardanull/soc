Bu klasör saldırı simülasyonları içerir.

python3 -m venv .venv
source .venv/bin/activate
pip install -r attacks/requirements.txt

python3 attacks/ssh_bruteforce.py --host 127.0.0.1 --port 2222 --user victim --wordlist attacks/wordlists/ssh_passwords.txt --attempts 60 --delay-ms 50
bash attacks/web_probe.sh http://127.0.0.1:8080
