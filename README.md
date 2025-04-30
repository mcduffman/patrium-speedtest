# patrIum-speedtest

**Plugin for [OPNsense](https://opnsense.org)** that integrates the Ookla Speedtest CLI and provides:
- Scheduled speed tests
- Configurable dashboard widget (average over week/month/year or latest)
- GUI configuration options
- Installable via OPNsense's plugin system

## 🧰 Features

- Uses [Ookla Speedtest CLI](https://www.speedtest.net/apps/cli)
- Results stored in JSON for visualization
- Widget supports automatic averages or last test timestamp
- Cron-compatible for scheduled testing
- GUI toggle for enabling/disabling schedule
- ACL, Menu, Forms, and Dashboard integrated

## 🔧 Installation

Follow the [OPNsense plugin guide](https://docs.opnsense.org/development/examples/helloworld.html#create-an-installable-plugin):

```sh
# Inside OPNsense build system:
cd /usr/plugins/net-mgmt
git clone https://github.com/mcduffman/opnsense-speedtest.git patrIum-speedtest
cd patrIum-speedtest
make install
```

## 📦 Manual Speedtest CLI Setup (if needed)

If not installed automatically, run:
```sh
fetch https://install.speedtest.net/app/cli/ookla-speedtest-1.2.0-freebsd13-x86_64.pkg
setenv IGNORE_OSVERSION yes
pkg add --force ookla-speedtest-1.2.0-freebsd13-x86_64.pkg
```

## 📋 License

MIT License
