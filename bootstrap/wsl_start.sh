#!/usr/bin/env bash
set -e

echo "==> Updating system..."

sudo apt update && sudo apt upgrade -y && sudo apt clean

echo "==> Installing base dependencies..."

sudo apt install -y \
  git curl wget unzip \
  build-essential cmake \
  ripgrep fd-find \
  python3-pip \
  xclip \
  ca-certificates \
  gnupg \
  lsb-release

#################################################
# GIT CONFIG + SSH KEY
#################################################

echo "==> Running Git configuration..."

git config --global user.name "coder7475"
git config --global user.email "robiulhossain7475@gmail.com"

git config --global init.defaultBranch main
git config --global credential.helper 'cache --timeout=900'

echo "✅ Git global configuration has been set successfully!"
echo
echo "Current Git configuration:"
git config --list | grep 'user\|init.defaultBranch\|credential.helper' || true

echo "==> Generating SSH key (ed25519)..."

SSH_KEY="$HOME/.ssh/id_ed25519"

if [ ! -f "$SSH_KEY" ]; then
  ssh-keygen -t ed25519 -C "robiulhossain7475@gmail.com" -f "$SSH_KEY" -N ""
fi

eval "$(ssh-agent -s)"
ssh-add "$SSH_KEY"

echo "==> Public SSH key:"
cat "${SSH_KEY}.pub"

#################################################
# NODE (NVM) + PNPM + ALIAS + OPCODE
#################################################

echo "==> Installing NVM..."

export NVM_DIR="$HOME/.nvm"

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

echo "==> Installing Node.js 22..."

nvm install 22
nvm use 22
nvm alias default 22

echo "==> Enabling pnpm..."

corepack enable pnpm

echo "==> Adding alias pn=pnpm..."

if ! grep -q "alias pn=pnpm" ~/.bashrc; then
  echo "alias pn=pnpm" >> ~/.bashrc
fi

source ~/.bashrc

echo "==> Installing OpenCode..."

curl -fsSL https://opencode.ai/install | bash

#################################################
# DOCKER
#################################################

echo "==> Installing Docker..."

sudo apt remove -y docker docker-engine docker.io containerd runc || true

sudo install -m 0755 -d /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update

sudo apt install -y \
  docker-ce docker-ce-cli containerd.io \
  docker-buildx-plugin docker-compose-plugin

sudo systemctl enable docker
sudo systemctl start docker

echo "==> Enabling Docker without sudo..."
sudo usermod -aG docker $USER

#################################################
# NEOVIM (v0.11.7 via tarball) + LAZYVIM
#################################################

echo "==> Installing Neovim v0.11.7 from tarball..."

cd /tmp

wget https://github.com/neovim/neovim/releases/download/v0.11.7/nvim-linux-x86_64.tar.gz

tar xzvf nvim-linux-x86_64.tar.gz

sudo rm -rf /opt/nvim
sudo mv nvim-linux-x86_64 /opt/nvim

# Add to PATH if not already present
if ! grep -q '/opt/nvim/bin' ~/.bashrc; then
  echo 'export PATH="/opt/nvim/bin:$PATH"' >> ~/.bashrc
fi

source ~/.bashrc

echo "==> Verifying Neovim..."
nvim --version | head -n 1

#################################################
# BACKUP + LAZYVIM
#################################################

echo "==> Backing up Neovim config..."

backup_dir="$HOME/nvim-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$backup_dir"

backup_if_exists() {
  if [ -e "$1" ]; then
    mv "$1" "$backup_dir/"
  fi
}

backup_if_exists "$HOME/.config/nvim"
backup_if_exists "$HOME/.local/share/nvim"
backup_if_exists "$HOME/.local/state/nvim"
backup_if_exists "$HOME/.cache/nvim"

echo "==> Installing LazyVim..."

git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

#################################################
# VERIFY
#################################################

echo "==> Verifying installs..."

git --version
node -v
pnpm -v
docker --version
nvim --version

echo ""
echo "==> DONE"

echo "IMPORTANT:"
echo "- Run: newgrp docker OR reboot (Docker without sudo)"
echo "- SSH key printed above → add to GitHub/GitLab"
echo "- Backup: $backup_dir"
echo "- Run Neovim: nvim"
