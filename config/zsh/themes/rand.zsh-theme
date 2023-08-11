#!/bin/zsh

# Constants
CURRENT_BG='NONE'
PRIMARY_FG=black
# Characters
SEGMENT_SEPARATOR="\ue0b0"
GITDURTY="\u00b1"
BRANCH="\ue0a0"
DETACHED="\u27a6"
CROSS="\u2718"
LIGHTNING="\u26a1"
GEAR="\u2699"

autoload -Uz vcs_info
zstyle ':vcs_info:*' stagedstr '%F{green}●'
zstyle ':vcs_info:*' unstagedstr '%F{yellow}●'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{11}%r'
zstyle ':vcs_info:*' enable git svn

psegment() {
    local bg fg
    [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
    [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
    if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
        echo -n "%{$bg%F{$CURRENT_BG}%}%{$fg%}"
    else
        echo -n "%{$bg%}%{$fg%}"
    fi
    CURRENT_BG=$1
    [[ -n $3 ]] && echo -n $3
}

pvenv() {
    [ -n "$VIRTUAL_ENV" ] && psegment cyan $PRIMARY_FG " `basename $VIRTUAL_ENV` "
}

pgit() {
    local color ref
    is_dirty() {
        test -n "$(git status --porcelain --ignore-submodules)"
    }
    ref="$vcs_info_msg_0_"
    if [[ -n "$ref" ]]; then
        if is_dirty; then
            color=red
            ref="${ref} $GITDURTY "
        else
            color=green
            ref="${ref} "
        fi
        if [[ "${ref/.../}" == "$ref" ]]; then
            ref="$BRANCH $ref"
        else
            ref="$DETACHED ${ref/.../}"
        fi
        psegment $color $PRIMARY_FG
        print -n " $ref "
    fi
}

pdir() {
    psegment blue $PRIMARY_FG ' %c '
}

ptime() {
    psegment $PRIMARY_FG white " ($(date +'%H:%m')) "
}

pstatus() {
    local symbols
    symbols=()
    [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}$CROSS"
    [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}$LIGHTNING"
    [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}$GEAR"

    [[ -n "$symbols" ]] && psegment $PRIMARY_FG default " $symbols "
}

pend() {
    if [[ -n $CURRENT_BG ]]; then
        echo -n "%{%k%F{$CURRENT_BG}%}"
    else
        echo -n "%{%k%}"
    fi
    echo -n " %{%f%}"
    CURRENT_BG=''
}

pbuild() {
    pvenv
    pgit
    pdir
    RETVAL=$?
    pstatus
    pend
}

pprecmd() {
    vcs_info
    PROMPT='%{%f%b%k%}$(pbuild)'
}

psetup() {
    autoload -Uz add-zsh-hook
    autoload -Uz vcs_info

    prompt_opts=(cr subst percent)
    add-zsh-hook precmd pprecmd

    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' check-for-changes false
    zstyle ':vcs_info:git*' formats '%b'
    zstyle ':vcs_info:git*' actionformats '%b (%a)'

    export VIRTUAL_ENV_DISABLE_PROMPT=1
    #MODE_CURSOR_VIINS="cyan blinking bar"
    #MODE_CURSOR_REPLACE="$MODE_CURSOR_VIINS red"
    #MODE_CURSOR_VICMD="green block"
    #MODE_CURSOR_SEARCH="magenta steady underline"
    #MODE_CURSOR_VISUAL="green underline"
    #MODE_CURSOR_VLINE="$MODE_CURSOR_VISUAL light_green"
}

setopt prompt_subst
psetup "$@"
