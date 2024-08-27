#! /bin/sh

GIT_COLOR="#9353d3"
BRANCH_COLOR="#f31260"
PULL_REQUEST_COLOR="#f5a524"
SUCESS_COLOR="#17c964" FOREGROUND_COLOR="#ecedee"

branch_colro_text () { 
  gum style --foreground "$BRANCH_COLOR" "$1"
}

git_color_text () {
  gum style --foreground "$GIT_COLOR" "$1"
}

pull_list_text () {
  gum style --foreground "$PULL_REQUEST_COLOR" "$1"
}
success_color_text () { gum style --foreground "$SUCESS_COLOR" "$1"
}

foreound_color_text() {
  gum style --foreground "$FOREGROUND_COLOR" "$1" 
}

successful_completion_text() {
  emojis=("🚀" "🌟" "😎" "✨" "💫" "👍" "🎉" "🌙")
  RAND_EMOJI_N=$(( $RANDOM % ${#emojis[@]} + 1))
  echo "$(success_color_text 'Successful!') ${emojis[$RAND_EMOJI_N]} "
}

get_branches () {
  if [ ${1+x} ]; then
    gum choose --selected.foreground="$GIT_COLOR" --limit=1 $(git branch --format="%(refname:short)")
  else
    gum choose --selected.foreground="$GIT_COLOR" --no-limit $(git branch --format="%(refname:short)")
  fi
}

LOGIN_INFO="$(gh api graphql -f query='
    query {
      viewer {
      login
    }
  }'
)"
LOGIN=$(echo $LOGIN_INFO | jq -r '.data.viewer.login')
git rev-parse --git-dir > /dev/null 2>&1

if [ $? -ne 0 ];
then
  echo "$(git_color_text "!!") Must be run in a $(git_color_text "git") repo" 
  exit 1
fi

PR_ID="$(gh pr list --json number --limit 3 | jq -r '.[] | "\u001b[01m#\(.number)"')"
PR_AUTHOR="$(gh pr list --json author --limit 3 | jq -r '.[] | "\u001b[1;32m@\(.author.login)"')"
PR_HEAD_NAME="$(gh pr list --json headRefName --limit 3 | jq -r '.[] | "\u001b[0m \(.headRefName)"')"
PR_UPDATE_AT="$(gh pr list --json updatedAt --limit 3 | jq -r '.[] | "\u001b[0m \(.updatedAt | strptime("%Y-%m-%dT%H:%M:%SZ") | strftime("%Y-%m-%d %H:%M:%S"))"')"
PR_INFO="$(gh pr list --json number,author,headRefName,updatedAt --limit 3 --search "is:open sort:updated-desc" | jq -r '.[] | "\u001b[01m#\(.number)\u001b[0m \(.headRefName) \u001b[1;32m@\(.author.login)\u001b[0m \(.updatedAt | strptime("%Y-%m-%dT%H:%M:%SZ") | strftime("%Y-%m-%d %H:%M:%S"))"')"

gum style \
  --margin "1 1" \
  --padding "1 1" \
  --align center \
  --bold \
  --border-foreground "$GIT_COLOR" \
  "$(git_color_text 'Git') Pal✨"

text="Hello, $LOGIN"
echo "$text" | lolcat -a -d 24
echo "How can I help you?"

echo ""
echo "$(pull_list_text "Recent Pull Request"):"
echo "$PR_INFO"

echo ""
branches=$(get_branches)
echo "Choose $(git_color_text 'branches') to operate on: "

#echo "Switch to $(branch_colro_text "$branches")"
#git switch "$branches"

echo ""
echo "Current $(git_color_text "Branch"): $(branch_colro_text "$branches")"
echo ""
echo "Choose a $(git_color_text "command"):"
command=$(gum choose --cursor.foreground="$GIT_COLOR" add commit-auto commit push rebase delete repush branch reset restore cache exit)

echo $branches | tr " " "\n" | while read -r branch
do
  case $command in
    branch)
      create_branch=$(gum input --placeholder "Generate")
      git switch -c "$create_branch"
      ;;
    reset)
      git reset --soft HEAD\^
      ;;
    add)
      git status --short | cut -c 4- | gum choose --no-limit | xargs git add
      git diff --staged | pbcopy 
      echo "$(successful_completion_text)"
      ;;
    push)
      git push origin $(git rev-parse --abbrev-ref HEAD) && echo "$(successful_completion_text)"
      ;;
    rebase)
      git fetch origin
      git rebase "origin/main" && echo "$(successful_completion_text)"
      ;;
    delete)
      base_branch=$(get_branches 1)
      git switch main
      git branch -d $(git branch --merged | grep -v '\\<main\\>')
      ;;
    repush)
      HEAD_COMMIT_ID=$(git rev-parse HEAD)
      if [[ -n "$HEAD_COMMIT_ID" ]]; then
      git commit --amend --reuse-message="$HEAD_COMMIT_ID"
      git push --force
      fi
      echo "$(successful_completion_text)"
      ;;
    commit-auto)
      git add .
      git commit
      echo "$(successful_completion_text)"
      ;; 
    commit)
      if [ -z "$(git status -s -uno | grep -v '^ ' | awk '{print $2}')" ]; then
        gum confirm "Stage all?" && git status --short | cut -c 4- | gum choose --no-limit | xargs git add
      fi
      TYPE=$(gum choose "fix" "feat" "docs" "style" "refactor" "test" "chore" )
      SCOPE=$(gum input --placeholder "scope")

      test -n "$SCOPE" && SCOPE="($SCOPE)"

      SUMMARY=$(gum input --width 50 --value "$TYPE$SCOPE: " --placeholder "Summary of this change")
      DESCRIPTION=$(gum write --width 80 --placeholder "Details of this change (CTRL+D to finish)")
      gum confirm "Commit changes?" && git commit -m "$SUMMARY" -m "$DESCRIPTION"
      gum spin --spinner minidot --title "Creating a message..." -- sleep 3 && echo "$(successful_completion_text)" 
      ;;
    restore)
      git restore --staged .
      git restore . && echo "$(successful_completion_text)"
      ;;
    cache)
      git rm -r --cached . && echo "$(successful_completion_text)"
      ;;
    exit)
      exit 0
      ;;
  esac
done
