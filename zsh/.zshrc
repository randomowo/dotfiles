# zsh config file

export ZSH=$HOME/.oh-my-zsh
PATH=$PATH; export PATH

ZSH_THEME="crunch"
#jnrowe, dogenpunk, nicoulaj, crunch

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
# convert (mp4 > mp3) convert file.mp4 file.mp3
alias convert="ffmpeg -i"
# upgrade all python3 packages
alias pipup="pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install -U"
# git aliases
alias git-adog="git log --all --decorate --oneline --graph"
alias git-undo="git reset --hard"
alias git-cc="git reset HEAD~"
# set up brightness by xbacklight utillity
alias brightness='xbacklight -set $1'
# remove unused packages
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'
# alias for programms
alias rss='canto-curses'
alias irc='weechat'
# clear vim for fast editing large files
alias cvim='sudo vim -u NONE'
