git diff HEAD --color=always | ( IFS=$'\n' read -r; if [ -n "$REPLY" ]; then ( printf '%s\n' "$REPLY"; cat ) | less --raw-control-chars; fi ) && git add -A && git commit
