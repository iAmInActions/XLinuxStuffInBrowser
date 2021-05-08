#!/bin/bash
apt update
apt install -y xvfb x11vnc build-essential libx11-dev libxcursor-dev libxrandr-dev libxinerama-dev libxi-dev libgl1-mesa-dev libgl1-mesa-dri
apt install -y openjdk-8-jre
git clone https://github.com/ayunami2000/noVNC
./noVNC/utils/launch.sh --listen 80 &
echo "Please select gdm3 as the default display manager."
sleep 3
apt install -y tigervnc-standalone-server lxde lxterminal firefox
useradd notroot
echo 'notroot  ALL=(ALL:ALL) ALL' >> /etc/sudoers
echo "webtop" | passwd --stdin notroot
echo "Set password!"
sleep 4
clear
mkdir /home/notroot/
chown notroot /home/notroot/
cd /home/notroot/
wget https://raw.githubusercontent.com/iAmInActions/UsefullScripts/main/lxde-vnc.sh
chmod +x ./lxde-vnc.sh
sudo -u notroot ./lxde-vnc.sh

bash --login
while true
do
bash --login
sleep 1000
done
