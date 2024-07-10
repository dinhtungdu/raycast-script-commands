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

osascript -e 'tell application "Arc" to get URL of active tab of first window' | pbcopy

# Extract PR number from URL copied to clipboard, the format is like github.com/woocommerce/woocommerce/pull/12345 or github.com/woocommerce/woocommerce/pull/12345/files

# Extract PR number from URL copied to clipboard in macOS
if [[ $(pbpaste) =~ github.com/[^/]+/[^/]+/pull/([0-9]+) ]]; then
	pr_number="${BASH_REMATCH[1]}"
else
	echo "No PR number found in the URL."
	exit 1
fi

# Checkout PR
cd ~/workspace/woocommerce/

# reset pmpm lock file
git checkout -- pnpm-lock.yaml

# Notify if the current branch isn't clean
if [[ $(git status --porcelain) ]]; then
	echo "Please commit or stash your changes before checking out a PR."
	# copy the command to clipboard
	echo "gh pr checkout $pr_number && pnpm i && pnpm run --filter='@woocommerce/plugin-woocommerce' watch:build" | pbcopy
	exit 1
fi

# Fetch PR branch
echo "Checking out PR #$pr_number..."
gh pr checkout $pr_number
echo "Checked out PR #$pr_number."
