#!/bin/zsh

# Function to check if Homebrew is installed
install_homebrew() {
  if ! command -v brew &>/dev/null; then
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

# Install all packages listed in Brewfile
brew bundle install --file=~/.config/brew/Brewfile

# Install bat catppuccin theme https://github.com/catppuccin/bat
mkdir -p "$(bat --config-dir)/themes"
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Latte.tmTheme
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Frappe.tmTheme
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Macchiato.tmTheme
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme
bat cache --build

# tmux setup and theme
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/bin/install_plugins

# set symlinks to vscode user settings directory
ln -s ~/.config/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -s ~/.config/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
ln -s ~/.config/vscode/snippets/vue.code-snippets ~/Library/Application\ Support/Code/User/snippets/vue.code-snippets

