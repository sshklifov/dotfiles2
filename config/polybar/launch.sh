#!/bin/bash

#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Start on all monitors
primary=$(xrandr --query | grep primary | cut -d ' ' -f 1)
for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    if [[ "$m" == "$primary" ]]; then
        MONITOR=$m TRAY_POSITION=right polybar top &
    else
        MONITOR=$m TRAY_POSITION=none polybar top &
    fi
done
