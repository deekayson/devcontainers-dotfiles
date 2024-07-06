#!/bin/bash

# Check if zsh is installed and do nothing if not
if ! command -v zsh >/dev/null 2>&1; then
  echo "zsh is not installed. Please install zsh and rerun this script."
  exit 1
fi

# Get the path of zsh
ZSH_PATH=$(which zsh)

PLUGINS_DIR="$HOME/.zsh_addons"

rm -rf $HOME/dotfiles
rm -rf $HOME/bin
cp -r ../devcontainers-dotfiles $HOME/dotfiles

bash "$HOME/dotfiles/install.sh"

echo ""
echo "--------------------------------------------------------"
echo "Dotfiles updated, open another shell to see the results."