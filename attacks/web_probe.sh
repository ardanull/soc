#!/usr/bin/env bash
set -euo pipefail

BASE="${1:-http://127.0.0.1:8080}"

curl -sS "${BASE}/" >/dev/null || true

curl -sS "${BASE}/?id=1%20UNION%20SELECT%201,2,3" >/dev/null || true
curl -sS "${BASE}/?q=%27%20OR%201%3D1--" >/dev/null || true
curl -sS "${BASE}/?file=../../../../etc/passwd" >/dev/null || true
curl -sS "${BASE}/?cmd=powershell%20-enc%20ZQBjAGgAbwAgAGgAaQ==" >/dev/null || true

echo "done"
