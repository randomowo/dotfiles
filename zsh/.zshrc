# zsh config file

export ZSH=$HOME/.oh-my-zsh
PATH=$PATH; export PATH
export LC_ALL=en_US.UTF-8

ZSH_THEME="crunch"
#jnrowe, dogenpunk, nicoulaj, crunch

plugins=(
    git
    zsh-syntax-highlighting
    zsh-history-substring-search
)

source $ZSH/oh-my-zsh.sh
# zsh plugins

# ssh to my server
alias sshm="ssh makromant@makromant.myjino.ru"

# get weather in spb
alias wspb="curl wttr.in/spb"
# run dwarf fortress
alias whereami="curl http://ipinfo.io/"
# check size
alias dcap="df -h /"
alias sizeof="du -sh"
alias cleanup="sudo cleanup"

# counting folders and files
alias count="tree | tail -1"
# convert (mp4 > mp3) convert file.mp4 file.mp3
alias convert="ffmpeg -i"
# upgrade all python3 packages
alias pipup="pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install -U"
# git aliases
alias git-adog="git log --all --decorate --oneline --graph"
alias git-undo="git reset --hard"
alias git-cc="git reset HEAD~"
alias top='gotop'
alias brightness='xbacklight -set $1'
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'
TERM=xterm-color
