#!/bin/bash
apt update
apt install -y xvfb x11vnc build-essential libx11-dev libxcursor-dev libxrandr-dev libxinerama-dev libxi-dev libgl1-mesa-dev libgl1-mesa-dri
apt install -y openjdk-8-jre
git clone https://github.com/ayunami2000/noVNC
./noVNC/utils/launch.sh --listen 80 &
echo "Please select lightdm as the default display manager."
apt install -y tigervnc-standalone-server lxde lxterminal
useradd notroot
clear
echo "Enter a user password:"
passwd notroot
tigervncserver -noxstartup -SecurityTypes None -geometry 1280x720 :0
export DISPLAY=:0
lightdm
while true
do
sleep 1000
done
