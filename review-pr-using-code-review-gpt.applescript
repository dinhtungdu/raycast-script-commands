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

set prompt to "Please perform a comprehensive performane and security review of the linked PR. Check for any potential performance issues and security vulnerabilities. If there are potential performance improvement, explain the issue in detail and suggest the fix. If there are potential risks, describe these vulnerabilities in detail, explain their implications, and suggest why the PR should not be merged until these issues are addressed. You don't need to tell me about the code change that is soley for changelog updates, that part is on every PR for our automated changelog generator. If you find any security concerns rate them low, medium, or high."

# Append prUrl to the prompt
set prompt to prompt & "\n" & prUrl

# copy prompt to clipboard
do shell script "echo " & quoted form of prompt & " | pbcopy"

# Open Code Review GPT in the Arc browser which is Chromium based
tell application "Arc"
	activate
	open location "https://chatgpt.com/g/g-GzQFVzwC2-code-review"
	delay 2
	# Paste the prompt to the active input
	tell application "System Events"
		keystroke "v" using {command down}
		key code 36 # Enter
	end tell
end tell
