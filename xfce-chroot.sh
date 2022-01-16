#!/bin/bash
pacman --noconfirm -S xfce4 lxdm xorg-server
systemctl enable lxdm