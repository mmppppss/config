#!/bin/sh
# Barra superior (una sola instancia, desacoplado con setsid)
killall -q polybar
polybar-msg cmd quit 2>/dev/null
while pgrep -x polybar >/dev/null; do sleep 0.2; done
setsid -f polybar -c ~/.config/polybar/config.ini main >/dev/null 2>&1