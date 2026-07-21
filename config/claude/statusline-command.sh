#!/bin/bash
# Claude Code statusLine — mirrors rand.zsh-theme segment order:
#   venv (cyan) | git branch (green=clean, red=dirty ±) | cwd (blue) | status icons
# Input: JSON from Claude Code via stdin

input=$(cat)
cwd=$(echo "$input" | jq -r '.cwd')

# ANSI color helpers (foreground / background / reset)
# $'...' ANSI-C quoting ensures real ESC bytes are stored, so printf '%s' works safely
FG_BLACK=$'\033[30m'
FG_RED=$'\033[31m'
FG_GREEN=$'\033[32m'
FG_YELLOW=$'\033[33m'
FG_BLUE=$'\033[34m'
FG_CYAN=$'\033[36m'
FG_WHITE=$'\033[97m'
BG_CYAN=$'\033[46m'
BG_RED=$'\033[41m'
BG_GREEN=$'\033[42m'
BG_BLUE=$'\033[44m'
BG_YELLOW=$'\033[43m'
BG_MAGENTA=$'\033[45m'
BG_MAGENTA_BRIGHT=$'\033[48;2;236;64;255m'
RESET=$'\033[0m'

parts=()

# --- venv segment (cyan bg, black fg) ---
if [ -n "$VIRTUAL_ENV" ]; then
    venv_name=$(basename "$VIRTUAL_ENV")
    parts+=("${BG_CYAN}${FG_BLACK} ${venv_name} ${RESET}")
fi

# --- git segment (green=clean, red=dirty) ---
branch=$(git -C "$cwd" rev-parse --abbrev-ref HEAD 2>/dev/null)
if [ -n "$branch" ]; then
    dirty=$(git -C "$cwd" status --porcelain --ignore-submodules 2>/dev/null)
    if [ -n "$dirty" ]; then
        parts+=("${BG_RED}${FG_BLACK} ${branch} ± ${RESET}")
    else
        parts+=("${BG_GREEN}${FG_BLACK} ${branch} ${RESET}")
    fi
fi

# --- cwd segment (blue bg, black fg) — basename only, like %c ---
dir_name=$(basename "$cwd")
parts+=("${BG_BLUE}${FG_BLACK} ${dir_name} ${RESET}")

# --- status icons (yellow bg, black fg) — same block style as venv/git/cwd ---
icons=""
# ✘ for non-zero exit (not easily available in statusLine context, skip)
# ⚡ for root
if [ "$(id -u)" -eq 0 ]; then
    icons="${icons}⚡"
fi
if [ -n "$icons" ]; then
    parts+=("${BG_YELLOW}${FG_BLACK} ${icons} ${RESET}")
fi

# --- model name (magenta bg, black fg) — same block style as venv/git/cwd ---
model=$(echo "$input" | jq -r '.model.display_name // empty')
effort=$(echo "$input" | jq -r '.effort.level // empty')
if [ -n "$model" ]; then
    parts+=("${BG_MAGENTA_BRIGHT}${FG_BLACK} ${model} ${RESET}")
fi

# --- effort segment — truecolor gradient background from low (green) to max (magenta) ---
# Mirrors Claude Code's own low→max effort gradient.
effort_bg() {
    case "$1" in
        low)    printf '\033[48;2;76;175;80m'  ;; # green
        medium) printf '\033[48;2;255;193;7m'  ;; # amber
        high)   printf '\033[48;2;255;112;67m' ;; # orange
        xhigh)  printf '\033[48;2;229;57;53m'  ;; # red
        max)    printf '\033[48;2;216;27;96m'  ;; # magenta/pink
        *)      printf '%s' "$BG_MAGENTA"      ;;
    esac
}
if [ -n "$effort" ]; then
    parts+=("$(effort_bg "$effort")${FG_BLACK} ${effort} ${RESET}")
fi

# --- helper: continuous truecolor gradient background based on percent ---
# Usage: pct_bg_color <number>   (float or int)
# 0%   -> green
# 50%  -> bright amber/orange
# 100% -> bright red
# The color brightens and shifts toward red as the value grows.
pct_bg_color() {
    local n=${1%.*}   # truncate decimal part for integer comparison
    n=${n:-0}
    [ "$n" -lt 0 ] && n=0
    [ "$n" -gt 100 ] && n=100

    local r g b t
    if [ "$n" -le 50 ]; then
        t=$n
        r=$(( 76  + (230 - 76)  * t / 50 ))
        g=$(( 175 + (140 - 175) * t / 50 ))
        b=$(( 80  + (40  - 80)  * t / 50 ))
    else
        t=$(( n - 50 ))
        r=$(( 230 + (255 - 230) * t / 50 ))
        g=$(( 140 + (40  - 140) * t / 50 ))
        b=40
    fi
    printf '\033[48;2;%d;%d;%dm' "$r" "$g" "$b"
}

# --- usage segments, styled as blocks like venv/git/cwd ---
usage_parts=()

# --- context usage (bg color reflects threshold, black fg) ---
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
if [ -n "$used" ]; then
    printf_used=$(printf '%.0f' "$used")
    usage_parts+=("$(pct_bg_color "$printf_used")${FG_BLACK} ctx:${printf_used}% ${RESET}")
fi

# --- plan rate-limit usage (5-hour session and 7-day weekly, when available) ---
# Helper: format seconds remaining as Xh Ym or Ym
fmt_remaining() {
    local secs=$1
    [ "$secs" -le 0 ] && echo "0m" && return
    local h=$(( secs / 3600 ))
    local m=$(( (secs % 3600) / 60 ))
    if [ "$h" -gt 0 ]; then
        printf '%dh%dm' "$h" "$m"
    else
        printf '%dm' "$m"
    fi
}

now=$(date +%s)
five_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
five_resets=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
week_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
week_resets=$(echo "$input" | jq -r '.rate_limits.seven_day.resets_at // empty')
if [ -n "$five_pct" ]; then
    five_fmt=$(printf '%.0f' "$five_pct")
    five_left=""
    if [ -n "$five_resets" ]; then
        five_secs=$(( five_resets - now ))
        five_left="($(fmt_remaining "$five_secs"))"
    fi
    usage_parts+=("$(pct_bg_color "$five_fmt")${FG_BLACK} 5h${five_left}:${five_fmt}% ${RESET}")
fi
if [ -n "$week_pct" ]; then
    week_val=$(printf '%.0f' "$week_pct")
    week_left=""
    if [ -n "$week_resets" ]; then
        week_secs=$(( week_resets - now ))
        week_left="($(fmt_remaining "$week_secs"))"
    fi
    usage_parts+=("$(pct_bg_color "$week_val")${FG_BLACK} 7d${week_left}:${week_val}% ${RESET}")
fi

# --- append usage segments, separating them from model/effort ---
if [ ${#usage_parts[@]} -gt 0 ]; then
    parts+=("${usage_parts[@]}")
fi

# Join parts with no separator so blocks sit flush against each other,
# using %s to avoid misinterpreting % in values
printf '%s' "${parts[0]}"
for part in "${parts[@]:1}"; do
    printf '%s' "$part"
done
printf '\n'
