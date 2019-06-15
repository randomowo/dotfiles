#tmux
#erase history

#hello message
#~/bash/start-screen.sh
start-screen

PATH=/usr/local/opt/ed/libexec/gnubin:/usr/local/opt/ed/libexec/gnubin:/usr/local/opt/ed/libexec/gnubin:/Users/randomowo/.cargo/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin:/usr/local/opt/m4/bin:/usr/local/opt/libressl/bin:/usr/local/opt/file-formula/bin:/usr/local/opt/ruby/bin
eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"

#JAVA_HOME
#JDE 8
#export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_181.jdk/Contents/Home
#JDE 11.0.1
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-11.0.1.jdk/Contents/Home

#RUST HOME SRC 1.30.1
export RUST_SRC_PATH=/usr/local/Cellar/rust/1.30.1/share/rust/rust_src
# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
# Path to dotfiles folder
export DOT=$HOME/dotfiles

ZSH_THEME="nicoulaj"
#kolo, jnrowe, dogenpunk-with-batstat, nicoulaj

plugins=(
    git
)

source $ZSH/oh-my-zsh.sh
# zsh plugins
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh

# ssh to my server
alias sshm="ssh makromant@makromant.myjino.ru"

# get weather in spb
alias wspb="curl wttr.in/spb"
# run dwarf fortress
alias rdf="cd ~/Games/df_osx/ p&& ./df && cd"
alias whereami="curl http://ipinfo.io/"
# wifi
alias wifioff="networksetup -setairportpower airport off"
alias wifion="networksetup -setairportpower airport on"
# tor
alias torOn="networksetup -setsocksfirewallproxystate Wi-Fi on && networksetup -setproxyautodiscovery Wi-Fi on && tor"
alias torOff="networksetup -setsocksfirewallproxystate Wi-Fi off && networksetup -setproxyautodiscovery Wi-Fi off && killall tor"
alias torR="killall tor && tor"
# check size
alias dcap="df -h /"
alias sizeof="du -sh"

alias cleanup="sudo cleanup"

# counting folders and files
alias count="tree | tail -1"
# convert (mp4 > mp3) convert file.mp4 file.mp3
alias convert="ffmpeg -i"
# new mac adress
alias umac="~/./.mac.sh"
# show mac adress
alias mac="ifconfig en0 |grep ether"
# upgrade all python3 packages
alias pipup="pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install -U"
# git aliases
alias git-adog="git log --all --decorate --oneline --graph"
alias git-undo="git reset --hard"
alias git-cc="git reset HEAD~"
alias restart-blue="sudo launchctl stop com.apple.blued && sudo launchctl start com.apple.blued && echo bluetooth module restarted"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

alias cp='cp -g'
alias mv='mv -g'
alias rmtild='rm -rf *~'
alias top='gotop'
alias imgcat='/Users/randomowo/Library/Python/3.7/bin/imgcat'
alias gcc='gcc-9'
