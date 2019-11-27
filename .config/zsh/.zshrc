# ▒███████▒  ██████  ██░ ██     ▄████▄   ▒█████   ███▄    █   █████▒██▓  ▄████
# ▒ ▒ ▒ ▄▀░▒██    ▒ ▓██░ ██▒   ▒██▀ ▀█  ▒██▒  ██▒ ██ ▀█   █ ▓██   ▒▓██▒ ██▒ ▀█▒
# ░ ▒ ▄▀▒░ ░ ▓██▄   ▒██▀▀██░   ▒▓█    ▄ ▒██░  ██▒▓██  ▀█ ██▒▒████ ░▒██▒▒██░▄▄▄░
#   ▄▀▒   ░  ▒   ██▒░▓█ ░██    ▒▓▓▄ ▄██▒▒██   ██░▓██▒  ▐▌██▒░▓█▒  ░░██░░▓█  ██▓
# ▒███████▒▒██████▒▒░▓█▒░██▓   ▒ ▓███▀ ░░ ████▓▒░▒██░   ▓██░░▒█░   ░██░░▒▓███▀▒
# ░▒▒ ▓░▒░▒▒ ▒▓▒ ▒ ░ ▒ ░░▒░▒   ░ ░▒ ▒  ░░ ▒░▒░▒░ ░ ▒░   ▒ ▒  ▒ ░   ░▓   ░▒   ▒
# ░░▒ ▒ ░ ▒░ ░▒  ░ ░ ▒ ░▒░ ░     ░  ▒     ░ ▒ ▒░ ░ ░░   ░ ▒░ ░      ▒ ░  ░   ░
# ░ ░ ░ ░ ░░  ░  ░   ░  ░░ ░   ░        ░ ░ ░ ▒     ░   ░ ░  ░ ░    ▒ ░░ ░   ░
#   ░ ░          ░   ░  ░  ░   ░ ░          ░ ░           ░         ░        ░
# ░                            ░
# by randomowo

# load aliases
[ -f "$HOME/.config/aliasrs" ] && source "$HOME/.config/aliasrs"

# theme (kolo from oh-my-zsh)
source $HOME/.config/zsh/kolo.zsh-theme

# history
source $HOME/.config/zsh/lib/history.zsh 2>/dev/null

# auto complete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)
#source $HOME/.config/zsh/lib/completion.zsh 2>/dev/null

# key bindings
source $HOME/.config/zsh/lib/key-bindings.zsh 2>/dev/null

# plugins
source $HOME/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source $HOME/.config/zsh/plugins/git/git.plugin.zsh 2>/dev/null
source $HOME/.config/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh 2>/dev/null
#source $HOME/.config/zsh/plugins/calc.plugin.zsh/calc.plugin.zsh 2>/dev/null
source $HOME/.config/zsh/plugins/deer/deer 2>/dev/null
zle -N deer
bindkey '\ek' deer
source $HOME/.config/zsh/plugins/zsh-async/async.zsh 2>/dev/null
#source $HOME/.config/zsh/plugins/zsh-auto-notify/auto-notify.plugin.zsh 2>/dev/null
