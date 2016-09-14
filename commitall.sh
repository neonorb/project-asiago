#!/bin/bash

cd ../aura      && git diff --color=always | ( IFS=$'\n' read -r; if [ -n "$REPLY" ]; then ( printf '%s\n' "$REPLY"; cat ) | less --raw-control-chars; fi ) && git add -A && git commit
cd ../make-base && git diff --color=always | ( IFS=$'\n' read -r; if [ -n "$REPLY" ]; then ( printf '%s\n' "$REPLY"; cat ) | less --raw-control-chars; fi ) && git add -A && git commit
cd ../mish      && git diff --color=always | ( IFS=$'\n' read -r; if [ -n "$REPLY" ]; then ( printf '%s\n' "$REPLY"; cat ) | less --raw-control-chars; fi ) && git add -A && git commit
cd ../feta      && git diff --color=always | ( IFS=$'\n' read -r; if [ -n "$REPLY" ]; then ( printf '%s\n' "$REPLY"; cat ) | less --raw-control-chars; fi ) && git add -A && git commit

echo ""
