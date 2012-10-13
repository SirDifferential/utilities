#!/bin/bash
# This script records the desktop and sends it to a crtmp server

# Settings are:
# -f x11grab: Use x11grab for input
# -r 30: Use FPS of 30
# -s 1280x1024: The recorded area is of size 1280x1024
# -i :0.0+1920,0: Use monitor :0.0, and offset it by 1920,0. For me this is my the top left corner of my second monitor
# -vcodec flv: Use flv as the video codec
# -f alsa -i hw:0,0: Take audio input from the device hw:0,0
# -ab 128 -ar 44100: Audio settings
# -threads 4: use 4 CPU threads
# -f flv 'rtmp://localhost/live/uqm': As a FLV stream, send the data to the specified address. The CRTMP server should create the stream to localhost/live/uqm
#
#
# To play, use: vlc 'rtmp://localhost/live/uqm live=1'
#
# CRTMP uses ports 1935 and 6666 for FLV streaming

cd /home/gekko/crtmpserver/crtmpserver/builders/cmake
echo "Launching crtmp server"
./run
echo "Launching video stream"
avconv -f x11grab -r 30 -s 1280x1024 -i :0.0+1920,0 -vcodec flv -crf 21 -f alsa -i hw:0,0 -ab 128 -ar 44100 -threads 4  -f flv 'rtmp://localhost/live/uqm
