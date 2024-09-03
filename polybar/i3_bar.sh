#!/bin/bash

# Terminate already running bar instances
# If all your bars have IPC enabled, use:
polybar-msg cmd quit

# Otherwise, use the nuclear option:
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Check if xrandr is available
if type "xrandr" > /dev/null 2>&1; then
  # Launch Polybar on each connected monitor
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload example -c ~/.config/polybar/config.ini &
  done
else
  # Fallback to single monitor setup
  polybar --reload example -c ~/.config/polybar/config.ini &
fi

