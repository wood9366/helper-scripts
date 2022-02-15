#!/usr/bin/env bash

ffmpeg -i "$1"  -vcodec libx264 -b:v 5000k -minrate 5000k -maxrate 5000k -bufsize 4200k -preset fast -crf 20 -y -vf "scale=-1:1080" "${1%.*}.mp4"
