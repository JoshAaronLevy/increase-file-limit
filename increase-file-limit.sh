#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

sudo cat << HEREDOC > /Library/LaunchDaemons/limit.maxfiles.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>limit.maxfiles</string>
    <key>ProgramArguments</key>
    <array>
      <string>launchctl</string>
      <string>limit</string>
      <string>maxfiles</string>
      <string>51200</string>
      <string>61920</string>
    </array>
    <key>RunAtLoad</key>
    <true />
    <key>ServiceIPC</key>
    <false />
  </dict>
</plist>
HEREDOC

sudo chown root:wheel /Library/LaunchDaemons/limit.maxfiles.plist
sudo chmod 600 /Library/LaunchDaemons/limit.maxfiles.plist
sudo launchctl load -w /Library/LaunchDaemons/limit.maxfiles.plist
launchctl limit maxfiles

# Note: Default limit is 256, huge limits over 8000 may cause RAM problems.
#  So, the following settings were toned down:
#      <string>65535</string>
#      <string>524288</string>
