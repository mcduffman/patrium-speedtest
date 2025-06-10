#!/bin/sh
OUTFILE="/var/log/speedtest_log.json"
if ! command -v speedtest >/dev/null 2>&1; then
  echo "Speedtest CLI not found, installing..."
  cd /tmp || exit 1
  fetch https://install.speedtest.net/app/cli/ookla-speedtest-1.2.0-freebsd13-x86_64.pkg
  export IGNORE_OSVERSION=yes
  pkg add --force ookla-speedtest-1.2.0-freebsd13-x86_64.pkg
fi
[ ! -f "$OUTFILE" ] && echo "[]" > "$OUTFILE"
RESULT=$(speedtest --accept-license --accept-gdpr -f json)
if [ $? -eq 0 ]; then
  echo "$RESULT" | jq -s '.[0] + [.[1]]' "$OUTFILE" - > "$OUTFILE.tmp" && mv "$OUTFILE.tmp" "$OUTFILE"
fi
