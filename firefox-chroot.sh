#!/bin/bash
echo 3 | pacman --noconfirm -S firefox
rm -rf /var/cache
cd /usr/share
rm -rf model man doc gtk-doc gir-1.0 dicts