#!/bin/zsh

# ensures $SHELL is also set to zsh
export SHELL=/bin/zsh

PLUGINS_DIR="$HOME/.zsh_addons"
if [ ! -d $PLUGINS_DIR ]; then
    mkdir "$PLUGINS_DIR"
fi

# Check if .aliases exists and sources it
[[ -f $HOME/.aliases ]] && source $HOME/.aliases

# Check if .aliases.local exists and sources it
# this can be used to set aliases for your specific environment
[[ -f $HOME/.aliases.local ]] && source $HOME/.aliases.local

source $PLUGINS_DIR/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $PLUGINS_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh
source $PLUGINS_DIR/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# Check if poetry is installed and sets up completions
if command -v poetry &> /dev/null; then
    [ ! -f ~/.zfunc ] && mkdir -p ~/.zfunc &> /dev/null
    [ ! -f ~/.zfunc/_poetry ] && poetry completions zsh > ~/.zfunc/_poetry
    fpath+=~/.zfunc
    autoload -Uz compinit && compinit
fi

# Starts starship
eval "$(starship init zsh)"