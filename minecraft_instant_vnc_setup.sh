#!/bin/bash
apt update
wget -O virtualgl.deb https://sourceforge.net/projects/virtualgl/files/2.6.5/virtualgl_2.6.5_amd64.deb/download
apt install -y ./virtualgl.deb
apt install -y xvfb x11vnc build-essential libx11-dev libxcursor-dev libxrandr-dev libxinerama-dev libxi-dev libgl1-mesa-dev libgl1-mesa-dri python-minimal
apt install -y openjdk-8-jre
git clone https://github.com/ayunami2000/noVNC
git clone https://github.com/mindstorm38/portablemc
./noVNC/utils/launch.sh --listen 80 &
Xvfb -screen 0 900x720x24+32 +extension GLX &
export DISPLAY=:0
x11vnc -noshm -geometry 900x720 -shared -forever &
yes y | python3.7 ./portablemc/portablemc.py start -u demouser 1.16.4
