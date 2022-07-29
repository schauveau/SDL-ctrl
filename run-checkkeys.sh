#
# Build and run checkkeys using the local build of SDL2.
# (so no installation required)
#
set -x
gcc test/checkkeys.c src/test/SDL_test_font.c -Iinclude/ -Wl,-rpath=$PWD/build/.libs $PWD/build/.libs/libSDL2.so -o checkkeys
./checkkeys
