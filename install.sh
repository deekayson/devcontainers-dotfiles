#!/bin/sh

# Check if zsh is installed and do nothing if not
if ! command -v zsh >/dev/null 2>&1; then
  echo "zsh is not installed. Please install zsh and rerun this script."
  exit 1
fi

# Get the directory of the script
SCRIPT_DIR=$(dirname "$(realpath "$0")")
# copies dotfiles

# Remove existing files if they exist
rm -f "$HOME/.aliases"
rm -f "$HOME/.zshrc"
rm -f "$HOME/.config/starship.toml"

# Creates root directories if they don't exist
mkdir -p "$HOME/.config"

# Create symlinks for the dotfiles
ln -s "$SCRIPT_DIR/.aliases" "$HOME/.aliases"
ln -s "$SCRIPT_DIR/.zshrc" "$HOME/.zshrc"


# Create a symlink for the starship configuration
ln -s "$SCRIPT_DIR/.config/starship.toml" "$HOME/.config/starship.toml"
