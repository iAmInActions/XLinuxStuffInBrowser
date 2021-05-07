#!/bin/bash
apt update
apt install -y xvfb x11vnc build-essential libx11-dev libxcursor-dev libxrandr-dev libxinerama-dev libxi-dev libgl1-mesa-dev libgl1-mesa-dri
apt install -y openjdk-8-jre
git clone https://github.com/ayunami2000/noVNC
./noVNC/utils/launch.sh --listen 80 &
echo "Please select gdm3 as the default display manager."
sleep 3
apt install -y tigervnc-standalone-server lxde lxterminal
useradd notroot
clear
read -p "Press Enter and then enter a password for your user account:"
passwd notroot
echo "Set password!"
sleep 4
clear
tigervncserver -noxstartup -SecurityTypes None -geometry 1280x720 :0
export DISPLAY=:0
wget https://raw.githubusercontent.com/iAmInActions/UsefullScripts/main/launch-lxde-manually.sh
chmod +x ./launch-lxde-manually.sh
sudo -u notroot ./launch-lxde-manually.sh
while true
do
sleep 1000
done
