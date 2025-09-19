#!/bin/zsh

# ensures $SHELL is also set to zsh
export SHELL=/bin/zsh

# adds home bin folder to path, if it already wasn't there
if ! [[ ":$PATH:" == *":$HOME/bin:"* ]]; then
    export PATH="$HOME/bin:$PATH"
fi

# REALLY IMPORTANT FOR AUTOCOMPLETE
setopt interactivecomments

# Check if .aliases exists and sources it
[[ -f $HOME/.aliases ]] && source $HOME/.aliases

# Check if .aliases.local exists and sources it
# this can be used to set aliases for your specific environment
[[ -f $HOME/.aliases.local ]] && source $HOME/.aliases.local

# >>> Zinit's installer >>>
# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"
# <<< Zinit's installer <<<

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
# add docker completation, docker plugin expects the script to be in $ZSH_CACHE_DIR/completions/_docker
docker completion zsh > "$ZSH_CACHE_DIR/completions/_docker"
FPATH="$HOME/.docker/completions:$FPATH"
zinit light zsh-users/zsh-autosuggestions
# zinit ice depth=1
# zinit light jeffreytse/zsh-vi-mode
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::docker
zinit snippet OMZP::docker-compose
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

# reload completations
zinit cdreplay -q

# <<< History <<<
# number of saved commands
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
# erases any duplicates
HISTDUP=erase
setopt appendhistory
# shares history between sessions
setopt sharehistory
# duplicates 
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
# >>> History >>>

# <<< Completion styling <<<
# match also lower case completations
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# use ls colors as in ls --color for the completation aswell
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# do not use default completations menu
zstyle ':completion:*' menu no
# use fzf for completion menu for cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
# use fzf for completation menu for zoxide
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
# >>> Completion styling >>>

# Shell integrations
eval "$(fzf --zsh)"
# eval "$(zoxide init --cmd cd zsh)"

# <<< starship prompt <<<
eval "$(starship init zsh)"
# >>> starship prompt <<<