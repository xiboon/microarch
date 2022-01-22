#!/bin/bash
if [ -e /usr/local/bin/firefox-chroot ]
then
    cp /usr/local/bin/firefox-chroot /mnt/firefox-chroot.sh
else
    cp firefox-chroot.sh /mnt/firefox-chroot.sh
fi
arch-chroot /mnt /firefox-chroot.sh