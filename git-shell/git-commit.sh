#!/bin/sh

gum style \
	--foreground 212 --border-foreground 212 \
	--align center --width 50 --margin "1 2" --padding "2 4" \
	'Life is Goood' 'Commit Manager'

if [ -z "$(git status -s -uno | grep -v '^ ' | awk '{print $2}')" ]; then
    gum confirm "Stage all?" && git add .
fi

TYPE=$(gum choose "fix" "feat" "docs" "style" "refactor" "test" "chore" )
SCOPE=$(gum input --placeholder "scope")

# Since the scope is optional, wrap it in parentheses if it has a value.
test -n "$SCOPE" && SCOPE="($SCOPE)"

# Pre-populate the input with the type(scope): so that the user may change it
SUMMARY=$(gum input --width 50 --value "$TYPE$SCOPE: " --placeholder "Summary of this change")
DESCRIPTION=$(gum write --width 80 --placeholder "Details of this change (CTRL+D to finish)")

# Commit these changes
gum confirm "Commit changes?" && git commit -m "$SUMMARY" -m "$DESCRIPTION"
gum spin --spinner minidot --title "Creating a message..." -- sleep 3

