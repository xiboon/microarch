#!/bin/bash
DEV1=/dev/vda1
DEV2=/dev/vda2
HOSTNAME=kurwa
if [ -e /sys/firmware/efi/efivars ]
then
    echo "This script is not compatible with UEFI!"
else
    # create partitions
    parted  \ mklabel msdos \ mkpart primary 1 512M \ mkpart primary 512M 100% -s
    # format partitions
    mkfs.fat -F32 $DEV1
    mkfs.btrfs $DEV2
    # mount fs
    mount -o compress=zstd $DEV2 /mnt
    mkdir /mnt/boot
    mount $DEV1 /mnt/boot
    # install needed packages
    pacstrap /mnt linux-hardened pacman dhcpcd sed nano systemd-sysvcompat pam btrfs-progs
    echo $HOSTNAME >> /mnt/etc/hostname
    # generate a fstab and go to chroot
    genfstab -U /mnt >> /mnt/etc/fstab
    chmod +x chroot-btrfs.sh
    cp chroot-btrfs.sh /mnt
    arch-chroot /mnt ./chroot-btrfs.sh
    echo "Finished! You can now reboot, if there are any issues please report them on github."
fi