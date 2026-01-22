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

HISTFILE='/tmp/.hist'
HISTSIZE=10000
SAVEHIST=0

# plugins
source $ZDOTDIR/plugins/zsh-vim-mode/zsh-vim-mode.plugin.zsh 2>/dev/null
source $ZDOTDIR/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
source $ZDOTDIR/plugins/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh 2>/dev/null
source $ZDOTDIR/plugins/zsh-async/async.plugin.zsh 2>/dev/null
source $ZDOTDIR/lib/history.zsh 2>/dev/null

# theme (rand form from kolo from oh-my-zsh)
source $ZDOTDIR/themes/rand.zsh-theme

# auto complete
fpath+="$ZDOTDIR/zfunc"
# custom
fpath+="$HOME/.zfunc"
# homebrew
fpath+="/opt/homebrew/share/zsh/site-functions"

autoload -U compinit; compinit


# key bindings
source $ZDOTDIR/lib/key-bindings.zsh 2>/dev/null

# get profile setupts
[ -f $HOME/.zprofile ] && source $HOME/.zprofile

# should be loaded after compinit and sourcing zprofile (because in zprofile may be fzf configure)
source $ZDOTDIR/plugins/fzf-tab/fzf-tab.plugin.zsh 2>/dev/null

zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath' # remember to use single quote here!!!

# get aliases
[ -f $HOME/.aliasrc ] && source $HOME/.aliasrc

