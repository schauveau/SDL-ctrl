
# THIS IS A FORK OF SDL2 TO EXPERIMENT WITH A NEW KEYBOARD EVENT TYPE.

When the CTRL modifier is activated, SDL2 does not generate `SDL_TEXTINPUT` events 
so that the code can only use the information provided in `SDL_KEYPRESS` ;
that is the 'keycode' and the 'modifiers' bits

This is problematic because because there is no practical way to figure out which 
character should be used when Shift or AltGr is active. For example, if an application 
wants to handle `ctrl-@` then it should detect `Shift-2` with the US qwerty layout, 
`Shift-'` with the UK qwerty layout and `AltGr-à` with the French azerty layout.

This is not feasible with the current API because the layout is not and should not 
be exposed to the user.

The proposed solution is to produce a new event of kind `SDL_TEXTINPUTCTRL` that 
will be emited when `CTRL` prevents the production of `SDL_TEXTINPUT`. That should be
a non-breaking change since old applications can ignore new events.

This fork implements a proof of concept for the `wayland` and `x11` backends.

See also https://github.com/libsdl-org/SDL/issues/5977


## Quick Test without installing

The program `test/checkkeys.c` was modified to show the new events. 

Run `configure` and `make` as usual. 

Then run `./run-checkkeys.sh -w` for the Wayland backend or `./run-checkkeys.sh -x` for 
the X11 backend.

The output should contain some **INPUTCTRL** lines when pressing CTRL.

This is not well tested but the text reported by the **INPUTCTRL** lines 
appear correct to me even when using Shift, AltGr or the Compose feature.

Remark: `CTRL` only need to be active with the last key that produces the text.

# Note about the modified files

All changes are annotated with a comment containing the 
string `SCHAUVEAU`.

The modified files are 
- `test/checkkey.c`
- `include/SDL_events.h` to add the new `SDL_TEXTINPUTCTRL` event.
- `src/video/x11/SDL_x11events.c` for x11
- `src/video/wayland/SDL_waylandevents.c` for wayland
- `src/events/SDL_keyboard.c` and `src/events/SDL_keyboard_h.c` to add 
   a function to send the new event.

Porting the Wayland backend was quite straightforward since control was
explicitly tested before sending `SDL_TEXTINPUT`.

The X11 backend was a bit less obvious because everything is handled by the
X11 api.  The trick here is to clear the `ctrl` status from the X event 
before obtaining the text with `XLookupString` (or `Xutf8LookupString`).



# Simple DirectMedia Layer (SDL) Version 2.0

https://www.libsdl.org/

Simple DirectMedia Layer is a cross-platform development library designed
to provide low level access to audio, keyboard, mouse, joystick, and graphics
hardware via OpenGL and Direct3D. It is used by video playback software,
emulators, and popular games including Valve's award winning catalog
and many Humble Bundle games.

More extensive documentation is available in the docs directory, starting
with README.md

Enjoy!

Sam Lantinga (slouken@libsdl.org)
