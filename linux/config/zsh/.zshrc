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

# plugins
source $HOME/.config/zsh/plugins/zsh-vim-mode/zsh-vim-mode.plugin.zsh 2>/dev/null
source $HOME/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source $HOME/.config/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh 2>/dev/null
source $HOME/.config/zsh/plugins/git/git.plugin.zsh 2>/dev/null
source $HOME/.config/zsh/plugins/zsh-async/async.zsh 2>/dev/null

# theme (kolo from oh-my-zsh)
source $HOME/.config/zsh/kolo.zsh-theme

# history
[ -d "$HOME/.cache/zsh" ] || mkdir "$HOME/.cache/zsh"
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
