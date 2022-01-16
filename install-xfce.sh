#!/bin/bash
cp xfce-chroot.sh /mnt
arch-chroot /mnt ./xfce-chroot.sh
rm -rf /mnt/var/cache
cd /mnt/usr/share
rm -rf man doc gtk-doc
echo "Installed xfce4 with lxdm!"
echo "You can now reboot, if there were any issues make sure you ran the script from the live cd after installation or report them on github."