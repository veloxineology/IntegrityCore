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

# Extract core files
ui_print "• Extracting core files..."
unzip -o "$ZIPFILE" 'common/*' -d "$MODPATH" >&2
unzip -o "$ZIPFILE" 'core/*' -d "$MODPATH" >&2
unzip -o "$ZIPFILE" 'modules/*' -d "$MODPATH" >&2

# Create necessary directories
ui_print "• Creating directories..."
mkdir -p "$MODPATH/bin"
mkdir -p "$MODPATH/lib"
mkdir -p "$MODPATH/zygisk"
mkdir -p "$MODPATH/webroot"
mkdir -p "$MODPATH/temp"

# Extract and install Zygisk Next
ui_print "• Installing Zygisk Next..."
unzip -o "$MODPATH/modules/Zygisk-Next-1.2.9-521-e73dbfc-release.zip" -d "$MODPATH/temp/zygisk_next" >&2
cp -rf "$MODPATH/temp/zygisk_next/common"/* "$MODPATH/"
cp -rf "$MODPATH/temp/zygisk_next/core"/* "$MODPATH/core/"

# Extract and install Zygisk Assistant
ui_print "• Installing Zygisk Assistant..."
unzip -o "$MODPATH/modules/Zygisk-Assistant-v2.1.4-1013f8a-release.zip" -d "$MODPATH/temp/zygisk_assistant" >&2
cp -rf "$MODPATH/temp/zygisk_assistant/common"/* "$MODPATH/"
cp -rf "$MODPATH/temp/zygisk_assistant/core"/* "$MODPATH/core/"

# Copy script files
ui_print "• Copying script files..."
cp -f "$MODPATH/common/customize.sh" "$MODPATH/customize.sh"
cp -f "$MODPATH/common/post-fs-data.sh" "$MODPATH/post-fs-data.sh"
cp -f "$MODPATH/common/service.sh" "$MODPATH/service.sh"
cp -f "$MODPATH/common/uninstall.sh" "$MODPATH/uninstall.sh"
cp -f "$MODPATH/common/update-binary" "$MODPATH/update-binary"
cp -f "$MODPATH/common/updater-script" "$MODPATH/updater-script"
cp -f "$MODPATH/common/cleanup.sh" "$MODPATH/cleanup.sh"
cp -f "$MODPATH/common/common_setup.sh" "$MODPATH/common_setup.sh"
cp -f "$MODPATH/common/autopif2.sh" "$MODPATH/autopif2.sh"
cp -f "$MODPATH/common/action.sh" "$MODPATH/action.sh"
cp -f "$MODPATH/common/killpi.sh" "$MODPATH/killpi.sh"
cp -f "$MODPATH/common/migrate.sh" "$MODPATH/migrate.sh"

# Copy configuration files
ui_print "• Copying configuration files..."
cp -f "$MODPATH/common/example.pif.json" "$MODPATH/example.pif.json"
cp -f "$MODPATH/common/example.app_replace.list" "$MODPATH/example.app_replace.list"
cp -f "$MODPATH/common/module.prop" "$MODPATH/module.prop"
cp -f "$MODPATH/common/sepolicy.rule" "$MODPATH/sepolicy.rule"
cp -f "$MODPATH/common/README.md" "$MODPATH/README.md"

# Copy binary files
ui_print "• Copying binary files..."
cp -f "$MODPATH/core/mazoku" "$MODPATH/mazoku"
cp -f "$MODPATH/core/machikado.*" "$MODPATH/"
cp -f "$MODPATH/core/classes.dex" "$MODPATH/classes.dex"

# Copy webroot files
ui_print "• Copying web interface files..."
cp -rf "$MODPATH/core/webroot/*" "$MODPATH/webroot/"

# Copy architecture-specific files
ui_print "• Copying architecture-specific files..."
ARCH=$(getprop ro.product.cpu.abi)
case "$ARCH" in
  arm64-v8a)
    cp -f "$MODPATH/core/bin/arm64-v8a/zygiskd" "$MODPATH/bin/zygiskd"
    cp -f "$MODPATH/core/lib/arm64-v8a/libzygisk.so" "$MODPATH/lib/libzygisk.so"
    cp -f "$MODPATH/core/lib/arm64-v8a/libzn_loader.so" "$MODPATH/lib/libzn_loader.so"
    cp -f "$MODPATH/core/lib/arm64-v8a/libpayload.so" "$MODPATH/lib/libpayload.so"
    cp -f "$MODPATH/core/zygisk/arm64-v8a.so" "$MODPATH/zygisk/zygisk.so"
    ;;
  armeabi-v7a)
    cp -f "$MODPATH/core/bin/armeabi-v7a/zygiskd" "$MODPATH/bin/zygiskd"
    cp -f "$MODPATH/core/lib/armeabi-v7a/libzygisk.so" "$MODPATH/lib/libzygisk.so"
    cp -f "$MODPATH/core/lib/armeabi-v7a/libzn_loader.so" "$MODPATH/lib/libzn_loader.so"
    cp -f "$MODPATH/core/lib/armeabi-v7a/libpayload.so" "$MODPATH/lib/libpayload.so"
    cp -f "$MODPATH/core/zygisk/armeabi-v7a.so" "$MODPATH/zygisk/zygisk.so"
    ;;
  x86)
    cp -f "$MODPATH/core/bin/x86/zygiskd" "$MODPATH/bin/zygiskd"
    cp -f "$MODPATH/core/lib/x86/libzygisk.so" "$MODPATH/lib/libzygisk.so"
    cp -f "$MODPATH/core/lib/x86/libzn_loader.so" "$MODPATH/lib/libzn_loader.so"
    cp -f "$MODPATH/core/lib/x86/libpayload.so" "$MODPATH/lib/libpayload.so"
    cp -f "$MODPATH/core/zygisk/x86.so" "$MODPATH/zygisk/zygisk.so"
    ;;
  x86_64)
    cp -f "$MODPATH/core/bin/x86_64/zygiskd" "$MODPATH/bin/zygiskd"
    cp -f "$MODPATH/core/lib/x86_64/libzygisk.so" "$MODPATH/lib/libzygisk.so"
    cp -f "$MODPATH/core/lib/x86_64/libzn_loader.so" "$MODPATH/lib/libzn_loader.so"
    cp -f "$MODPATH/core/lib/x86_64/libpayload.so" "$MODPATH/lib/libpayload.so"
    cp -f "$MODPATH/core/zygisk/x86_64.so" "$MODPATH/zygisk/zygisk.so"
    ;;
esac

# Set permissions
ui_print "• Setting permissions..."
chmod 755 "$MODPATH"/*.sh
chmod 755 "$MODPATH/mazoku"
chmod 755 "$MODPATH/machikado.*"
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
rm -rf "$MODPATH/common"
rm -rf "$MODPATH/core"
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