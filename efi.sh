#!/bin/sh
# https://wiki.alpinelinux.org/wiki/Bootloaders#efibootmgr
# create UEFI boot entry

params="root=/dev/sda2 rootfstype=btrfs rootflags=subvol=@ rw modules=sd-mod,usb-storage,btrfs\
  initrd=\intel-ucode.img \
  initrd=\initramfs-edge"

efibootmgr --create --label "Alpine Linux" \
  --disk /dev/sda --part 1 \
  --loader /vmlinuz-edge \
  --unicode "${params}" \
  --verbose
