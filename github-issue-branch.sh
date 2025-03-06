#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Create Branch for current GitHub Issue
# @raycast.mode compact
# @raycast.packageName Git Tools

# Optional parameters:
# @raycast.icon 🌿
# @raycast.needsConfirmation false

# Get current URL from Arc browser
current_url=$(osascript -e 'tell application "Arc" to get URL of active tab of window 1')

# Extract issue number using grep
issue_number=$(echo "$current_url" | grep -o '/issues/[0-9]\+' | grep -o '[0-9]\+')

if [ -z "$issue_number" ]; then
    echo "No GitHub issue number found in current tab"
    exit 1
fi

# Change to WooCommerce directory
cd ~/workspace/woocommerce || exit 1

# Check if working directory is dirty
if [ -n "$(git status --porcelain)" ]; then
    echo "Working directory is dirty. Please commit or stash changes first."
    exit 1
fi

# Pull latest trunk
git checkout trunk
git pull origin trunk

# Create and checkout new branch
branch_name="fix/$issue_number"
git checkout -b "$branch_name"

echo "Created and switched to branch: $branch_name"