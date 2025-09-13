#!/bin/bash

MOUNT_POINT="/mnt/ramdump_usb"

echo "[*] Unmounting $MOUNT_POINT..."
sudo umount "$MOUNT_POINT"

if [ $? -eq 0 ]; then
    echo "[+] Unmount successful."
else
    echo "[!] Something went wrong while unmounting."
fi
