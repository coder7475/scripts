#!/bin/bash

# Array of branches to keep
KEEP_BRANCHES=("main" "development" "staging")

# Generate regex to match branches to keep
# This matches exact names and common branch patterns like release/* and sprint/*
KEEP_REGEX="^($(IFS='|'; echo "${KEEP_BRANCHES[*]}"))$|^release/.*|^sprint/.*"

echo "Fetching latest changes from remote..."
git fetch --all --prune

echo "Deleting local branches..."
git branch --format='%(refname:short)' | grep -v -E "$KEEP_REGEX" | while read -r branch; do
    echo "Deleting local branch: $branch"
    git branch -D "$branch"
done

echo "Deleting remote branches..."
git for-each-ref --format='%(refname:short)' refs/remotes/origin/ | grep -v '^origin/HEAD' | sed 's|^origin/||' | grep -v -E "$KEEP_REGEX" | while read -r branch; do
    echo "Deleting remote branch: origin/$branch"
    git push origin :"$branch"
done

echo "Pruning remote branches..."
git remote prune origin

echo "✅ Branch cleanup complete."
