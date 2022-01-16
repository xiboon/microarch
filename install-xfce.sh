#!/bin/bash
pacman --noconfirm -S xfce4 lightdm xorg-server
systemctl enable lightdm