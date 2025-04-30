#!/bin/sh

OUTFILE="/var/log/speedtest_log.json"

# Check if speedtest CLI is installed
if ! command -v speedtest >/dev/null 2>&1; then
  echo "Speedtest CLI not found, installing..."
  cd /tmp || exit 1
  fetch https://install.speedtest.net/app/cli/ookla-speedtest-1.2.0-freebsd13-x86_64.pkg
  export IGNORE_OSVERSION=yes
  pkg add --force ookla-speedtest-1.2.0-freebsd13-x86_64.pkg
fi

# Initialize the log file if it doesn't exist
if [ ! -f "$OUTFILE" ]; then
  echo "[]" > "$OUTFILE"
fi

# Run speedtest and append to JSON log
RESULT=$(speedtest --accept-license --accept-gdpr -f json)
if [ $? -eq 0 ]; then
  echo "$RESULT" | jq -s 'input + .' "$OUTFILE" > "$OUTFILE.tmp" && mv "$OUTFILE.tmp" "$OUTFILE"
fi
