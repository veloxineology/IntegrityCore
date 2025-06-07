#!/system/bin/sh

# Set up environment
MODDIR=${0%/*}
MODID=${MODDIR##*/}
MAGISKTMP="$(magisk --path)" || MAGISKTMP=/sbin
MODULEROOT="$MAGISKTMP/.magisk/modules/$MODID"
MODIDROOT="/data/adb/modules/$MODID"

# Start Zygisk Next daemon
if [ -f "$MODIDROOT/bin/zygiskd" ]; then
    "$MODIDROOT/bin/zygiskd" &
fi

# Start web server for Zygisk Assistant
if [ -f "$MODIDROOT/bin/webserver" ]; then
    "$MODIDROOT/bin/webserver" &
fi

# Monitor and restart services if needed
while true; do
    # Check Zygisk Next
    if ! pgrep -f "zygiskd" > /dev/null; then
        "$MODIDROOT/bin/zygiskd" &
    fi

    # Check web server
    if ! pgrep -f "webserver" > /dev/null; then
        "$MODIDROOT/bin/webserver" &
    fi

    sleep 60
done 