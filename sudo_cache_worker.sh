#!/usr/bin/env sh
#sudo_cache_worker.sh

SUDO_CACHE_FILE="/tmp/sudo_cache_${USER}_$$"

_launch_cache_worker() {
    while true; do
        if sudo -vn 2>/dev/null; then
            echo "1" > "$SUDO_CACHE_FILE"
        else
            echo "0" > "$SUDO_CACHE_FILE"
        fi
        sleep 5
    done
}

_launch_cache_worker &
SUDO_CACHE_WORKER_PID=$!
trap "kill $SUDO_CACHE_WORKER_PID 2>/dev/null; [ -f $SUDO_CACHE_FILE ] && rm $SUDO_CACHE_FILE" EXIT
