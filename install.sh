#!/data/data/com.termux/files/usr/bin/bash

# -------- COLORS --------
BLUE="\033[1;34m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
RED="\033[1;31m"
RESET="\033[0m"

# -------- FUNCTIONS --------
info() { echo -e "${BLUE}[INFO]${RESET} $1"; }
work() { echo -e "${YELLOW}[WORK]${RESET} $1"; }
ok()   { echo -e "${GREEN}[OK]${RESET} $1"; }
err()  { echo -e "${RED}[ERROR]${RESET} $1"; }

clear

# -------- INTERNET CHECK --------
info "Checking internet connection..."

while true; do
    ping -c 1 google.com >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        ok "Internet connected"
        break
    else
        err "No internet. Waiting for connection..."
        sleep 5
    fi
done

# ------- CHANGE DIRECTORY --------
work "Changing directory..."
cd $HOME || { err "Directory changing failed"; exit 1; }
ok "Directory changed"

# ------- UPDATE PACKAGES ---------
work "Updating package lists..."
pkg update -y && pkg upgrade -y || { err "Package update failed"; exit 1; }
ok "Packages updated"

# -------- INSTALL PYTHON --------
work "Installing Python..."
pkg install -y python || { err "Python install failed"; exit 1; }
ok "Python installed"

# -------- INSTALL CLOUDFLARED --------
work "Installing cloudflared..."
pkg install -y cloudflared || { err "cloudflared install failed"; exit 1; }
ok "cloudflared installed"

# -------- INSTALL TERMUX API --------
work "Installing termux-api..."
pkg install -y termux-api || { err "termux-api install failed"; exit 1; }
ok "termux-api installed"

# -------- INSTALL GIT --------
work "Installing git..."
pkg install -y git || { err "Git install failed"; exit 1; }
ok "Git installed"

# -------- INSTALL REQUESTS--------
work "Installing requests(pip)..."
pip install --no-cache-dir requests || { err "requests install failed"; exit 1; }
ok "requests installed"

# -------- INSTALL COLORAMA --------
work "Installing colorama(pip)..."
pip install --no-cache-dir colorama || { err "colorama install failed"; exit 1; }
ok "colorama installed"

# -------- CLONE PROJECT --------
info "Cloning ShadowBridge repository..."

if [ -d "ShadowBridge" ]; then
    work "Repository already exists. Pulling updates..."
    cd ShadowBridge && git pull
else
    git clone https://github.com/his-bullah/ShadowBridge.git || { err "Git clone failed"; exit 1; }
    cd ShadowBridge
fi

ok "Project ready"

work "Starting shadow.pyc..."
sleep 5

python shadow.pyc || { err "shadow.pyc crashed"; exit 1; }
