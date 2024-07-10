#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Build WooCommerce GitHub URL from issue/PR number
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.author dinhtungdu
# @raycast.authorURL https://raycast.com/dinhtungdu

echo "https://github.com/woocommerce/woocommerce/issues/$(pbpaste)" | pbcopy

echo "Copied the URL to clipboard."
