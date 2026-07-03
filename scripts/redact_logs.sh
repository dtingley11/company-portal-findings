#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 2 ]]; then
  echo "usage: $0 <input-log> <output-log>" >&2
  exit 2
fi

input="$1"
output="$2"

sed -E \
  -e 's/DeviceId=[A-Za-z0-9._:-]+/DeviceId=<redacted>/g' \
  -e 's/DeviceName=[^&[:space:]]+/DeviceName=<redacted>/g' \
  -e 's/identity [^,[:space:]]+/identity <redacted>/g' \
  -e 's/Identity: '\''[^'\'']+'\''/Identity: '\''<redacted>'\''/g' \
  -e 's/RefreshToken: TEXT/RefreshToken: TEXT <schema-only>/g' \
  -e 's/nonce=%7B[^&]+%7D/nonce=<redacted>/g' \
  -e 's/activity id: \{[^}]+\}/activity id: <redacted>/g' \
  "$input" > "$output"

