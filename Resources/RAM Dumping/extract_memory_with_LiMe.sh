#!/bin/bash

# Paths relative to the directory where the script is located
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUT="$DIR/mem.raw"
MOD="$DIR/lime.ko"

echo "[x] Loading LiME module..."
sudo insmod "$MOD" "path=$OUT format=raw"

sleep 5

if [ -f "$OUT" ]; then
  echo "[+] Dump started successfully."
  du -h "$OUT"
else
  echo "[!] ERROR: The file was not created. Try a local path!"
fi
