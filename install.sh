# copies dotfiles

# Get the directory of the script
SCRIPT_DIR=$(dirname "$(realpath "$0")")

# Remove existing files if they exist
rm -f ~/.aliases
rm -f ~/.zshrc
rm -f ~/.config/starship.toml
rm -rf ~/.zsh

# Create symlinks for the dotfiles
ln -sf "$SCRIPT_DIR/.aliases" ~/.aliases
ln -sf "$SCRIPT_DIR/.zshrc" ~/.zshrc

# Create the ~/.config directory if it doesn't exist
mkdir -p ~/.config
mkdir -p ~/.zsh

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git ~/.zsh/zsh-autocomplete
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting ~/.zsh/fast-syntax-highlighting

# Create a symlink for the starship configuration
ln -sf "$SCRIPT_DIR/.config/starship.toml" ~/.config/starship.toml

# Check if zsh is installed
if ! command -v zsh >/dev/null 2>&1; then
  echo "zsh is not installed. Please install zsh and rerun this script."
  exit 1
fi

# Get the path of zsh
ZSH_PATH=$(which zsh)

# Install starship
curl -sS https://starship.rs/install.sh | sh -s -- -y

# Change the default shell to zsh
sudo chsh -s "$ZSH_PATH"

# Check if the shell was changed successfully
if [ $? -eq 0 ]; then
  echo "Successfully changed the default shell to zsh."
  echo "Please log out and log back in for the changes to take effect."
else
  echo "Failed to change the default shell."
  exit 1
fi