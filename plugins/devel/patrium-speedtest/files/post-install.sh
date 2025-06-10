#!/bin/sh
#
# Post-install script for Patrium-Speedtest plugin:
# Fetch & install Ookla Speedtest CLI if missing

SPEEDTEST_PKG="ookla-speedtest-1.2.0-freebsd13-x86_64.pkg"
SPEEDTEST_URL="https://install.speedtest.net/app/cli/${SPEEDTEST_PKG}"

if ! command -v speedtest >/dev/null 2>&1; then
    echo "→ Installing Ookla Speedtest CLI..."
    fetch "${SPEEDTEST_URL}"
    setenv IGNORE_OSVERSION yes
    pkg add --force "${SPEEDTEST_PKG}"
    rm -f "${SPEEDTEST_PKG}"
else
    echo "→ Ookla Speedtest CLI already installed."
fi

exit 0
