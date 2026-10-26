# DevOps, SysAdmin & Automation Engineering Toolkit

[![Shell: Bash](https://img.shields.io/badge/Shell-Bash%205%2B-4EAA25?logo=gnu-bash&logoColor=white)](#)
[![Python: 3.9+](https://img.shields.io/badge/Python-3.9%2B-3776AB?logo=python&logoColor=white)](#)
[![Platform: Linux / WSL2](https://img.shields.io/badge/Platform-Ubuntu%20%7C%20Debian%20%7C%20WSL2-E95420?logo=ubuntu&logoColor=white)](#)
[![IaC: Terraform & Ansible](https://img.shields.io/badge/IaC-Terraform%20%7C%20Ansible-844FBA?logo=terraform&logoColor=white)](#)
[![Containers: Docker](https://img.shields.io/badge/Containers-Docker-2496ED?logo=docker&logoColor=white)](#)
[![Reverse Proxy: Nginx](https://img.shields.io/badge/Reverse%20Proxy-Nginx-009639?logo=nginx&logoColor=white)](#)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](#)

A production-grade, domain-driven collection of shell scripts, Python automation utilities, Ansible playbooks, and systems administration tools designed for cloud infrastructure provisioning, server observability, performance tuning, and developer onboarding.

---

## 📑 Table of Contents

- [Overview & Architecture](#-overview--architecture)
- [Quick Start](#-quick-start)
- [Domain Index & Directory Catalog](#-domain-index--directory-catalog)
  - [1. Bootstrap & Provisioning](#1-bootstrap--provisioning)
  - [2. System Administration & Diagnostics](#2-system-administration--diagnostics)
  - [3. Docker & Container Runtimes](#3-docker--container-runtimes)
  - [4. Web Servers & Process Managers](#4-web-servers--process-managers)
  - [5. Security & Firewalls](#5-security--firewalls)
  - [6. Package & Toolchain Installers](#6-package--toolchain-installers)
  - [7. Cloud & Infrastructure as Code (AWS & Ansible)](#7-cloud--infrastructure-as-code-aws--ansible)
  - [8. Linux Networking & Virtual Labs](#8-linux-networking--virtual-labs)
  - [9. Observability & Performance Monitoring](#9-observability--performance-monitoring)
  - [10. Automation, AI & Web Scraping](#10-automation-ai--web-scraping)
  - [11. Development & Code Utilities](#11-development--code-utilities)
  - [12. Reference & Bash Exercises](#12-reference--bash-exercises)
- [Key Operational Workflows](#-key-operational-workflows)
- [Engineering Standards & Coding Guidelines](#-engineering-standards--coding-guidelines)
- [Security Guidelines](#-security-guidelines)
- [License](#-license)

---

## 🏛️ Overview & Architecture

This repository is structured following strict **domain-driven engineering principles**. Scripts are decoupled by responsibility rather than arbitrary grouping or chronological order.

```text
scripts/
├── bootstrap/             # Host onboarding & workstation provisioning
├── system/                # OS diagnostics, maintenance, processes, and identity
│   ├── diagnostics/       # Hardware, kernel, user, and latency auditing
│   ├── maintenance/       # Automated cache flushing, package updates & vacuums
│   ├── process/           # Safe targeted and batch process termination
│   └── config/            # Unprivileged service accounts & hostname management
├── docker/                # Container daemon setup, slim binaries, and nuclear pruning
├── web-servers/           # Reverse proxies, HTTP daemons, and application managers
│   ├── nginx/             # Hardened configs, rate limiting, and auth generation
│   └── pm2/               # Node.js production cluster configs & host monitoring
├── security/              # Host firewalling (UFW) and Let's Encrypt SSL/TLS
├── packages/              # Automated installers for runtimes and CLI toolchains
│   ├── node/              # NVM, Node.js (20/22 LTS), and Corepack PNPM
│   ├── git/               # Git PPA, branch cleanup, Lazygit TUI, and identity setup
│   ├── terraform/         # HashiCorp release detection and binary installation
│   └── ansible/           # Official Ansible PPA deployment
├── cloud/                 # Cloud automation & orchestration
│   ├── aws/               # AWS EC2 cloud-init user-data templates
│   └── ansible/           # Ad-hoc runners, playbooks (Redis), and inventory control
├── networking/            # Linux network namespaces, virtual switching, and raw packets
├── monitoring/            # Telemetry, load testing, and metric collection
│   ├── prometheus/        # Standalone Prometheus server installer & user config
│   ├── netdata/           # Real-time infrastructure agent lifecycle
│   ├── load-testing/      # Multi-core CPU stress generator
│   └── ml/                # MLflow tracking server orchestrator
├── automation/            # Specialized task automation and document AI
│   ├── ocr/               # Mistral AI PDF OCR pipeline
│   ├── web-scraping/      # Selenium dynamic scraping & automated PDF downloaders
│   └── scaffolding/       # Node.js / Express architectural scaffolders (Bash & Python)
├── development/           # Language toolchains, compiler wrappers, and sandbox demos
│   ├── cpp/               # C++ competitive programming template generator & runner
│   └── demos/             # Shell environment scope and file existence patterns
└── reference/             # Educational resources & developer cheatsheets
    ├── cheatsheets/       # Terminal shortcuts, history navigation, and expansions
    └── bash-exercises/    # 23 progressive hands-on Bash exercises
```

---

## 🚀 Quick Start

### 1. Provision a New Linux / WSL2 Development Workstation
Bootstrap Git credentials, SSH keys, NVM, Node.js 22, PNPM, Docker CE, OpenCode, and essential build utilities with a single command:

```bash
# Clone and execute locally:
git clone https://github.com/coder7475/scripts.git
cd scripts
chmod +x bootstrap/wsl_start.sh
./bootstrap/wsl_start.sh
```

*(Direct execution entry point for remote setup)*:
```bash
curl -fsSL https://raw.githubusercontent.com/coder7475/scripts/main/wsl_start.sh | bash
```

### 2. Stand up a Hardened Production Web Node
Installs Git, Node.js LTS, Nginx, PM2 with boot persistence, UFW firewalling (SSH, HTTP/HTTPS), Certbot, and Fail2ban:

```bash
sudo ./bootstrap/full_web_stack.sh
```

---

## 📦 Domain Index & Directory Catalog

### 1. Bootstrap & Provisioning

High-impact machine provisioning routines for developer workstations, production web servers, and graphical desktop environments.

| Script | Path | Description |
| :--- | :--- | :--- |
| `wsl_start.sh` | [bootstrap/wsl_start.sh](file:///home/fahad/scripts/bootstrap/wsl_start.sh) | Full-featured WSL2 / Ubuntu bootstrap (Git, SSH, NVM, Node 22, PNPM, Docker, build tools). |
| `full_web_stack.sh` | [bootstrap/full_web_stack.sh](file:///home/fahad/scripts/bootstrap/full_web_stack.sh) | End-to-end web server stack setup (Node.js, Nginx, PM2, UFW, Certbot, Fail2ban). |
| `wayland_desktop.sh` | [bootstrap/wayland_desktop.sh](file:///home/fahad/scripts/bootstrap/wayland_desktop.sh) | Installs Wayland, Weston compositor, and GNOME Wayland desktop session packages. |

---

### 2. System Administration & Diagnostics

Core operating system operational tasks divided into diagnostics, maintenance, process control, and configuration.

#### Diagnostics (`system/diagnostics/`)
| Script | Path | Description |
| :--- | :--- | :--- |
| `server_check.sh` | [system/diagnostics/server_check.sh](file:///home/fahad/scripts/system/diagnostics/server_check.sh) | Deep inspection of kernel, hardware, DMI, logged-in users, network interfaces, and installed packages. |
| `server_stats.sh` | [system/diagnostics/server_stats.sh](file:///home/fahad/scripts/system/diagnostics/server_stats.sh) | Live CPU, memory percentage, and storage capacity metric calculator. |
| `os_kernel_info.sh` | [system/diagnostics/os_kernel_info.sh](file:///home/fahad/scripts/system/diagnostics/os_kernel_info.sh) | Quick audit of OS release metadata, kernel architecture, hostname, and uptime. |
| `logged_in_users.sh`| [system/diagnostics/logged_in_users.sh](file:///home/fahad/scripts/system/diagnostics/logged_in_users.sh) | Identifies currently active sessions, last-login stamps, and accounts with interactive shells. |
| `path_analysis.sh` | [system/diagnostics/path_analysis.sh](file:///home/fahad/scripts/system/diagnostics/path_analysis.sh) | Analyzes `$PATH`, counts directories, and prints clean newline-delimited entries. |

#### Maintenance (`system/maintenance/`)
| Script | Path | Description |
| :--- | :--- | :--- |
| `cleanup.sh` | [system/maintenance/cleanup.sh](file:///home/fahad/scripts/system/maintenance/cleanup.sh) | Interactive disk cleaner: vacua journalctl logs, purges APT cache, prunes npm/pnpm caches, and cleans Docker. |
| `system_update.sh` | [system/maintenance/system_update.sh](file:///home/fahad/scripts/system/maintenance/system_update.sh) | Automated APT repository sync, distribution upgrade, and unneeded dependency purging with status checks. |
| `drop_cache.sh` | [system/maintenance/drop_cache.sh](file:///home/fahad/scripts/system/maintenance/drop_cache.sh) | Flushes Linux kernel PageCache, dentries, and inodes via `/proc/sys/vm/drop_caches`. |

#### Process Management (`system/process/`)
| Script | Path | Description |
| :--- | :--- | :--- |
| `kill_by_name.sh` | [system/process/kill_by_name.sh](file:///home/fahad/scripts/system/process/kill_by_name.sh) | Finds all PIDs matching a process string, shows metadata, and prompts before sending `SIGKILL`. |
| `kill_node_apps.sh` | [system/process/kill_node_apps.sh](file:///home/fahad/scripts/system/process/kill_node_apps.sh) | Discovers all active Node.js processes and terminates them upon user confirmation. |

#### Identity & Configuration (`system/config/`)
| Script | Path | Description |
| :--- | :--- | :--- |
| `set_hostname.sh` | [system/config/set_hostname.sh](file:///home/fahad/scripts/system/config/set_hostname.sh) | Configures static system hostname using `hostnamectl` with validation. |
| `create_sys_user.sh` | [system/config/create_sys_user.sh](file:///home/fahad/scripts/system/config/create_sys_user.sh) | Provisions an isolated `/usr/sbin/nologin` service account and dedicated `/opt/<app>` directory. |

---

### 3. Docker & Container Runtimes

Lifecycle management for Docker CE, image minification with DockerSlim, and safe pruning routines.

| Script | Path | Description |
| :--- | :--- | :--- |
| `setup_apt_repo.sh` | [docker/setup_apt_repo.sh](file:///home/fahad/scripts/docker/setup_apt_repo.sh) | Imports official Docker GPG key and configures the apt repository source. |
| `install_docker.sh` | [docker/install_docker.sh](file:///home/fahad/scripts/docker/install_docker.sh) | Installs `docker-ce`, `docker-ce-cli`, `containerd.io`, and `docker-compose-plugin`. |
| `install_slim.sh` | [docker/install_slim.sh](file:///home/fahad/scripts/docker/install_slim.sh) | Downloads and installs the latest DockerSlim / SlimToolkit binary to `/usr/local/bin`. |
| `prune_unused.sh` | [docker/prune_unused.sh](file:///home/fahad/scripts/docker/prune_unused.sh) | Prunes stopped containers, dangling images, and unused networks without touching named volumes. |
| `prune_all_images.sh`| [docker/prune_all_images.sh](file:///home/fahad/scripts/docker/prune_all_images.sh) | Force-removes all stored Docker container images (`docker rmi -f`). |
| `docker_clean_all.sh`| [docker/docker_clean_all.sh](file:///home/fahad/scripts/docker/docker_clean_all.sh) | Full Docker reset: removes all containers, networks, volumes, and cached image layers. |
| `uninstall_docker.sh`| [docker/uninstall_docker.sh](file:///home/fahad/scripts/docker/uninstall_docker.sh) | Completely purges Docker engine packages and configuration directories. |

---

### 4. Web Servers & Process Managers

Hardened web ingress, reverse proxy templates, and background daemon clustering.

#### Nginx (`web-servers/nginx/`)
| Script / Config | Path | Description |
| :--- | :--- | :--- |
| `nginx.conf` | [web-servers/nginx/nginx.conf](file:///home/fahad/scripts/web-servers/nginx/nginx.conf) | Optimized Nginx core configuration (event tuning, gzip, buffer sizes). |
| `reverse_proxy.conf`| [web-servers/nginx/reverse_proxy.conf](file:///home/fahad/scripts/web-servers/nginx/reverse_proxy.conf) | Production reverse proxy: WebSocket support, security headers, rate-limiting, and SSL stubs. |
| `install_nginx.sh` | [web-servers/nginx/install_nginx.sh](file:///home/fahad/scripts/web-servers/nginx/install_nginx.sh) | Installs Nginx via apt and verifies service daemon status. |
| `reload_nginx.sh` | [web-servers/nginx/reload_nginx.sh](file:///home/fahad/scripts/web-servers/nginx/reload_nginx.sh) | Validates syntax with `nginx -t` before issuing a zero-downtime `systemctl reload`. |
| `create_auth.sh` | [web-servers/nginx/create_auth.sh](file:///home/fahad/scripts/web-servers/nginx/create_auth.sh) | Generates SHA-512 password hashes using `openssl passwd -6` for HTTP Basic Auth. |

#### PM2 Runtime (`web-servers/pm2/`)
| Script / Config | Path | Description |
| :--- | :--- | :--- |
| `ecosystem.config.cjs`| [web-servers/pm2/ecosystem.config.cjs](file:///home/fahad/scripts/web-servers/pm2/ecosystem.config.cjs) | PM2 cluster configuration with automated restarts, max memory thresholds, and logging. |
| `setup_pm2.sh` | [web-servers/pm2/setup_pm2.sh](file:///home/fahad/scripts/web-servers/pm2/setup_pm2.sh) | Installs PM2 globally and generates systemd startup unit files. |
| `update_pm2.sh` | [web-servers/pm2/update_pm2.sh](file:///home/fahad/scripts/web-servers/pm2/update_pm2.sh) | Upgrades PM2 cleanly while saving active process state and resurrecting workers. |
| `enable_monitoring.sh`| [web-servers/pm2/enable_monitoring.sh](file:///home/fahad/scripts/web-servers/pm2/enable_monitoring.sh) | Activates PM2 host telemetry and resource monitoring hooks. |

---

### 5. Security & Firewalls

Host-level perimeter security and automated TLS certificate management.

| Script | Path | Description |
| :--- | :--- | :--- |
| `ufw_setup.sh` | [security/ufw_setup.sh](file:///home/fahad/scripts/security/ufw_setup.sh) | Sets up UFW rules allowing OpenSSH and 'Nginx Full' (80/443), then enables the firewall. |
| `install_certbot.sh`| [security/install_certbot.sh](file:///home/fahad/scripts/security/install_certbot.sh) | Installs Certbot and the Python3 Nginx ACME plugin for automated SSL/TLS renewal. |

---

### 6. Package & Toolchain Installers

Modular installers for developer tools, language runtimes, and deployment orchestrators.

#### Node & Package Managers (`packages/node/`)
- [install_nvm.sh](file:///home/fahad/scripts/packages/node/install_nvm.sh) — Installs or updates NVM (Node Version Manager).
- [install_node_20.sh](file:///home/fahad/scripts/packages/node/install_node_20.sh) — Deploys Node.js v20 LTS from NodeSource.
- [install_node_22.sh](file:///home/fahad/scripts/packages/node/install_node_22.sh) — Deploys Node.js v22 Current from NodeSource.
- [install_pnpm_20.sh](file:///home/fahad/scripts/packages/node/install_pnpm_20.sh) — Configures PNPM using Corepack on Node 20 environments.
- [install_pnpm_22.sh](file:///home/fahad/scripts/packages/node/install_pnpm_22.sh) — Configures PNPM using Corepack on Node 22 environments.

#### Git Tooling (`packages/git/`)
- [setup_git.sh](file:///home/fahad/scripts/packages/git/setup_git.sh) — Interactive user prompt to configure `user.name` and `user.email` globally or locally.
- [install_git.sh](file:///home/fahad/scripts/packages/git/install_git.sh) — Installs the latest Git release from the official Ubuntu PPA.
- [update_git.sh](file:///home/fahad/scripts/packages/git/update_git.sh) — Upgrades Git installation to latest upstream PPA build.
- [install_lazygit.sh](file:///home/fahad/scripts/packages/git/install_lazygit.sh) — Downloads and installs the latest Lazygit terminal UI binary from GitHub releases.
- [delete_branches.sh](file:///home/fahad/scripts/packages/git/delete_branches.sh) — Safely deletes stale local and remote branches while protecting `main`, `development`, `staging`, `release/*`, and `sprint/*`.

#### Cloud Tools (`packages/terraform/` & `packages/ansible/`)
- [install_terraform.sh](file:///home/fahad/scripts/packages/terraform/install_terraform.sh) — Dynamically discovers and installs the latest stable HashiCorp Terraform binary for amd64/arm64.
- [install_ansible.sh](file:///home/fahad/scripts/packages/ansible/install_ansible.sh) — Configures the official Ansible PPA and installs Ansible.

---

### 7. Cloud & Infrastructure as Code (AWS & Ansible)

#### AWS Cloud-Init User-Data (`cloud/aws/ec2-user-data/`)
- [docker_compose_ufw.sh](file:///home/fahad/scripts/cloud/aws/ec2-user-data/docker_compose_ufw.sh) — Provisions Docker Compose, UFW firewall rules, and deployment directories on EC2 launch.
- [install_apache_docker.sh](file:///home/fahad/scripts/cloud/aws/ec2-user-data/install_apache_docker.sh) — Boots an Apache HTTPd container directly within EC2 user-data.
- [install_nginx_docker.sh](file:///home/fahad/scripts/cloud/aws/ec2-user-data/install_nginx_docker.sh) — Boots an Nginx container directly within EC2 user-data.

#### Ansible Infrastructure (`cloud/ansible/`)
- **Playbooks & Inventories**:
  - [playbooks/playbook_install_redis.yml](file:///home/fahad/scripts/cloud/ansible/playbooks/playbook_install_redis.yml) — Production Redis cluster configuration playbook.
  - [playbooks/inventories/inventory.ini](file:///home/fahad/scripts/cloud/ansible/playbooks/inventories/inventory.ini) — Cluster host inventory file.
- **Playbook Runners**:
  - [runners/run_playbook.sh](file:///home/fahad/scripts/cloud/ansible/runners/run_playbook.sh) — Execute playbooks against inventory.
  - [runners/list_tasks.sh](file:///home/fahad/scripts/cloud/ansible/runners/list_tasks.sh) — List all tasks and tags without running them.
  - [runners/execute_by_tag.sh](file:///home/fahad/scripts/cloud/ansible/runners/execute_by_tag.sh) — Target specific tags or step through starting points.
  - [runners/output_verbosity.sh](file:///home/fahad/scripts/cloud/ansible/runners/output_verbosity.sh) — Runs playbook with incremental verbosity flags (`-v`, `-vv`, `-vvv`).
- **Ad-Hoc Operational Scripts**:
  - [ad-hoc/ping_hosts.sh](file:///home/fahad/scripts/cloud/ansible/ad-hoc/ping_hosts.sh) — Ping fleet hosts and verify SSH reachability.
  - [ad-hoc/run_apt.sh](file:///home/fahad/scripts/cloud/ansible/ad-hoc/run_apt.sh) — Run remote apt package updates across targets.
  - [ad-hoc/install_nginx.sh](file:///home/fahad/scripts/cloud/ansible/ad-hoc/install_nginx.sh) / [remove_nginx.sh](file:///home/fahad/scripts/cloud/ansible/ad-hoc/remove_nginx.sh) — Remote Nginx lifecycle management.
  - [ad-hoc/copy_to_remote.sh](file:///home/fahad/scripts/cloud/ansible/ad-hoc/copy_to_remote.sh) / [copy_from_remote.sh](file:///home/fahad/scripts/cloud/ansible/ad-hoc/copy_from_remote.sh) — Bidirectional file distribution.
  - [ad-hoc/set_permissions.sh](file:///home/fahad/scripts/cloud/ansible/ad-hoc/set_permissions.sh) — Remote file permission and ownership enforcement.
  - [ad-hoc/restart_service.sh](file:///home/fahad/scripts/cloud/ansible/ad-hoc/restart_service.sh) — Graceful remote service restart.
  - [ad-hoc/reboot_servers.sh](file:///home/fahad/scripts/cloud/ansible/ad-hoc/reboot_servers.sh) — Coordinated fleet reboot.
  - [ad-hoc/server_info.sh](file:///home/fahad/scripts/cloud/ansible/ad-hoc/server_info.sh) — Remote facts gathering and hardware query (`ansible setup`).

---

### 8. Linux Networking & Virtual Labs

Building blocks for Linux kernel virtual switching, network namespaces, and low-level packet fabrication.

| Script | Path | Description |
| :--- | :--- | :--- |
| `create_bridge.sh` | [networking/create_bridge.sh](file:///home/fahad/scripts/networking/create_bridge.sh) | Creates an isolated network namespace with a bridge interface and 802.1Q VLAN filtering. |
| `create_end_host.sh`| [networking/create_end_host.sh](file:///home/fahad/scripts/networking/create_end_host.sh) | Builds an end-host namespace and attaches it to a bridge with a veth pair and tagged VLAN. |
| `connect_bridges.sh`| [networking/connect_bridges.sh](file:///home/fahad/scripts/networking/connect_bridges.sh) | Interconnects two Linux bridges across different network namespaces using a veth trunk. |
| `ethsend.py` | [networking/ethsend.py](file:///home/fahad/scripts/networking/ethsend.py) | Low-level Python script transmitting raw Ethernet frames using Linux `AF_PACKET` sockets. |
| `inspect_network.sh`| [networking/inspect_network.sh](file:///home/fahad/scripts/networking/inspect_network.sh) | Prints network link interfaces, kernel route tables, and active iptables firewall rules. |
| `get_public_ip.sh` | [networking/get_public_ip.sh](file:///home/fahad/scripts/networking/get_public_ip.sh) | Queries and displays the external public IPv4 address via `ifconfig.me`. |

---

### 9. Observability & Performance Monitoring

Infrastructure metric collectors, APM monitoring agents, and synthetic load testing.

| Tool | Path | Description |
| :--- | :--- | :--- |
| **Prometheus** | [monitoring/prometheus/setup_prometheus.sh](file:///home/fahad/scripts/monitoring/prometheus/setup_prometheus.sh) | Installs Prometheus binaries, creates service user, and provisions configuration directories. |
| **Netdata Agent** | [monitoring/netdata/install_netdata.sh](file:///home/fahad/scripts/monitoring/netdata/install_netdata.sh) | Kickstart installation for Netdata real-time monitoring agent. |
| **Netdata Cleaner**| [monitoring/netdata/clean_netdata.sh](file:///home/fahad/scripts/monitoring/netdata/clean_netdata.sh) / [uninstall_netdata.sh](file:///home/fahad/scripts/monitoring/netdata/uninstall_netdata.sh) | Maintenance and complete removal utilities for Netdata. |
| **Stress Testing** | [monitoring/load-testing/stress_test.sh](file:///home/fahad/scripts/monitoring/load-testing/stress_test.sh) | Spins up a 4-core synthetic CPU stress routine using `stress` for 60 seconds to validate alerts. |
| **MLflow Server** | [monitoring/ml/start_mlflow.sh](file:///home/fahad/scripts/monitoring/ml/start_mlflow.sh) | Boots an MLflow tracking server on port 5000 and runs model training routines. |

---

### 10. Automation, AI & Web Scraping

Specialized data extraction, AI document processing, and project layout generation.

#### Optical Character Recognition (`automation/ocr/`)
- [ocr_from_pdf.py](file:///home/fahad/scripts/automation/ocr/ocr_from_pdf.py) — Automates PDF text and table extraction using the **Mistral AI OCR API**. Uploads documents, extracts structured JSON results, and removes processed files from remote storage.
- [README.md](file:///home/fahad/scripts/automation/ocr/README.md) — Comprehensive setup and configuration guide for Mistral OCR.

#### Web Scraping Engines (`automation/web-scraping/`)
- [dynamic-pdf-scraper/](file:///home/fahad/scripts/automation/web-scraping/dynamic-pdf-scraper/) — Selenium-based web scraper that handles dynamic JavaScript rendering, downloads target PDF documents, and renames them predictably. Includes headless Chrome provisioner: [install_selenium.sh](file:///home/fahad/scripts/automation/web-scraping/install_selenium.sh).
- [devops-pdf-downloader/](file:///home/fahad/scripts/automation/web-scraping/devops-pdf-downloader/) — Lightweight scraper targeted at harvesting DevOps whitepapers and reference books.

#### Scaffolding (`automation/scaffolding/`)
- [scaffold_node_project.sh](file:///home/fahad/scripts/automation/scaffolding/scaffold_node_project.sh) — Shell script scaffolding an Express/Node.js architectural structure (routes, controllers, models, middleware, tests).
- [scaffold_node_project.py](file:///home/fahad/scripts/automation/scaffolding/scaffold_node_project.py) — Python 3 implementation with path validation and destination argument support.

---

### 11. Development & Code Utilities

- **C++ Tooling** (`development/cpp/`):
  - [run_cpp.sh](file:///home/fahad/scripts/development/cpp/run_cpp.sh) — Compiles with `g++ -std=c++17`, checks exit code, and executes the generated `.out` binary.
  - [gen_cpp.sh](file:///home/fahad/scripts/development/cpp/gen_cpp.sh) — Generates clean C++ template boilerplate with `iostream`, `vector`, and `algorithm`.
- **Demos & Shell Patterns** (`development/demos/`):
  - [env_demo.sh](file:///home/fahad/scripts/development/demos/env_demo.sh) — Demonstrates shell environment export, subshell inheritance, and unsetting.
  - [test_file_exists.sh](file:///home/fahad/scripts/development/demos/test_file_exists.sh) — Idiomatic file existence and read permission checking.

---

### 12. Reference & Bash Exercises

- **Cheatsheets** (`reference/cheatsheets/`):
  - [bash_cheatsheet.sh](file:///home/fahad/scripts/reference/cheatsheets/bash_cheatsheet.sh) — Extensive cheat sheet covering readline keyboard shortcuts (Ctrl/Alt navigation, history expansion, keyboard macros) and shell syntax.
- **Interactive Exercises** (`reference/bash-exercises/`):
  - 23 hands-on practical scripts covering variables, arguments (`$@` vs `$*`), arrays, math calculators, conditionals, loops (`for`, `while`, `until`), signal traps, and mini-applications (weather advisor, treasure map, file explorer).

---

## 🛠️ Key Operational Workflows

### Workflow A: Deep Server Diagnostic Audit
Execute a full health audit and export the results to an audit log:

```bash
chmod +x system/diagnostics/server_check.sh
./system/diagnostics/server_check.sh | tee /tmp/server_audit_$(date +%F).log
```

### Workflow B: Safe Disk & Cache Vacuum
Free up disk space on Ubuntu servers by cleaning APT caches, vacuuming systemd journal logs down to 200MB, pruning unreferenced pnpm packages, and removing dangling Docker layers:

```bash
chmod +x system/maintenance/cleanup.sh
./system/maintenance/cleanup.sh
```

### Workflow C: Zero-Downtime Nginx Deployment
Safely deploy reverse proxy changes without dropping active client connections:

```bash
# 1. Edit or link your site configuration:
sudo cp web-servers/nginx/reverse_proxy.conf /etc/nginx/sites-available/api.conf
sudo ln -sf /etc/nginx/sites-available/api.conf /etc/nginx/sites-enabled/

# 2. Test syntax and reload gracefully:
sudo ./web-servers/nginx/reload_nginx.sh
```

### Workflow D: Automated Virtual Switching Lab
Spin up an isolated virtual networking topology in Linux namespaces:

```bash
cd networking
chmod +x create_bridge.sh create_end_host.sh connect_bridges.sh

# Create two bridges in separate namespaces
./create_bridge.sh lab_ns1 br0
./create_bridge.sh lab_ns2 br1

# Interconnect the bridges with a virtual Ethernet trunk
./connect_bridges.sh lab_ns1 br0 lab_ns2 br1
```

---

## 📐 Engineering Standards & Coding Guidelines

Every script in this repository adheres to defensive programming standards:

1. **Explicit Interpreters**: Every script starts with a standardized shebang (`#!/usr/bin/env bash` or `#!/usr/bin/env python3`).
2. **Fail-Fast Error Handling**: Bash scripts enforce `set -euo pipefail` (or structured status validation with helper functions) to prevent cascading failures.
3. **Quoting Discipline**: All parameter expansions and file paths must be quoted (`"$FILE"` instead of `$FILE`) to handle filenames with spaces safely.
4. **Interactive Prompts for Destructive Actions**: Scripts that execute mass termination or disk clearing (`kill_by_name.sh`, `kill_node_apps.sh`, `cleanup.sh`) prompt the operator for confirmation before proceeding.
5. **Portability & Architecture Detection**: Binary downloaders (`install_terraform.sh`) detect `uname -s` and `uname -m` dynamically to support x86_64, amd64, and arm64.

---

## 🔒 Security Guidelines

Please refer to the comprehensive [SECURITY.md](file:///home/fahad/scripts/SECURITY.md) for security policies, privilege separation guidelines, and the procedure for responsibly reporting vulnerabilities.

- **Least Privilege**: Avoid running entire scripts as `root`. Run as your normal user; commands requiring elevated privileges invoke `sudo` explicitly.
- **Review Before Piping**: Always inspect remote scripts prior to executing them via `curl ... | bash`.
- **Secret Exclusion**: Never store API tokens, SSH keys, or passwords in repository files. Use local `.env` files protected by `.gitignore`.

---

## 📄 License

This repository is licensed under the [MIT License](https://opensource.org/licenses/MIT). You are free to use, modify, and distribute these scripts across personal, commercial, and enterprise infrastructure.
