#!/bin/sh

# Get the branch name
branch_name=$(git rev-parse --abbrev-ref HEAD)

# Extract issue key pattern (e.g., IN-102 from IN-102-add-precommit-checks-for-jsonnet)
issue_key=$(echo "$branch_name" | grep -oE '^[A-Z]+[_-][0-9]+' | tr '_' '-')

# if issue key is not found, exit
[ -z "$issue_key" ] && exit 0

# Get the commit message file
commit_msg_file=$1

# Read the current commit message
commit_msg=$(cat "$commit_msg_file")

# Check if commit message already contains the issue key at the start
echo "$commit_msg" | grep -q "^\[$issue_key\]" || echo "[$issue_key] $commit_msg" > "$commit_msg_file"
