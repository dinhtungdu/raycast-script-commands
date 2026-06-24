#!/bin/bash -l

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Checkout current GitHub PR
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.author dinhtungdu
# @raycast.authorURL https://raycast.com/dinhtungdu

current_url=$(osascript -e 'tell application "Google Chrome" to get URL of active tab of first window')

# Extract repo and PR number from URLs like:
# https://github.com/woocommerce/woocommerce/pull/12345
# https://github.com/woocommerce/woocommerce/pull/12345/files
if [[ $current_url =~ github\.com/([^/]+)/([^/]+)/pull/([0-9]+) ]]; then
	owner="${BASH_REMATCH[1]}"
	repo="${BASH_REMATCH[2]}"
	pr_number="${BASH_REMATCH[3]}"
else
	echo "No GitHub PR number found in the active Chrome tab."
	exit 1
fi

repo_path="$HOME/workspace/$repo"

if [[ ! -d $repo_path ]]; then
	echo "Local repo not found: $repo_path"
	exit 1
fi

if ! command -v pi >/dev/null 2>&1; then
	echo "pi not found in PATH."
	exit 1
fi

cd "$repo_path" || exit 1

prompt="Use the worktree-pi-session skill. Checkout GitHub PR #$pr_number in a worktree. PR URL: $current_url. Repo: $repo_path. GitHub repo: $owner/$repo."

pi -p "$prompt"
