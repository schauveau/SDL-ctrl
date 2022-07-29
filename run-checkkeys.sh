#!/bin/sh

#
# Build and run checkkeys using the local build of SDL2.
# (so no installation required)
#

if [ "$1" = "-x" ] ; then
    SDL_VIDEODRIVER=x11 
    export SDL_VIDEODRIVER
elif [ "$1" = "-w" ] ; then
    SDL_VIDEODRIVER=wayland 
    export SDL_VIDEODRIVER
fi

echo "==== Using SDL_VIDEODRIVER=$SDL_VIDEODRIVER ==="

set -x
gcc test/checkkeys.c src/test/SDL_test_font.c -Iinclude/ -Wl,-rpath=$PWD/build/.libs $PWD/build/.libs/libSDL2.so -o checkkeys
./checkkeys
