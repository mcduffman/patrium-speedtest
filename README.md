# Patrium-Speedtest Plugin for OPNsense

## Overview
Patrium-Speedtest is a plugin for OPNsense that integrates the Ookla Speedtest CLI to run internet speed tests directly from your firewall and visualize results.

## Prerequisites
- OPNsense 25.x build environment checked out to a ROOTDIR (e.g., `/tmp/opnsense`)
- Internet access to fetch the Speedtest CLI and plugin sources
- FreeBSD package management installed on target firewall

## Getting the Source
Clone the plugin source from GitHub into your OPNsense plugin directory:
```sh
cd /tmp/opnsense/plugins/devel
git clone https://github.com/mcduffman/Patrium-Speedtest.git patrium-speedtest
```

## Directory Layout
```
/tmp/opnsense
├── plugins
│   └── devel
│       └── patrium-speedtest
│           ├── Makefile
│           ├── files
│           │   └── post-install.sh
│           ├── src/...
│           └── service/...
```

## Building the Plugin
1. Update OPNsense tools:
    ```sh
    cd /tmp/opnsense/tools
    env ROOTDIR=/tmp/opnsense make update
    ```
2. Build the plugin package:
    ```sh
    env ROOTDIR=/tmp/opnsense make -C /tmp/opnsense/tools plugins
    ```
   The resulting `os-patrium-speedtest-1.0.txz` will be in `/tmp/opnsense/var/.../firmware/plugins`.

## Installing on an OPNsense Firewall
1. Copy the package to your firewall:
    ```sh
    scp /tmp/opnsense/var/.../os-patrium-speedtest-1.0.txz root@firewall:/tmp
    ```
2. On the firewall, install the package:
    ```sh
    pkg add /tmp/os-patrium-speedtest-1.0.txz
    configctl pkg update
    ```
3. Enable the plugin in the GUI under **System → Firmware → Plugins**.

## Usage
- **Dashboard Widget**: Add the Speedtest widget to your dashboard, configure to show latest or averages.
- **Run Manually**: In **Diagnostics → Speedtest**, click “Run Speedtest”.
- **Scheduled Tests**: Enable scheduled tests in **System → Settings → Speedtest**, set interval and units. The plugin will install a cron job automatically.

## API Endpoints
- GET `/api/speedtest/settings/get`
- POST `/api/speedtest/settings/set`
- POST `/api/speedtest/service/test`

Example:
```sh
curl -k -H "Authorization: Bearer <token>" https://<firewall>/api/speedtest/service/test
```

## License
MIT
