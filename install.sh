#!/usr/bin/env bash

echo "🔧 Installing dependencies..."

# Detect package manager
if command -v apt >/dev/null 2>&1; then
    PKG="apt"
elif command -v dnf >/dev/null 2>&1; then
    PKG="dnf"
elif command -v yum >/dev/null 2>&1; then
    PKG="yum"
elif command -v pacman >/dev/null 2>&1; then
    PKG="pacman"
elif command -v zypper >/dev/null 2>&1; then
    PKG="zypper"
else
    echo "❌ Unsupported package manager"
    exit 1
fi

echo "📦 Detected: $PKG"

install_packages() {
    case $PKG in
        apt)
            sudo apt update
            sudo apt install -y figlet cowsay lolcat python3 curl
            ;;
        dnf)
            sudo dnf install -y figlet cowsay lolcat python3 curl
            ;;
        yum)
            sudo yum install -y figlet cowsay python3 curl
            sudo yum install -y ruby
            sudo gem install lolcat
            ;;
        pacman)
            sudo pacman -Sy --noconfirm figlet cowsay lolcat python curl
            ;;
        zypper)
            sudo zypper install -y figlet cowsay ruby python3 curl
            sudo gem install lolcat
            ;;
    esac
}

install_packages

# Check lolcat (some distros install it via gem)
if ! command -v lolcat >/dev/null 2>&1; then
    echo "🎨 Installing lolcat via gem..."
    if command -v gem >/dev/null 2>&1; then
        sudo gem install lolcat
    else
        echo "❌ Ruby/gem not found. Please install ruby manually."
    fi
fi

echo "✅ Dependency installation completed!"

echo "⚙️ Setting up automatic startup..."

SCRIPT_PATH="$HOME/terminalCustomSplash/script.sh"

# Make the script executable
chmod +x "$SCRIPT_PATH"

# Add to .bashrc only if not already present
if ! grep -Fxq "$SCRIPT_PATH" "$HOME/.bashrc"; then
    echo "" >> "$HOME/.bashrc"
    echo "# Custom Splash" >> "$HOME/.bashrc"
    echo "$SCRIPT_PATH" >> "$HOME/.bashrc"
    echo "✅ Added to terminal startup"
else
    echo "ℹ️ Already present in .bashrc"
fi

echo ""
echo "🚀 Done! Restart your terminal to see the result"