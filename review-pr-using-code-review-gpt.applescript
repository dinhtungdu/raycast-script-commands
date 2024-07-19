#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Review PR using Code Review GPT
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.author dinhtungdu
# @raycast.authorURL https://raycast.com/dinhtungdu

# Get current PR URL opening in browser
set prUrl to ""
tell application "Arc"
	set prUrl to URL of active tab of front window
end tell

set prompt to "Please perform a comprehensive performance and security review of the linked PR. Check for any potential performance issues and security vulnerabilities. If there are potential performance improvement, explain the issue in detail and suggest the fix. If there are potential risks, describe these vulnerabilities in detail, explain their implications, and suggest why the PR should not be merged until these issues are addressed. You don't need to tell me about the code change that is soley for changelog updates, that part is on every PR for our automated changelog generator. If you find any security concerns rate them low, medium, or high."

# Append prUrl to the prompt
set prompt to prompt & "\n" & prUrl

# copy prompt to clipboard
do shell script "echo " & quoted form of prompt & " | pbcopy"

# Open Code Review GPT in the Arc browser which is Chromium based
tell application "Arc" # Use full application name here like "Google Chrome"
	activate
	tell front window
    make new tab with properties {URL:"https://chatgpt.com/g/g-GzQFVzwC2-code-review"}
	end tell

  # Wait for the textarea with id prompt-textarea to be loaded
  repeat 5 times
    delay 1
    set isFocused to execute active tab of front window javascript "{document.getElementById('prompt-textarea') !== null}"
    if isFocused is true then
        exit repeat
    end if
  end repeat

  # Paste the prompt to the active input
  tell application "System Events"
    keystroke "v" using {command down}
    key code 36 # Enter
  end tell
end tell
