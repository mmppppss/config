#!/usr/bin/env bash
# toggle: panel-calendario acoplado a la barra (continúa visual el polybar)
SCRIPT="$HOME/.config/scripts/calpanel.py"
PIDFILE=/tmp/calpanel.pid

if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
    kill "$(cat "$PIDFILE")" 2>/dev/null
    rm -f "$PIDFILE"
else
    pgrep -f "$SCRIPT" >/dev/null 2>&1 && pgrep -f "$SCRIPT" | xargs -r kill 2>/dev/null
    python3 "$SCRIPT" >/dev/null 2>&1 &
    echo $! > "$PIDFILE"
fi