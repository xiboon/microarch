#!/bin/bash
cp ichroot.sh firefox-chroot.sh install-btrfs.sh install-ext4.sh install-firefox.sh install-xfce.sh xfce-chroot.sh iso/airootfs/usr/local/bin
find iso/airootfs/usr/local/bin -type f -name '*.sh' -exec sh -c '
    for pathname do
        mv "$pathname" "${pathname%.sh}"
done' sh {} +
sudo mkarchiso -v -w /tmp/archiso-tmp -o ./out ./iso
sudo rm -rf /tmp/archiso-tmp