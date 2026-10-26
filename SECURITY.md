# Security Policy & Execution Guidelines

## Overview

This repository provides automation, operations, maintenance, and provisioning scripts. Because many of these scripts interact with root-level utilities (`sudo`, `systemctl`, `ufw`, `iptables`, Docker daemon, kernel parameters), maintaining strict security hygiene is critical.

---

## 🔒 Execution Best Practices

### 1. Always Review Before Running
Never pipe remote or unreviewed scripts directly into an elevated shell without inspection:
```bash
# Recommended practice: Inspect before executing
curl -fsSL https://raw.githubusercontent.com/coder7475/scripts/main/bootstrap/wsl_start.sh -o bootstrap.sh
less bootstrap.sh
bash bootstrap.sh
```

### 2. Privilege Escalation Discipline
- Run scripts as an unprivileged user wherever possible.
- Scripts requiring elevated privileges use `sudo` internally on specific commands rather than expecting the entire script to be invoked as `root`.
- Do not execute scripts with `sudo su` or direct `root` login unless explicitly documented for bare-metal bootstrapping.

### 3. Secret & Credential Management
- **Never commit credentials**: Avoid hardcoding API keys, SSH private keys, database passwords, or auth tokens in scripts or configuration files.
- **Use `.env` files with git exclusion**: Store secrets in local `.env` files matching `.env.example` templates.
- **Rotate leaked secrets immediately**: If a secret is inadvertently committed or logged, invalidate and rotate it immediately.

### 4. Network & Firewall Safety
- Review firewall modifications (`security/ufw_setup.sh`, `cloud/aws/ec2-user-data/docker_compose_ufw.sh`) before running on production servers to prevent locking out management ports (e.g., SSH on port 22).

---

## 🛡️ Reporting a Vulnerability

If you discover a security vulnerability or sensitive credential exposure in any script within this repository:

1. **Do not open a public issue.**
2. Send a security advisory report to: **robiulhossain7475@gmail.com**
3. Include:
   - Specific script file and line number
   - Nature of the vulnerability or risk
   - Steps to reproduce or proof of concept
   - Suggested remediation (if available)

We will review reports promptly and take necessary corrective action.
