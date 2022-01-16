#!/bin/bash
# create mkinitcpio
echo "MODULES=(btrfs) \
BINARIES=() \
FILES=() \
HOOKS=(base udev autodetect modconf block filesystems keyboard keymap encrypt lvm2 filesystems fsck)" > /etc/mkinitcpio.conf
pacman --noconfirm -S grub
grub-install --target=i386-pc --force /dev/vda
grub-mkconfig -o /boot/grub/grub.cfg
mkinitcpio -P
passwd
exit