#!/bin/bash
apt update
apt install -y xvfb x11vnc build-essential libx11-dev libxcursor-dev libxrandr-dev libxinerama-dev libxi-dev libgl1-mesa-dev libgl1-mesa-dri
apt install -y openjdk-8-jre
git clone https://github.com/ayunami2000/noVNC
./noVNC/utils/launch.sh --listen 80 &
sudo apt install -y tigervnc-standalone-server lxde lxterminal
tigervncserver -noxstartup -SecurityTypes None :0
export DISPLAY=:0
lxsession &
lxterminal &
while true
do
sleep 1000
done
