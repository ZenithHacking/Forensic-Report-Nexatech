#!/bin/bash

DEVICE="/dev/sdb"
PART="${DEVICE}1"
MOUNT_POINT="/mnt/ramdump_usb"

# Check if the partition already exists
if [ ! -b "$PART" ]; then
    echo "[*] Creating a primary partition on $DEVICE..."
    echo -e "o\nn\np\n1\n\n\nw" | sudo fdisk "$DEVICE"
    sleep 2
    sudo partprobe
fi

# Format if it is not already ext4
FS_TYPE=$(sudo blkid -o value -s TYPE "$PART" 2>/dev/null)
if [ "$FS_TYPE" != "ext4" ]; then
    echo "[*] Formatting $PART as ext4..."
    sudo mkfs.ext4 "$PART"
fi

# Create mount directory
sudo mkdir -p "$MOUNT_POINT"

# Mount
echo "[*] Mounting $PART on $MOUNT_POINT..."
sudo mount "$PART" "$MOUNT_POINT"

# Check if it was successful
if mountpoint -q "$MOUNT_POINT"; then
    echo "[+] Mount complete! RAM dump possible at:"
    echo "    $MOUNT_POINT/mem.lime"
else
    echo "[!] ERROR mounting the disk!"
    exit 1
fi
