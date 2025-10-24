# CloudShell

> **The easiest way to share a secure, ready-to-use Linux network shell in the cloud for network diagnostics.**
> Powered by Ubuntu and Docker · Streamlined for network diagnostics



------

## 🚀 About

**NetProbe CloudShell** is a cloud-friendly, Docker-based Ubuntu 24.04 environment designed for **network diagnostics, education, remote demos, and ops collaboration**.
 Just launch the container and instantly access a Linux shell in your browser via `ttyd`—no local setup or signup needed!

- **Instant, browser-based terminal** — Secure `ttyd` web shell, shareable with a link.
- **Curated toolset** — Preinstalled network utilities: ping, traceroute, whois, mtr, netcat, curl, etc.
- **Safe sandbox** — Auto-cleans user data, no persistent history, no risky commands.
- **Minimal, beautiful MOTD** — Clear onboarding for new users.
- **Permission locked-down** — Dangerous commands removed for safety; user access only to core network tools.

------

## 🛠️ Preinstalled Tools

| Tool         | Purpose                        |
| ------------ | ------------------------------ |
| `ping`       | Network connectivity check     |
| `traceroute` | Route tracing                  |
| `mtr`        | Route & packet loss stats      |
| `curl`       | HTTP/HTTPS requests            |
| `dnsutils`   | DNS lookup (`dig`, `nslookup`) |
| `whois`      | Domain/IP information          |
| `netcat`     | Port scanning, listeners       |

*All commands run as the `user` account (no sudo). History is wiped on logout and after 300s of inactivity. Sessions are disposable and safe!*

------

## 🐳 Getting Started

1. **Build the image**

   ```
   docker build -t netprobe-cloudshell .
   ```

2. **Run the container**

   ```
   docker run -d --rm \
     --read-only \
     --tmpfs /tmp:exec,nosuid,size=128m \
     --memory=256m \
     --pids-limit 128 \
     -p 7681:7681 \
     netprobe-cloudshell
   
   # Then open http://localhost:7681 in your browser
   ```

------

## 🔒 Security Highlights

- All user data auto-cleared on logout and every hour (via cron)
- No `sudo`, root, or privilege escalation possible
- Sensitive system utilities removed
- Short 300s session timeout for idle users
