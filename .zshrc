# Check if .aliases exists and sources it
[[ -f $HOME/.aliases ]] && source $HOME/.aliases

# Check if .aliases.local exists and sources it
# this can be used to set aliases for your specific environment
[[ -f $HOME/.aliases.local ]] && source $HOME/.aliases.local

# Starts starship
eval "$(starship init zsh)"