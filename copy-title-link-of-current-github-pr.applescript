#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Copy title link of current GitHub PR
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.author dinhtungdu
# @raycast.authorURL https://raycast.com/dinhtungdu

set prUrl to ""
set prTitle to ""

tell application "Arc"
	set prUrl to URL of active tab of front window
  set prTitle to execute active tab of front window javascript "{document.querySelector('.gh-header-title').innerText}"
end tell

# remove quote from prTitle
set prTitle to do shell script "echo " & prTitle & " | sed 's/\"//g'"

my urlToClipboard(prTitle, prUrl)

on urlToClipboard(theTitle, theUrl)
    set rawHTML to "<a href=\"" & theUrl & "\">" & theTitle & "</a>"
    set escapedData to do shell script "echo " & (quoted form of rawHTML) as «class HTML»
    set the clipboard to escapedData
end urlToClipboard
