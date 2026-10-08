#!/usr/bin/env bash
set -euo pipefail

herdr_bin="${HERDR_BIN_PATH:-herdr}"
scope="${CLOSE_GUARD_SCOPE:-}"
target="${CLOSE_GUARD_TARGET:-}"
heading="${CLOSE_GUARD_HEADING:-Close $scope?}"
context="${CLOSE_GUARD_CONTEXT:-}"
# One "name<US>title" row per busy pane.
rows="${CLOSE_GUARD_ROWS:-unknown}"
sep=$'\x1f'

case "$scope" in
pane | tab | workspace) ;;
*)
  printf 'Close Guard: unknown scope %q.\n' "$scope" >&2
  exit 1
  ;;
esac

if [[ -z "$target" ]]; then
  printf 'Close Guard: no target %s was provided.\n' "$scope" >&2
  exit 1
fi

bold='' dim='' accent='' reset=''
if [[ -t 1 ]]; then
  bold=$'\e[1m' dim=$'\e[2m' accent=$'\e[1;31m' reset=$'\e[0m'
  printf '\e[?25l'
  trap 'printf "\e[?25h"' EXIT
fi

# Measure and truncate in characters, not bytes, even when the popup did not
# inherit a UTF-8 locale. A failed switch leaves the locale unchanged.
probe='é'
for locale in C.UTF-8 en_US.UTF-8; do
  ((${#probe} == 1)) && break
  { LC_ALL="$locale"; } 2>/dev/null
done

# One stty call instead of two tput calls; process starts are slow here.
lines="${LINES:-}"
cols="${COLUMNS:-}"
if [[ -z "$lines" || -z "$cols" ]]; then
  read -r lines cols <<<"$(stty size 2>/dev/null || true)" || true
fi
[[ "$lines" =~ ^[0-9]+$ ]] || lines=24
[[ "$cols" =~ ^[0-9]+$ ]] || cols=80

# Leave room for the heading, context, blank lines and the key hint.
max_rows=$((lines - 5))
((max_rows < 1)) && max_rows=1

name_width=0
row_count=0
while IFS="$sep" read -r name _; do
  ((${#name} > name_width)) && name_width=${#name}
  row_count=$((row_count + 1))
done <<<"$rows"
((name_width > 16)) && name_width=16
title_width=$((cols - name_width - 5))

printf ' %s%s%s\n' "$bold" "$heading" "$reset"
[[ -n "$context" ]] && printf ' %s%s%s\n' "$dim" "$context" "$reset"
printf '\n'

shown=0
while IFS="$sep" read -r name title; do
  if ((row_count > max_rows && shown == max_rows - 1)); then
    printf '   %s+ %d more%s\n' "$dim" $((row_count - shown)) "$reset"
    break
  fi
  ((${#name} > name_width)) && name="${name:0:name_width-1}…"
  ((title_width > 0 && ${#title} > title_width)) && title="${title:0:title_width-1}…"
  printf '   %-*s  %s%s%s\n' "$name_width" "$name" "$dim" "$title" "$reset"
  shown=$((shown + 1))
done <<<"$rows"

printf '\n %sy%s close  %s·%s  any other key cancels' "$accent" "$reset" "$dim" "$reset"

answer=''
IFS= read -r -s -n 1 answer || true
printf '\n'

case "$answer" in
y | Y)
  # The target may have closed on its own while the prompt was open.
  "$herdr_bin" "$scope" close "$target" >/dev/null 2>&1 || true
  ;;
*) ;;
esac
