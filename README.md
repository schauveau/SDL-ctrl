
THIS IS A PRIVATE BRANCH TO EXPERIMENT WITH A NEW KEYBOARD EVENT TYPE.

When the CTRL modifier is activated, SDL2 does not generate `SDL_TEXTINPUT` events 
meanning that the code can only use the information provided in `SDL_KEYPRESS` ;
that is the 'keycode' and the 'modifiers' bits

This is problematic because because there is no practical way to figure out which 
character should be used when Shift or AltGr is active. For example, if an application 
want to handle `ctrl-@` then it should detect `Shift-2` with the US qwerty layout, 
`Shift-'` with the UK qwerty layout and `AltGr-à` with the French azerty layout.

This is not feasible with the current API since the layout is not and should not 
be exposed to the user.

The proposed solution is to produce a new event of kind `SDL_TEXTINPUTCTRL` that 
will be emited when `CTRL` prevents the production of `SDL_TEXTINPUT`. This is a 
non-breaking change since old applications can simply ignore the new events.











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
