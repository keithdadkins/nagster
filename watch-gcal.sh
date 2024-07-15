#!/usr/bin/env bash
DEFAULT_LOOP_INTERVAL_MIN=10
LOOP_INTERVAL=${LOOP_INTERVAL:-$DEFAULT_LOOP_INTERVAL_MIN}
CMD=${1:-gcalcli remind $LOOP_INTERVAL -- \'nagster -e \"Heads Up\" -m \"%s\" --popup\'}
set -eo pipefail
source /Users/keithadkins/.dotfiles/profiles/adhoc-macbook

watchcal() {
  while true; do
    eval "$CMD"
    sleep "$LOOP_INTERVAL"m
  done
}

export -f watchcal

nohup bash -c 'watchcal' > /dev/null 2>&1 &

