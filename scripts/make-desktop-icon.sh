#!/bin/bash

here=$(cd "$(dirname "$0")"; pwd)
root=$(cd "$here/.."; pwd)

(
  read -r mountpoint
  for size in 16 24 32 48 64 96 128; do
    xdg-icon-resource install --size "$size" "$mountpoint/usr/share/icons/hicolor/${size}x$size/apps/mysql-workbench.png" mysql-workbench
  done
) < <("$(find "$root/dist" -name '*.AppImage' | head -n 1)" --appimage-mount)

xdg-desktop-icon install "$root/resources/mysql-workbench.desktop"
