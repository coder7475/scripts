#!/bin/bash
# NOTICE, EASY WAY FIRST: sudo apt install gnome-session-wayland 
# If easy way not work try this below: 
################# 0 - Preparation ################## 
 # Update and PPA 
  sudo add-apt-repository -y ppa:wayland.admin/daily-builds; \ 
  apt update; \ 
# 
# Depends 
  sudo apt install  -y doxygen xmlto; \ 
  sudo apt install  -y libxml2-dev; \ 
# 
# Install build dependencies of wayland/weston 
  sudo apt install -y \ 
    libevdev-dev \ 
    libwacom-dev \ 
    libxkbcommon-dev; \ 
 #  
  sudo apt-get install  -y autoconf automake bison debhelper dpkg-dev flex \ 
    libudev-dev libx11-dev libx11-xcb-dev \ 
    libxdamage-dev libxext-dev libxfixes-dev libxxf86vm-dev \ 
    linux-libc-dev pkg-config python-libxml2 quilt x11proto-dri2-dev \ 
    x11proto-gl-dev xutils-dev; \ 
#     
# libinput dependencies: 
  sudo apt install  -y libmtdev-dev libpam0g-dev; \ 
# 
################## 1- Installation ################# 
# Wayland 
  sudo apt install  -y libwayland0; \ 
  sudo apt install  -y weston wayland-protocols xserver-xorg; \ 
  sudo apt install  -y xwayland wayland; \ 
  sudo apt install  -y weston; \ 
# 
# Gnome and Lightdm 
  apt install  -y gnome-session\*;  \ 
  apt install  -y gnome-session-wayland; \ 
#   
  sudo dpkg-reconfigure lightdm; \ 
  weston; \ 
#   
