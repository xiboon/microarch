#!/bin/bash
pacman --noconfirm -S xfce4 lxdm xorg-server
systemctl enable lxdm
cd /usr/share
find locale ! -name en_US -delete
find themes ! -name Adwaita -delete
find icons ! -name Adwaita -delete
rm -rf libwacom kbd gir-1.0 licenses