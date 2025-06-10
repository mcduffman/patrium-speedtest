# Patrium-Speedtest

A plugin for running Ookla Speedtest CLI from OPNsense.

---

## Prerequisites

1. An OPNsense build environment with `tools` checked out under your ROOTDIR (e.g. `/tmp/opnsense`)  
2. Internet access from the build and from the target firewall.

## Directory layout

Your plugin lives here in your build root:

```sh
/tmp/opnsense/plugins/devel/patrium-speedtest
```

## Automatic CLI installation

On `pkg install os-patrium-speedtest`, the included `post-install.sh` will check for the `speedtest` binary and, if missing, will:

\`\`\`sh
fetch https://install.speedtest.net/app/cli/ookla-speedtest-1.2.0-freebsd13-x86_64.pkg
setenv IGNORE_OSVERSION yes
pkg add --force ookla-speedtest-1.2.0-freebsd13-x86_64.pkg
\`\`\`

You can update the version string in \`files/post-install.sh\` whenever a new CLI is released.

## Building the plugin

1. **Clone the repo**  
   \`\`\`sh
   mkdir -p /tmp/opnsense/plugins/devel
   cd /tmp/opnsense/plugins/devel
   git clone https://github.com/yourname/Patrium-Speedtest.git patrium-speedtest
   \`\`\`

2. **Update OPNsense tools**  
   \`\`\`sh
   cd /tmp/opnsense/tools
   make update
   \`\`\`

3. **Build all plugins**  
   \`\`\`sh
   env ROOTDIR=/tmp/opnsense make -C /tmp/opnsense/tools plugins
   \`\`\`  
   The package \`os-patrium-speedtest-1.0.txz\` will land in your build output.

## Installing on your firewall

\`\`\`sh
scp os-patrium-speedtest-1.0.txz root@firewall:/tmp
ssh root@firewall
pkg add /tmp/os-patrium-speedtest-1.0.txz
configctl pkg update
\`\`\`

Because of the \`post-install.sh\`, Speedtest CLI will be pulled in automatically if needed. Then enable the plugin under **System → Firmware → Plugins**.

## Usage

- **GUI**: Diagnostics → Speedtest → Run Speedtest  
- **CLI**:  
  \`\`\`sh
  configctl speedtest test
  \`\`\`

Results show on-screen and log to \`/var/log/speedtest.log\`.

## API

\`\`\`sh
# Get settings
curl -k -H "Authorization: Bearer <token>" https://<fw>/api/speedtest/settings/get

# Trigger test
curl -k -X POST -H "Authorization: Bearer <token>" https://<fw>/api/speedtest/service/test
\`\`\`

## License

MIT
