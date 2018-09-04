#!/bin/sh

trap "echo TRAPed signal" HUP INT QUIT KILL TERM

# start jekyll in the background
jekyll serve -w --force_polling --detach --incremental --verbose --host 0.0.0.0 --port 4000

# start gulp in the foreground
gulp watch

# kill jekyll
echo "stopping jekyll"
pkill jekyll -f

echo "exited $0"
