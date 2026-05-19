#!/usr/bin/env bash

set -e

echo "==> Backing up existing Neovim configuration..."

backup_dir="$HOME/nvim-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$backup_dir"

backup_if_exists() {
  if [ -e "$1" ]; then
    echo "Backing up $1"
    mv "$1" "$backup_dir/"
  fi
}

backup_if_exists "$HOME/.config/nvim"
backup_if_exists "$HOME/.local/share/nvim"
backup_if_exists "$HOME/.local/state/nvim"
backup_if_exists "$HOME/.cache/nvim"

echo "==> Installing system dependencies..."

sudo apt update
sudo apt install -y \
  git curl wget unzip \
  build-essential gcc g++ make cmake \
  ripgrep fd-find \
  python3-pip \
  xclip \
  ca-certificates \
  gnupg \
  lsb-release

echo "==> Installing Git (if not already installed)..."

sudo apt install -y git

echo "==> Installing Docker..."

sudo apt remove -y docker docker-engine docker.io containerd runc || true

sudo install -m 0755 -d /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update

sudo apt install -y \
  docker-ce docker-ce-cli containerd.io \
  docker-buildx-plugin docker-compose-plugin

sudo systemctl enable docker
sudo systemctl start docker

sudo usermod -aG docker $USER

echo "==> Installing LazyVim..."

git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

echo "==> Installing NVM..."

export NVM_DIR="$HOME/.nvm"

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

echo "==> Installing Node.js 24..."

nvm install 24
nvm use 24

echo "==> Enabling pnpm..."

corepack enable pnpm

echo "==> Verifying installs..."

node -v
pnpm -v
gcc --version
git --version
docker --version

echo "==> DONE"

echo ""
echo "IMPORTANT:"
echo "- Restart terminal or run: newgrp docker"
echo "- Backup saved at: $backup_dir"
echo "- Run Neovim: nvim"
