#!/system/bin/sh

# IntegrityCore - Combined Module
# By Kaushik (@veloxineology)

# Print module info
ui_print " "
ui_print "╔═══════════════════════════════════════════════════════════════════════╗"
ui_print "║                                                                       ║"
ui_print "║                     IntegrityCore - Combined Module                    ║"
ui_print "║                                                                       ║"
ui_print "║                     Version: v3.0                                      ║"
ui_print "║                     Author: Kaushik (@veloxineology)                   ║"
ui_print "║                                                                       ║"
ui_print "╚═══════════════════════════════════════════════════════════════════════╝"
ui_print " "

# Print credits
ui_print "╔═══════════════════════════════════════════════════════════════════════╗"
ui_print "║                                                                       ║"
ui_print "║                             Credits                                   ║"
ui_print "║                                                                       ║"
ui_print "║  • Play Integrity Fork v13 by osm0sis                                 ║"
ui_print "║  • Zygisk Next v1.2.9 by Dr-TSNG                                      ║"
ui_print "║  • Zygisk Assistant v2.1.4 by snake-4                                 ║"
ui_print "║                                                                       ║"
ui_print "╚═══════════════════════════════════════════════════════════════════════╝"
ui_print " "

# Extract module files
ui_print "• Extracting module files..."
unzip -o "$ZIPFILE" 'modules/*' -d "$MODPATH" >&2

# Create temporary directory
ui_print "• Creating temporary directory..."
mkdir -p "$MODPATH/temp"

# Install Zygisk Next
ui_print "• Installing Zygisk Next..."
unzip -o "$MODPATH/modules/Zygisk-Next-1.2.9-521-e73dbfc-release.zip" -d "$MODPATH/temp/zygisk_next" >&2
cp -rf "$MODPATH/temp/zygisk_next/common"/* "$MODPATH/"
cp -rf "$MODPATH/temp/zygisk_next/core"/* "$MODPATH/core/"

# Install Zygisk Assistant
ui_print "• Installing Zygisk Assistant..."
unzip -o "$MODPATH/modules/Zygisk-Assistant-v2.1.4-1013f8a-release.zip" -d "$MODPATH/temp/zygisk_assistant" >&2
cp -rf "$MODPATH/temp/zygisk_assistant/common"/* "$MODPATH/"
cp -rf "$MODPATH/temp/zygisk_assistant/core"/* "$MODPATH/core/"

# Set permissions
ui_print "• Setting permissions..."
chmod 755 "$MODPATH"/*.sh
chmod 755 "$MODPATH/bin/zygiskd"
chmod 755 "$MODPATH/lib"/*.so
chmod 755 "$MODPATH/zygisk"/*.so

# Create system directories for Zygisk Next
ui_print "• Setting up Zygisk Next..."
mkdir -p /data/adb/ksu/bin
mkdir -p /data/adb/ap/bin

# Install Zygisk Next binary
cp "$MODPATH/bin/zygiskd" /data/adb/ksu/bin/zygiskd
cp "$MODPATH/bin/zygiskd" /data/adb/ap/bin/zygiskd
chmod 755 /data/adb/ksu/bin/zygiskd
chmod 755 /data/adb/ap/bin/zygiskd

# Create system-wide symlink
ln -sf /data/adb/ksu/bin/zygiskd /system/bin/zygiskd

# Set up SELinux rules
if [ -f "$MODPATH/sepolicy.rule" ]; then
  ui_print "• Setting up SELinux rules..."
  $MODPATH/sepolicy.rule
fi

# Cleanup
ui_print "• Cleaning up..."
rm -rf "$MODPATH/temp"
rm -rf "$MODPATH/modules"

# Installation complete
ui_print " "
ui_print "╔═══════════════════════════════════════════════════════════════════════╗"
ui_print "║                                                                       ║"
ui_print "║                     Installation Complete!                            ║"
ui_print "║                                                                       ║"
ui_print "║  Please reboot your device to activate the module.                    ║"
ui_print "║  Access the web interface at http://localhost:8080                    ║"
ui_print "║                                                                       ║"
ui_print "╚═══════════════════════════════════════════════════════════════════════╝"
ui_print " " 
