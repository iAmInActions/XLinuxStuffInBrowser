#!/bin/bash
export HOME=/home/notroot
tigervncserver -noxstartup -SecurityTypes None -geometry 1280x720 :0
export DISPLAY=:0
openbox &
lxsession &
lxterminal --command='bash --login' &
