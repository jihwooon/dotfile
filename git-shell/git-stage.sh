#!/bin/bash

gum style \
--foreground 212 --border-foreground 212 \
--align center --width 50 --margin "1 2" --padding "2 4" \
'Bubble Gum' 'Status Manager'

ADD="Add"
RESET="Reset"
STAGED="Staged"
RESETSOFT="Reset-soft"

ACTION=$(gum choose "$ADD" "$STAGED" "$RESET" "$RESETSOFT")

if [ "$ACTION" == "$ADD" ]; then
    git status --short | cut -c 4- | gum choose --no-limit | xargs git add
elif [ "$ACTION" == "$RESET" ]; then
    git status --short | cut -c 4- | gum choose --no-limit | xargs git restore
elif [ "$ACTION" == "$STAGED" ]; then
    git status --short | cut -c 4- | gum choose --no-limit | xargs git restore --staged
elif [ "$ACTION" == "$RESETSOFT" ]; then    
  git status --short | cut -c 4- | gum choose --no-limit | xargs git reset --soft HEAD\^
else
    echo "Please pass a build distribution type"
fi

