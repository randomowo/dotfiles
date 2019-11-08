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

# altera quartus
export ALTERA_ROOT="/opt/altera/13.1"
export QUARTUS_ROOTDIR_OVERRIDE="$ALTERA_ROOT/quartus"
export QSYS_ROOTDIR="$QUARTUS_ROOTDIR_OVERRIDE/sopc_builder/bin"
export QUARTUS_LIBRARY_PATHS="$QUARTUS_ROOTDIR_OVERRIDE/linux/:/lib/x86_64-linux-gnu/"
export SOPC_KIT_NIOS2="$ALTERA_ROOT/nios2eds"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$QUARTUS_LIBRARY_PATHS"
# matlab
export MATLAB_ROOT="/opt/MATLAB/R2019b"

export ZSH="$HOME/.oh-my-zsh"
export PATH="$PATH:$ALTERA_ROOT/quartus/bin:$MATLAB_ROOT/bin"

ZSH_THEME="kolo"
#jnrowe, dogenpunk, nicoulaj, crunch, blinks, kolo

plugins=(
    git
    zsh-syntax-highlighting
    zsh-history-substring-search
)

source $ZSH/oh-my-zsh.sh
# zsh plugins

# connect by ssh to my server
alias sshm="ssh makromant@makromant.myjino.ru"
# check size
alias dcap="df -h /"
alias sizeof="du -sh"
# counting folders and files
alias count="tree | tail -1"
# git aliases
alias git-adog="git log --all --decorate --oneline --graph"
alias git-undo="git revert  --soft HEAD~1"
# remove unused packages
alias cleanup='yay -Rns $(yay -Qtdq) && yay -Yc'
# alias for programms
alias irc='weechat'
# update python packages
alias upip='pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 sudo -H pip install --ignore-installed -U'
# rust ls
alias ls='exa'
alias l='exa -lahgF -a'
alias ll='exa -lhgF'
alias lst='exa --tree'
alias lt='exa -lahgF --tree'
# ranger alias
alias x='ranger'
