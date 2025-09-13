#!/bin/bash

# Variables
DUMP_DIR="/mnt/memdump"  # Directory to store the memory dump
DUMP_FILE="$DUMP_DIR/memdump.raw"  # Output file for the memory dump

# Check if memdump is installed
if ! command -v memdump &> /dev/null; then
    echo "[!] ERROR: memdump is not installed. Please install it first."
    exit 1
fi

# Create dump directory if it doesn't exist
sudo mkdir -p "$DUMP_DIR"

# Capture memory dump
echo "[*] Capturing memory dump..."
sudo memdump -o "$DUMP_FILE"

# Check if the dump was successful
if [ -f "$DUMP_FILE" ]; then
    echo "[+] Memory dump created successfully at $DUMP_FILE"
    du -h "$DUMP_FILE"  # Display the size of the dump file
else
    echo "[!] ERROR: Memory dump was not created."
    exit 1
fi
