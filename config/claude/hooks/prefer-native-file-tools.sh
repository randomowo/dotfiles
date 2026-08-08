#!/usr/bin/env bash

set -u

input="$(cat)"
command="$(jq -r '.tool_input.command // empty' <<<"$input")"
[[ -z "$command" ]] && exit 0

deny() {
  printf '%s\n' "$1" >&2
  printf 'If that tool is not in your toolset, it is deferred, not missing: load it with ToolSearch("select:Read,Edit,Write"), then use it. Do not fall back to another shell command.\n' >&2
  exit 2
}

# Quoted spans become one opaque token so their contents cannot look like commands.
stripped="$(perl -0777 -pe "s/'[^']*'/Q/g; s/\"(?:\\\\.|[^\"\\\\])*\"/Q/g" <<<"$command")"

# One segment per line. \x01 marks "reads from a pipe", \x02 marks "writes to a pipe".
segments="$(perl -0777 -pe '
  s/\$\(/\n/g; s/`/\n/g; s/[()]/\n/g; s/[{}]/\n/g;
  s/\|\|/\n/g; s/&&/\n/g; s/;/\n/g;
  s/\|/ \x02\n\x01 /g;
' <<<"$stripped")"

has_heredoc=0
case "$command" in *"<<"*) has_heredoc=1 ;; esac

while IFS= read -r seg; do
  [[ -z "${seg// /}" ]] && continue

  piped_in=0
  pipes_out=0
  case "$seg" in *$'\x01'*) piped_in=1 ;; esac
  case "$seg" in *$'\x02'*) pipes_out=1 ;; esac
  seg="${seg//$'\x01'/}"
  seg="${seg//$'\x02'/}"

  read -ra tok <<<"$seg"
  (( ${#tok[@]} == 0 )) && continue

  saw_sudo=0
  i=0
  while (( i < ${#tok[@]} )); do
    t="${tok[i]}"
    case "$t" in
      sudo|doas) saw_sudo=1; i=$((i + 1)) ;;
      command|builtin|env|nohup|time|exec|xargs|then|else|elif|do|done|fi|if|while|until|for|in|!) i=$((i + 1)) ;;
      -*) i=$((i + 1)) ;;
      *)
        if [[ "$t" =~ ^[A-Za-z_][A-Za-z0-9_]*= ]]; then i=$((i + 1)); else break; fi
        ;;
    esac
  done
  (( i >= ${#tok[@]} )) && continue

  cmd="${tok[i]##*/}"
  args=("${tok[@]:$((i + 1))}")

  operands=()
  has_out_redirect=0
  has_append_redirect=0
  skip_next=0
  for a in ${args[@]+"${args[@]}"}; do
    if (( skip_next )); then skip_next=0; continue; fi
    case "$a" in
      '2>'|'2>>') skip_next=1 ;;
      '2>'*|'&>'*|'>&'*) : ;;
      '>>'|'1>>') has_out_redirect=1; has_append_redirect=1; skip_next=1 ;;
      '>'|'1>'|'&>') has_out_redirect=1; skip_next=1 ;;
      '>>'*|'1>>'*) has_out_redirect=1; has_append_redirect=1 ;;
      '>'*) has_out_redirect=1 ;;
      '<'|'<<'*|'<<<') skip_next=1 ;;
      '<'*) : ;;
      -*) : ;;
      *) operands+=("$a") ;;
    esac
  done

  case "$cmd" in
    cat|bat)
      (( has_append_redirect )) && deny "\`$cmd >>\` appends file content. Use Edit to add to an existing file, or Write to create one."
      (( piped_in || has_heredoc || has_out_redirect )) && continue
      (( ${#operands[@]} == 0 )) && continue
      deny "\`$cmd\` on a file duplicates the Read tool, which shows line numbers, renders images/PDFs/notebooks, and takes offset/limit for large files."
      ;;
    head|tail)
      (( piped_in )) && continue
      for a in ${args[@]+"${args[@]}"}; do
        case "$a" in -f|-F|--follow*) continue 2 ;; esac
      done
      (( ${#operands[@]} == 0 )) && continue
      deny "\`$cmd\` on a file duplicates Read — pass offset/limit to read a slice. \`tail -f\` on a live stream is still fine."
      ;;
    less|more|most)
      deny "\`$cmd\` is an interactive pager and will hang. Use the Read tool."
      ;;
    sed)
      for a in ${args[@]+"${args[@]}"}; do
        case "$a" in
          -i|-i.*|--in-place*)
            deny "\`sed -i\` edits a file in place. Use Edit (exact string replace, \`replace_all\` for every occurrence) or Write for a full rewrite." ;;
        esac
      done
      (( piped_in )) && continue
      (( ${#operands[@]} <= 1 )) && continue
      deny "\`sed\` reading a file to view or extract lines duplicates Read (offset/limit). Pipe command output into sed when you need a real transform."
      ;;
    awk|gawk|mawk)
      (( piped_in )) && continue
      (( ${#operands[@]} <= 1 )) && continue
      deny "\`$cmd\` reading a file duplicates Read. Pipe command output into $cmd when you actually need field processing."
      ;;
    tee)
      (( saw_sudo )) && continue
      (( ${#operands[@]} == 0 )) && continue
      deny "\`tee\` writes file content. Use Write for a new file or Edit to change part of an existing one."
      ;;
    echo|printf)
      (( has_out_redirect )) && deny "Redirecting \`$cmd\` into a file writes file content. Use Write for a new file or Edit to change part of an existing one."
      ;;
  esac
done <<<"$segments"

exit 0
