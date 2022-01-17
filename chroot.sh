#!/bin/bash
if [ -e /dev/vda ]
then
    DEV=/dev/vda
else
    DEV=/dev/sda
fi
pacman --noconfirm -S grub
# install grub
grub-install --target=i386-pc --force $DEV
grub-mkconfig -o /boot/grub/grub.cfg
passwd
# remove all the useless stuf
cd /usr/share
rm -rf kb iana-etc zoneinfo file info man gettext doc gtk-doc hwdata bash-completion zsh makepkg pixmaps glib-2.0 licenses gir-1.0 zoneinfo-leaps audit readline vala icu gettext nano fish factory aclocal
find locale ! -name en_US -delete
rm -rf /boot/initramfs-linux-hardened-fallback.img
find i18n/locales ! -name en_US -delete
cd /usr/bin
rm -rf fsck.ext2 fsck.ext3
rm -rf /var/cache
rm -rf /var/log
rm -rf ~/.cache
pacman --noconfirm -R grub gettext
systemctl enable dhcpcd
exit