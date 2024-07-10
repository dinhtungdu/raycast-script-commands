#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Copy current GH issue/PR number to clipboard
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.author dinhtungdu
# @raycast.authorURL https://raycast.com/dinhtungdu

osascript -e 'tell application "Arc" to get URL of active tab of first window' | pbcopy

# Get the issue or PR number from the URL
# Example URL:
# https://github.com/woocommerce/woocommerce/pull/30200
# https://github.com/woocommerce/woocommerce/issues/30200

number=$(pbpaste | sed -E 's/.*\/(pull|issues)\/([0-9]+).*/\2/')

echo $number | pbcopy

echo "Copied $number to clipboard"
