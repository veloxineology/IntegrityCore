#!/system/bin/sh

# Set up environment
MODDIR=${0%/*}
MODID=${MODDIR##*/}
MAGISKTMP="$(magisk --path)" || MAGISKTMP=/sbin
MODULEROOT="$MAGISKTMP/.magisk/modules/$MODID"
MODIDROOT="/data/adb/modules/$MODID"

# Create necessary directories
mkdir -p "$MODIDROOT/zygisk"
mkdir -p "$MODIDROOT/webroot"

# Copy Play Integrity Fix files
if [ -f "$MODIDROOT/custom.pif.json" ]; then
    cp -f "$MODIDROOT/custom.pif.json" "$MODIDROOT/pif.json"
fi

# Set up Zygisk Next
if [ -f "$MODIDROOT/bin/zygiskd" ]; then
    chmod 755 "$MODIDROOT/bin/zygiskd"
    "$MODIDROOT/bin/zygiskd" &
fi

# Set up Zygisk Assistant
if [ -f "$MODIDROOT/webroot/index.html" ]; then
    # Start web server if needed
    if [ -f "$MODIDROOT/bin/webserver" ]; then
        chmod 755 "$MODIDROOT/bin/webserver"
        "$MODIDROOT/bin/webserver" &
    fi
fi

# Apply Play Integrity Fix
if [ -f "$MODIDROOT/pif.json" ]; then
    # Apply PIF settings
    "$MODIDROOT/bin/pif" "$MODIDROOT/pif.json"
fi

# Set up SELinux rules
if [ -f "$MODIDROOT/sepolicy.rule" ]; then
    magiskpolicy --live --apply "$MODIDROOT/sepolicy.rule"
fi

exit 0 