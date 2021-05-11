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

# Set up audio (experimental)
modprobe snd-dummy ; modprobe snd-aloop
alsa reload
alsa resume
pulseaudio &
modprobe snd-aloop pcm_substreams=1
echo "# .asoundrc" >> /etc/asound.conf
mkdir /root/noVNC/app/desktopaudio/
cd /root/noVNC/app/desktopaudio/
# Old command. Only keep this for legacy purposes
ffmpeg -hide_banner -loglevel error -nostdin -f alsa -channels 2 -sample_rate 44100 -i hw:Loopback,1,0 -map 0 -codec:a aac -f ssegment -segment_list stream.m3u -segment_list_flags +live -segment_time 10 out%03d.ts &
# New one
apt install mpd mpc -y
mpc add alsa://
echo 'audio_output {' >> /etc/mpd.conf
echo '        type    "httpd"' >> /etc/mpd.conf
echo '        name    "My HTTP Stream"' >> /etc/mpd.conf
echo '        encoder "vorbis" #or use "lame" for mp3, doesn’t matter' >> /etc/mpd.conf
echo '        port    "8000"' >> /etc/mpd.conf
echo '        bitrate "128"' >> /etc/mpd.conf
echo '        format  "44100:16:1"' >> /etc/mpd.conf
echo '        max_clients     "0" #0=nolimit' >> /etc/mpd.conf
echo '}' 
sudo service mpd restart
mpc play
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
