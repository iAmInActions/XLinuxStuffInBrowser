#!/bin/bash
tigervncserver -noxstartup -SecurityTypes None -geometry 1280x720 :0
export DISPLAY=:0
export HOME=/home/$1
openbox &
lxsession &
lxterminal --command='bash --login' &
