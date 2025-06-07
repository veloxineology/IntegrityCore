#!/system/bin/sh

# Set up environment
MODDIR=${0%/*}
MODID=${MODDIR##*/}
MAGISKTMP="$(magisk --path)" || MAGISKTMP=/sbin
MODULEROOT="$MAGISKTMP/.magisk/modules/$MODID"
MODIDROOT="/data/adb/modules/$MODID"

# Stop running services
pkill -f "zygiskd"
pkill -f "webserver"

# Remove control binaries
rm -f /data/adb/ksu/bin/zygisk-ctl
rm -f /data/adb/ksu/bin/znctl
rm -f /data/adb/ap/bin/zygisk-ctl
rm -f /data/adb/ap/bin/znctl

# Clean up config files
rm -f /data/adb/zygisksu/tango
rm -f /data/adb/zygisksu/auto_umount
rm -f /data/data/com.google.android.gms/cache/pif.prop
rm -f /data/data/com.google.android.gms/pif.prop
rm -f /data/data/com.google.android.gms/cache/pif.json
rm -f /data/data/com.google.android.gms/pif.json

# Remove cleanup script
rm -f /data/adb/service.d/.zn_cleanup.sh

exit 0 