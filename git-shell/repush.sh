#!/bin/bash -e 

HEAD_COMMIT_ID=$(git rev-parse HEAD)
if [[ -n "$HEAD_COMMIT_ID" ]]; then
  git commit --amend --reuse-message="$HEAD_COMMIT_ID"
  git push --force
fi

