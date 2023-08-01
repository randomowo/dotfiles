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
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source $ZDOTDIR/plugins/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh 2>/dev/null
source $ZDOTDIR/plugins/git.plugin.zsh 2>/dev/null
source $ZDOTDIR/plugins/zsh-async/async.zsh 2>/dev/null
source $ZDOTDIR/lib/history.zsh 2>/dev/null

# theme (rand form from kolo from oh-my-zsh)
source $ZDOTDIR/themes/rand.zsh-theme

# auto complete
fpath+="$ZDOTDIR/zfunc"

autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)
source $ZDOTDIR/lib/completion.zsh 2>/dev/null

# key bindings
source $ZDOTDIR/lib/key-bindings.zsh 2>/dev/null

# get aliases
[ -f $HOME/.aliasrc ] && source $HOME/.aliasrc
