#!/bin/zsh

# Function to check if Homebrew is installed
install_homebrew() {
    if ! command -v brew &> /dev/null
    then
        echo "Homebrew is not installed. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        echo "Homebrew is already installed."
    fi
}

# Install Homebrew if necessary
install_homebrew

# Make sure Homebrew is updated
echo "Updating Homebrew..."
brew update

# Install all brew formulas from the list
if [ -f "installed-packages.txt" ]; then
    echo "Installing brew formulas from installed-packages.txt..."
    while IFS= read -r package; do
        echo "Installing $package..."
        brew install "$package"
    done < installed-packages.txt
else
    echo "installed-packages.txt not found! Please make sure the file exists."
fi

# Install all brew casks (GUI applications) from the list
if [ -f "installed-casks.txt" ]; then
    echo "Installing brew casks from installed-casks.txt..."
    while IFS= read -r cask; do
        echo "Installing $cask..."
        brew install --cask "$cask"
    done < installed-casks.txt
else
    echo "installed-casks.txt not found! Please make sure the file exists."
fi

# Install bat catppuccin theme https://github.com/catppuccin/bat
mkdir -p "$(bat --config-dir)/themes"
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Latte.tmTheme
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Frappe.tmTheme
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Macchiato.tmTheme
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme
bat cache --build
