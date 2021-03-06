#!/bin/bash
if [ -e /dev/vda ]
then
    DEV=/dev/vda
else
    DEV=/dev/sda
fi

HOSTNAME=kurwa

if [ -e /sys/firmware/efi/efivars ]
then
    echo "This script is not compatible with UEFI!"
else
    # create partitions
    parted ${DEV} \ mklabel msdos \ mkpart primary 1 512M \ mkpart primary 512M 100% -s
    # format partitions
    mkfs.fat -F32 ${DEV}1
    mkfs.ext4 ${DEV}2
    # mount fs
    mount ${DEV}2 /mnt
    mkdir /mnt/boot
    mkdir /mnt/etc
    mount ${DEV}1 /mnt/boot
    # mkinitcpio
    # install needed packages
    pacstrap /mnt linux-hardened pacman dhcpcd sed nano systemd-sysvcompat pam
    echo $HOSTNAME >> /mnt/etc/hostname
    # generate a fstab and go to chroot
    genfstab -U /mnt >> /mnt/etc/fstab
    chmod +x chroot.sh
    if [ -e /usr/local/bin/ichroot ]
    then
        cp /usr/local/bin/ichroot /mnt/ichroot.sh
    else
        cp ichroot.sh /mnt
    fi
    arch-chroot /mnt ./ichroot.sh
    echo "Finished! You can now reboot, if there are any issues please report them on github."
fi