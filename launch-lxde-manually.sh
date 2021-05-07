#!/bin/bash
export HOME=/home/$1
openbox &
lxsession &
lxterminal --command='bash --login' &
