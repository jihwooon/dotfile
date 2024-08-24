#!/bin/bash
set -e

# GitHub CLI command to list pull requests
PR_INFO="$(gh pr list --json number,title,labels,createdAt,author,url \
  | jq -r '.[] | "\u001b[31m#\(.number) \u001b[37m \(.title) \u001b[36m\(.labels[0].name) \u001b[33m \(.createdAt | strptime("%Y-%m-%dT%H:%M:%SZ") | strftime("%Y-%m-%d %H:%M:%S")) \u001b[1;32m<\(.author.login)>\u001b[0m \(.url) "' \
  | fzf --ansi --height=80% --layout=reverse --info=inline --prompt='Choose this pull request:')"

PR_URL=$(echo "$PR_INFO" | grep -oE 'https://github\.com/\S+')

open $PR_URL
echo "opening $PR_URL in your browser."

