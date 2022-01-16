#!/bin/bash
DEV=/dev/vda
HOSTNAME=kurwa
if [ -e /sys/firmware/efi/efivars ]
then
    echo "This script is not compatible with UEFI!"
else
    # create partitions
    parted /dev/vda \ mklabel msdos \ mkpart primary 1 512M \ mkpart primary 512M 100% -s
    # format partitions
    mkfs.fat -F32 /dev/vda1
    mkfs.btrfs /dev/vda2
    # mount fs
    mount -o compress=zstd /dev/vda2 /mnt
    mkdir /mnt/boot
    mount /dev/vda1 /mnt/boot
    # install needed packages
    pacstrap /mnt linux-hardened pacman dhcpcd sed nano systemd-sysvcompat pam btrfs-progs
    echo $HOSTNAME >> /mnt/etc/hostname
    # generate a fstab and go to chroot
    genfstab -U /mnt >> /mnt/etc/fstab
    chmod +x chroot-btrfs.sh
    arch-chroot /mnt ./chroot-btrfs.sh
    echo "Finished! You can now reboot, if there are any issues please report them on github."
fi