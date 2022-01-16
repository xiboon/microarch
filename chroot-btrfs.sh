#!/bin/bash
pacman --noconfirm -S grub
grub-install --target=i386-pc --force /dev/vda
grub-mkconfig -o /boot/grub/grub.cfg
passwd
exit