#!/bin/bash
apt update
apt install -y xvfb x11vnc build-essential libx11-dev libxcursor-dev libxrandr-dev libxinerama-dev libxi-dev libgl1-mesa-dev libgl1-mesa-dri
apt install -y openjdk-8-jre
git clone https://github.com/iAmInActions/noVNC
./noVNC/utils/launch.sh --listen 80 &
echo "Please select gdm3 as the default display manager."
sleep 3
apt install -y tigervnc-standalone-server lxde lxterminal firefox alsa-base alsa-tools pulseaudio
useradd notroot
echo 'notroot  ALL=(ALL:ALL) ALL' >> /etc/sudoers
echo "webtop" | passwd --stdin notroot
echo "Set password!"
sleep 4
clear
mkdir /home/notroot/
chown notroot /home/notroot/
cd /home/notroot/

# Create audio stream
alsa reload
alsa resume
pulseaudio &
modprobe snd-aloop pcm_substreams=1
echo "# .asoundrc" >> /etc/asound.conf
echo "pcm.!default { type plug slave.pcm "hw:Loopback,0,0" }" >> /etc/asound.conf
mkdir /root/noVNC/app/desktopaudio/
cd /root/noVNC/app/desktopaudio/
ffmpeg -f alsa -channels 2 -sample_rate 44100 -i hw:Loopback,1,0 -map 0 -codec:a aac -f ssegment -segment_list stream.m3u -segment_list_flags +live -segment_time 10 out%03d.ts &
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
