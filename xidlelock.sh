# Only exported variables can be used within the timer's command.
export PRIMARY_DISPLAY="$(xrandr | awk '/ connected/ {print $1}' | head -n1)"
export SECONDARY_DISPLAY="$(xrandr | awk '/ connected/ {print $1}' | head -n2 | tail -n1)"

# Run xidlehook
xidlehook \
  `# Don't lock when there's a fullscreen application` \
  --not-when-fullscreen \
  `# Don't lock when there's audio playing` \
  --not-when-audio \
  `# Dim the screen after 600 seconds, undim if user becomes active` \
  --timer 600 \
    'xrandr --output "$PRIMARY_DISPLAY" --brightness .1; xrandr --output "$SECONDARY_DISPLAY" --brightness .1' \
    'xrandr --output "$PRIMARY_DISPLAY" --brightness 1; xrandr --output "$SECONDARY_DISPLAY" --brightness 1' \
  `# Undim & lock after 60 more seconds` \
  --timer 60 \
    'xrandr --output "$PRIMARY_DISPLAY" --brightness 1;xrandr --output "$SECONDARY_DISPLAY" --brightness 1; lock' \
		'' \
  `# Finally, suspend an hour after it locks` \
  --timer 3600 \
    'systemctl suspend' \
    ''
