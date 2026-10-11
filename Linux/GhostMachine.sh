#!/bin/sh
printf '\033c\033]0;%s\a' GhostMachine
base_path="$(dirname "$(realpath "$0")")"
"$base_path/GhostMachine.x86_64" "$@"
