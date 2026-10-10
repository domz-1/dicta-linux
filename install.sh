#!/usr/bin/env bash
set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}=========================================${NC}"
echo -e "${GREEN}   🎙️ Installing Dicta Linux (STT)       ${NC}"
echo -e "${BLUE}=========================================${NC}"

# 1. Install Dependencies
echo -e "${YELLOW}Checking dependencies...${NC}"

install_deps() {
    if command -v apt-get &>/dev/null; then
        echo -e "${BLUE}Detected Debian/Ubuntu system.${NC}"
        sudo apt-get update -y || true
        sudo apt-get install -y python3 ffmpeg flac xclip copyq zenity libnotify-bin
    elif command -v pacman &>/dev/null; then
        echo -e "${BLUE}Detected Arch Linux system.${NC}"
        sudo pacman -S --noconfirm python ffmpeg flac xclip copyq zenity libnotify
    elif command -v dnf &>/dev/null; then
        echo -e "${BLUE}Detected Fedora/RHEL system.${NC}"
        sudo dnf install -y python3 ffmpeg flac xclip copyq zenity libnotify
    elif command -v zypper &>/dev/null; then
        echo -e "${BLUE}Detected openSUSE system.${NC}"
        sudo zypper install -y python3 ffmpeg flac xclip copyq zenity libnotify-tools
    else
        echo -e "${YELLOW}Warning: Unknown package manager. Please ensure python3, ffmpeg, flac, xclip, copyq, and libnotify are installed.${NC}"
    fi
}

if ! command -v ffmpeg &>/dev/null || ! command -v xclip &>/dev/null || ! command -v copyq &>/dev/null; then
    echo -e "${YELLOW}Some dependencies are missing. Installing...${NC}"
    install_deps
else
    echo -e "${GREEN}✓ All core dependencies found!${NC}"
fi

# 2. Install Executable to ~/.local/bin
echo -e "${YELLOW}Installing dicta to ~/.local/bin...${NC}"
mkdir -p "$HOME/.local/bin"
cp -f "$(dirname "$0")/bin/dicta" "$HOME/.local/bin/dicta"
chmod +x "$HOME/.local/bin/dicta"

# 3. Install Desktop Launcher
echo -e "${YELLOW}Installing desktop application launcher...${NC}"
mkdir -p "$HOME/.local/share/applications"
cp -f "$(dirname "$0")/assets/dicta.desktop" "$HOME/.local/share/applications/dicta.desktop"
command -v update-desktop-database &>/dev/null && update-desktop-database "$HOME/.local/share/applications" || true

# 4. Setup GNOME Shortcut (Alt+D for Voice Dictate toggle)
if [ "$XDG_CURRENT_DESKTOP" = "GNOME" ] || [ "$XDG_CURRENT_DESKTOP" = "ubuntu:GNOME" ] || [ "$DESKTOP_SESSION" = "ubuntu" ] || [ "$DESKTOP_SESSION" = "gnome" ]; then
    echo -e "${YELLOW}Configuring GNOME global shortcuts (Alt+D)...${NC}"
    EXISTING=$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings | tr -d '@as ' | sed 's/\[//;s/\]//')
    
    KEY_PATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/dicta0/"
    
    if [[ ! "$EXISTING" =~ "dicta0" ]]; then
        if [ -z "$EXISTING" ]; then
            NEW_LIST="['$KEY_PATH']"
        else
            NEW_LIST="[$(echo "$EXISTING" | sed "s/]$//"), '$KEY_PATH']"
        fi
        gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "$NEW_LIST" || true
    fi

    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$KEY_PATH name "Dicta - Voice Typing (Alt+D)" || true
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$KEY_PATH command "$HOME/.local/bin/dicta" || true
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$KEY_PATH binding "<Alt>d" || true
fi

echo -e "\n${GREEN}=========================================${NC}"
echo -e "${GREEN}   ✅ Dicta Linux Installed Successfully! ${NC}"
echo -e "${GREEN}=========================================${NC}"
echo -e "${BLUE}How to use Voice Typing:${NC}"
echo -e "1. Place cursor in any text field or app."
echo -e "2. Press ${YELLOW}Alt + D${NC} to start recording."
echo -e "3. Speak your thoughts in Arabic, English, or mixed!"
echo -e "4. Press ${YELLOW}Alt + D${NC} again to finish and auto-paste!"
echo -e "\nEnjoy! 🎙️✨"
