// -*- mode: c++ -*-
// Copyright 2016 Keyboardio, inc. <jesse@keyboard.io>
// See "LICENSE" for license details

#ifndef BUILD_INFORMATION
#define BUILD_INFORMATION "locally built"
#endif


/**
   These #include directives pull in the Kaleidoscope firmware core,
   as well as the Kaleidoscope plugins we use in the Model 01's firmware
*/


// The Kaleidoscope core
#include "Kaleidoscope.h"

// Support for keys that move the mouse
#include "Kaleidoscope-MouseKeys.h"

// Support for macros
#include "Kaleidoscope-Macros.h"

// Support for controlling the keyboard's LEDs
#include "Kaleidoscope-LEDControl.h"

// Support for "Numpad" mode, which is mostly just the Numpad specific LED mode
#include "Kaleidoscope-NumPad.h"

// Support for an "LED off mode"
#include "LED-Off.h"

// Support for the "Boot greeting" effect, which pulses the 'LED' button for 10s
// when the keyboard is connected to a computer (or that computer is powered on)
#include "Kaleidoscope-LEDEffect-BootGreeting.h"

// Support for LED modes that set all LEDs to a single color
#include "Kaleidoscope-LEDEffect-SolidColor.h"

// Support for an LED mode that makes all the LEDs 'breathe'
#include "Kaleidoscope-LEDEffect-Breathe.h"

// Support for an LED mode that makes a red pixel chase a blue pixel across the keyboard
#include "Kaleidoscope-LEDEffect-Chase.h"

// Support for LED modes that pulse the keyboard's LED in a rainbow pattern
#include "Kaleidoscope-LEDEffect-Rainbow.h"

// Support for an LED mode that lights up the keys as you press them
#include "Kaleidoscope-LED-Stalker.h"

// Support for an LED mode that prints the keys you press in letters 4px high
#include "Kaleidoscope-LED-AlphaSquare.h"

// Support for Keyboardio's internal keyboard testing mode
#include "Kaleidoscope-Model01-TestMode.h"


/** This 'enum' is a list of all the macros used by the Model 01's firmware
    The names aren't particularly important. What is important is that each
    is unique.

    These are the names of your macros. They'll be used in two places.
    The first is in your keymap definitions. There, you'll use the syntax
    `M(MACRO_NAME)` to mark a specific keymap position as triggering `MACRO_NAME`

    The second usage is in the 'switch' statement in the `macroAction` function.
    That switch statement actually runs the code associated with a macro when
    a macro key is pressed.
*/

enum { MACRO_VERSION_INFO,
       MACRO_ANY,
       ARROW
     };



/** The Model 01's key layouts are defined as 'keymaps'. By default, there are three
    keymaps: The standard QWERTY keymap, the "Function layer" keymap and the "Numpad"
    keymap.

    Each keymap is defined as a list using the 'KEYMAP_STACKED' macro, built
    of first the left hand's layout, followed by the right hand's layout.

    Keymaps typically consist mostly of `Key_` definitions. There are many, many keys
    defined as part of the USB HID Keyboard specification. You can find the names
    (if not yet the explanations) for all the standard `Key_` defintions offered by
    Kaleidoscope in these files:
       https://github.com/keyboardio/Kaleidoscope/blob/master/src/key_defs_keyboard.h
       https://github.com/keyboardio/Kaleidoscope/blob/master/src/key_defs_consumerctl.h
       https://github.com/keyboardio/Kaleidoscope/blob/master/src/key_defs_sysctl.h
       https://github.com/keyboardio/Kaleidoscope/blob/master/src/key_defs_keymaps.h

    Additional things that should be documented here include
      using ___ to let keypresses fall through to the previously active layer
      using XXX to mark a keyswitch as 'blocked' on this layer
      using ShiftToLayer() and LockLayer() keys to change the active keymap.
      the special nature of the PROG key
      keeping NUM and FN consistent and accessible on all layers


    The "keymaps" data structure is a list of the keymaps compiled into the firmware.
    The order of keymaps in the list is important, as the ShiftToLayer(#) and LockLayer(#)
    macros switch to key layers based on this list.



    A key defined as 'ShiftToLayer(FUNCTION)' will switch to FUNCTION while held.
    Similarly, a key defined as 'LockLayer(NUMPAD)' will switch to NUMPAD when tapped.
*/

/**
    Layers are "0-indexed" -- That is the first one is layer 0. The second one is layer 1.
    The third one is layer 2.
    This 'enum' lets us use names like QWERTY, FUNCTION, and NUMPAD in place of
    the numbers 0, 1 and 2.

*/

enum { QWERTY, NUMPAD, FUNCTIONL, FUNCTIONR, CALT, CSHIFT, CSHIFTALT }; // layers

/* This comment temporarily turns off astyle's indent enforcement
     so we can make the keymaps actually resemble the physical key layout better
*/
// *INDENT-OFF*

const Key keymaps[][ROWS][COLS] PROGMEM = {

  [QWERTY] = KEYMAP_STACKED
  (Key_Escape,    Key_1, Key_2, Key_3, Key_4, Key_5, Key_LEDEffectNext,
   Key_Backtick,  Key_Q, Key_W, Key_E, Key_R, Key_T, Key_Enter,
   Key_Tab,       Key_A, Key_S, Key_D, Key_F, Key_G,
   Key_Spacebar,    Key_Z, Key_X, Key_C, Key_V, Key_B, Key_Escape,
   Key_LeftControl, Key_Backspace, Key_LeftAlt, Key_LeftShift,
   ShiftToLayer(FUNCTIONL),

   Key_PcApplication,Key_6, Key_7, Key_8,     Key_9,         Key_0,         LockLayer(NUMPAD),
   Key_Enter,        Key_Y, Key_U, Key_I,     Key_O,         Key_P,         Key_Equals,
                     Key_H, Key_J, Key_K,     Key_L,         Key_Semicolon, Key_Quote,
   Key_LeftGui,      Key_N, Key_M, Key_Comma, Key_Period,    Key_Slash,     Key_Minus,
   Key_RightAlt,     Key_RightControl,  Key_Spacebar, Key_RightShift,
   ShiftToLayer(FUNCTIONR)),


  [NUMPAD] =  KEYMAP_STACKED
  (___, ___, ___, ___, ___, ___, ___,
   ___, ___, ___, ___, ___, ___, ___,
   ___, ___, ___, ___, ___, ___,
   ___, ___, ___, ___, ___, ___, ___,
   ___, ___, ___, ___,
   ___,

   M(MACRO_VERSION_INFO),  ___, Key_Keypad7, Key_Keypad8,   Key_Keypad9,        Key_KeypadSubtract, ___,
   ___,                    ___, Key_Keypad4, Key_Keypad5,   Key_Keypad6,        Key_KeypadAdd,      ___,
                           ___, Key_Keypad1, Key_Keypad2,   Key_Keypad3,        Key_Equals,         Key_Quote,
   ___,                    ___, Key_Keypad0, Key_KeypadDot, Key_KeypadMultiply, Key_KeypadDivide,   Key_Enter,
   ___, ___, ___, ___,
   ___),

  [FUNCTIONL] =  KEYMAP_STACKED
  (___,                     LGUI(LSHIFT(Key_1)),            LGUI(LSHIFT(Key_2)),          LGUI(LSHIFT(Key_3)),  LGUI(Key_N),          LGUI(Key_N),   XXX,
   Key_PrintScreen,         LGUI(LSHIFT(Key_Q)),            LGUI(LSHIFT(Key_W)),          LGUI(LSHIFT(Key_E)),  LGUI(Key_R),          LGUI(Key_T),   LGUI(Key_Enter),
   LGUI(Key_Tab),           LGUI(Key_A),                    LGUI(Key_S),                  LGUI(Key_D),          LGUI(LSHIFT(Key_D)),  LGUI(Key_G),
   Key_End,                 LGUI(Key_Z),                    LGUI(Key_X),                  LGUI(Key_C),          LGUI(Key_V),          LGUI(Key_B), ___,
   ShiftToLayer(CSHIFTALT), Key_Delete,                     ShiftToLayer(CALT),           ShiftToLayer(CSHIFT),
   ___,

   ___,              ___,                     ___,                 ___,                 ___,                 ___, ___,
   LGUI(Key_Enter), LGUI(LSHIFT(Key_H)),     LGUI(LSHIFT(Key_J)), LGUI(LSHIFT(Key_K)), LGUI(LSHIFT(Key_L)), ___, LGUI(LSHIFT(Key_F12)),
                    LGUI(Key_H),             LGUI(Key_J),         LGUI(Key_K),         LGUI(Key_L),         ___, ___,
   ___,             LGUI(Key_N),             LGUI(Key_M),   LGUI(Key_Comma),   ___,                 ___, ___,
   ___,             ___,                     LGUI(Key_Spacebar), ___,
   ___),

  [FUNCTIONR] =  KEYMAP_STACKED
  (___,                     Key_F1,                         Key_F2,                       Key_F3,               Key_F4,               Key_F5,              XXX,
   Key_PrintScreen,         ___,                            ___,                          ___,                  ___,                  ___,                 ___,
   Key_Home,                M(ARROW),                       ___,                          ___,                  ___,                  LGUI(Key_Z),
   Key_End,                 ___,                            ___,                          ___,                  ___,                  LGUI(LSHIFT(Key_Z)), ___,
   ShiftToLayer(CSHIFTALT), Key_Delete,                     ShiftToLayer(CALT),           ShiftToLayer(CSHIFT),
   ___,

   Consumer_ScanPreviousTrack, Key_F6,                 Key_F7,                   Key_F8,                   Key_F9,                  Key_F10,                 Key_F11,
   LCTRL(Key_Z),               Consumer_ScanNextTrack, Key_LeftCurlyBracket,     Key_RightCurlyBracket,    Key_LeftBracket,         Key_RightBracket,        Key_F12,
                               Key_LeftArrow,          Key_DownArrow,            Key_UpArrow,              Key_RightArrow,          M(ARROW),                Key_Backslash,
   ___,                        ___,                    LSHIFT(Key_9),            LSHIFT(Key_0),            LSHIFT(Key_LeftBracket), LSHIFT(Key_RightBracket),Key_Pipe,
   ___,                        ___,                    Key_Enter,                ___,
   ___),
   

  [CALT] =  KEYMAP_STACKED
  (___,                       LCTRL(LALT(Key_1)), LCTRL(LALT(Key_2)), LCTRL(LALT(Key_3)), LCTRL(LALT(Key_4)), LCTRL(LALT(Key_5)), ___,
   LCTRL(LALT(Key_Backtick)), LCTRL(LALT(Key_Q)), LCTRL(LALT(Key_W)), LCTRL(LALT(Key_E)), LCTRL(LALT(Key_R)), LCTRL(LALT(Key_T)), ___,
   ___,                       LCTRL(LALT(Key_A)), LCTRL(LALT(Key_S)), LCTRL(LALT(Key_D)), LCTRL(LALT(Key_F)), LCTRL(LALT(Key_G)),
   ___,                       LCTRL(LALT(Key_Z)), LCTRL(LALT(Key_X)), LCTRL(LALT(Key_C)), LCTRL(LALT(Key_V)), LCTRL(LALT(Key_B)), ___,
   ___, ___, ___, ___,
   ___,

   ___, LCTRL(LALT(Key_6)), LCTRL(LALT(Key_7)), LCTRL(LALT(Key_8)),     LCTRL(LALT(Key_9)),      LCTRL(LALT(Key_0)),         ___,
   ___, LCTRL(LALT(Key_Y)), LCTRL(LALT(Key_U)), LCTRL(LALT(Key_I)),     LCTRL(LALT(Key_O)),      LCTRL(LALT(Key_P)),         LCTRL(LALT(Key_Equals)),
        LCTRL(LALT(Key_H)), LCTRL(LALT(Key_J)), LCTRL(LALT(Key_K)),     LCTRL(LALT(Key_L)),      LCTRL(LALT(Key_Semicolon)), LCTRL(LALT(Key_Quote)),
   ___, LCTRL(LALT(Key_N)), LCTRL(LALT(Key_M)), LCTRL(LALT(Key_Comma)), LCTRL(LALT(Key_Period)), LCTRL(LALT(Key_Slash)),     LCTRL(LALT(Key_Minus)),
   ___, ___, ___, ___,
   ___),

  [CSHIFT] =  KEYMAP_STACKED
  (___,                         LCTRL(LSHIFT(Key_1)), LCTRL(LSHIFT(Key_2)), LCTRL(LSHIFT(Key_3)), LCTRL(LSHIFT(Key_4)), LCTRL(LSHIFT(Key_5)), ___,
   LCTRL(LSHIFT(Key_Backtick)), LCTRL(LSHIFT(Key_Q)), LCTRL(LSHIFT(Key_W)), LCTRL(LSHIFT(Key_E)), LCTRL(LSHIFT(Key_R)), LCTRL(LSHIFT(Key_T)), ___,
   ___,                         LCTRL(LSHIFT(Key_A)), LCTRL(LSHIFT(Key_S)), LCTRL(LSHIFT(Key_D)), LCTRL(LSHIFT(Key_F)), LCTRL(LSHIFT(Key_G)),
   ___,                         LCTRL(LSHIFT(Key_Z)), LCTRL(LSHIFT(Key_X)), LCTRL(LSHIFT(Key_C)), LCTRL(LSHIFT(Key_V)), LCTRL(LSHIFT(Key_B)), ___,
   ___, ___, ___, ___,
   ___,

   ___, LCTRL(LSHIFT(Key_6)), LCTRL(LSHIFT(Key_7)), LCTRL(LSHIFT(Key_8)),     LCTRL(LSHIFT(Key_9)),      LCTRL(LSHIFT(Key_0)),         ___,
   ___, LCTRL(LSHIFT(Key_Y)), LCTRL(LSHIFT(Key_U)), LCTRL(LSHIFT(Key_I)),     LCTRL(LSHIFT(Key_O)),      LCTRL(LSHIFT(Key_P)),         LCTRL(LSHIFT(Key_Equals)),
        LCTRL(LSHIFT(Key_H)), LCTRL(LSHIFT(Key_J)), LCTRL(LSHIFT(Key_K)),     LCTRL(LSHIFT(Key_L)),      LCTRL(LSHIFT(Key_Semicolon)), LCTRL(LSHIFT(Key_Quote)),
   ___, LCTRL(LSHIFT(Key_N)), LCTRL(LSHIFT(Key_M)), LCTRL(LSHIFT(Key_Comma)), LCTRL(LSHIFT(Key_Period)), LCTRL(LSHIFT(Key_Slash)),     LCTRL(LSHIFT(Key_Minus)),
   ___, ___, ___, ___,
   ___),

  [CSHIFTALT] =  KEYMAP_STACKED
  (___,                               LCTRL(LSHIFT(LALT(Key_1))), LCTRL(LSHIFT(LALT(Key_2))), LCTRL(LSHIFT(LALT(Key_3))), LCTRL(LSHIFT(LALT(Key_4))), LCTRL(LSHIFT(LALT(Key_5))), ___,
   LCTRL(LSHIFT(LALT(Key_Backtick))), LCTRL(LSHIFT(LALT(Key_Q))), LCTRL(LSHIFT(LALT(Key_W))), LCTRL(LSHIFT(LALT(Key_E))), LCTRL(LSHIFT(LALT(Key_R))), LCTRL(LSHIFT(LALT(Key_T))), ___,
   ___,                               LCTRL(LSHIFT(LALT(Key_A))), LCTRL(LSHIFT(LALT(Key_S))), LCTRL(LSHIFT(LALT(Key_D))), LCTRL(LSHIFT(LALT(Key_F))), LCTRL(LSHIFT(LALT(Key_G))),
   ___,                               LCTRL(LSHIFT(LALT(Key_Z))), LCTRL(LSHIFT(LALT(Key_X))), LCTRL(LSHIFT(LALT(Key_C))), LCTRL(LSHIFT(LALT(Key_V))), LCTRL(LSHIFT(LALT(Key_B))), ___,
   ___, ___, ___, ___,
   ___,

   ___, LCTRL(LSHIFT(LALT(Key_6))), LCTRL(LSHIFT(LALT(Key_7))), LCTRL(LSHIFT(LALT(Key_8))),     LCTRL(LSHIFT(LALT(Key_9))),      LCTRL(LSHIFT(LALT(Key_0))),         ___,
   ___, LCTRL(LSHIFT(LALT(Key_Y))), LCTRL(LSHIFT(LALT(Key_U))), LCTRL(LSHIFT(LALT(Key_I))),     LCTRL(LSHIFT(LALT(Key_O))),      LCTRL(LSHIFT(LALT(Key_P))),         LCTRL(LSHIFT(LALT(Key_Equals))),
        LCTRL(LSHIFT(LALT(Key_H))), LCTRL(LSHIFT(LALT(Key_J))), LCTRL(LSHIFT(LALT(Key_K))),     LCTRL(LSHIFT(LALT(Key_L))),      LCTRL(LSHIFT(LALT(Key_Semicolon))), LCTRL(LSHIFT(LALT(Key_Quote))),
   ___, LCTRL(LSHIFT(LALT(Key_N))), LCTRL(LSHIFT(LALT(Key_M))), LCTRL(LSHIFT(LALT(Key_Comma))), LCTRL(LSHIFT(LALT(Key_Period))), LCTRL(LSHIFT(LALT(Key_Slash))),     LCTRL(LSHIFT(LALT(Key_Minus))),
   ___, ___, ___, ___,
   ___),

};

/* Re-enable astyle's indent enforcement */
// *INDENT-ON*

/** versionInfoMacro handles the 'firmware version info' macro
    When a key bound to the macro is pressed, this macro
    prints out the firmware build information as virtual keystrokes
*/

static void versionInfoMacro(uint8_t keyState) {
  if (keyToggledOn(keyState)) {
    Macros.type(PSTR("Keyboardio Model 01 - Kaleidoscope "));
    Macros.type(PSTR(BUILD_INFORMATION));
  }
}

/** anyKeyMacro is used to provide the functionality of the 'Any' key.

   When the 'any key' macro is toggled on, a random alphanumeric key is
   selected. While the key is held, the function generates a synthetic
   keypress event repeating that randomly selected key.

*/

static void anyKeyMacro(uint8_t keyState) {
  static Key lastKey;
  if (keyToggledOn(keyState))
    lastKey.keyCode = Key_A.keyCode + (uint8_t)(millis() % 36);

  if (keyIsPressed(keyState))
    kaleidoscope::hid::pressKey(lastKey);
}

const macro_t *arrow() {
  return MACRO(T(Space), T(Equals), D(LeftShift), T(Period), U(LeftShift), T(Space));
}

/** macroAction dispatches keymap events that are tied to a macro
    to that macro. It takes two uint8_t parameters.

    The first is the macro being called (the entry in the 'enum' earlier in this file).
    The second is the state of the keyswitch. You can use the keyswitch state to figure out
    if the key has just been toggled on, is currently pressed or if it's just been released.

    The 'switch' statement should have a 'case' for each entry of the macro enum.
    Each 'case' statement should call out to a function to handle the macro in question.

*/

const macro_t *macroAction(uint8_t macroIndex, uint8_t keyState) {
  switch (macroIndex) {

    case MACRO_VERSION_INFO:
      versionInfoMacro(keyState);
      break;

    case MACRO_ANY:
      anyKeyMacro(keyState);
      break;

    case ARROW:
      if (keyToggledOn(keyState))
        return arrow();
      break;
  }
  return MACRO_NONE;
}



// These 'solid' color effect definitions define a rainbow of
// LED color modes calibrated to draw 500mA or less on the
// Keyboardio Model 01.


static kaleidoscope::LEDSolidColor solidRed(160, 0, 0);
static kaleidoscope::LEDSolidColor solidOrange(140, 70, 0);
static kaleidoscope::LEDSolidColor solidYellow(130, 100, 0);
static kaleidoscope::LEDSolidColor solidGreen(0, 160, 0);
static kaleidoscope::LEDSolidColor solidBlue(0, 70, 130);
static kaleidoscope::LEDSolidColor solidIndigo(0, 0, 170);
static kaleidoscope::LEDSolidColor solidViolet(130, 0, 120);



/** The 'setup' function is one of the two standard Arduino sketch functions.
    It's called when your keyboard first powers up. This is where you set up
    Kaleidoscope and any plugins.
*/

void setup() {
  // First, call Kaleidoscope's internal setup function
  Kaleidoscope.setup();

  // Next, tell Kaleidoscope which plugins you want to use.
  // The order can be important. For example, LED effects are
  // added in the order they're listed here.
  Kaleidoscope.use(
    // The boot greeting effect pulses the LED button for 10 seconds after the keyboard is first connected
    &BootGreetingEffect,

    // The hardware test mode, which can be invoked by tapping Prog, LED and the left Fn button at the same time.
    &TestMode,

    // LEDControl provides support for other LED modes
    &LEDControl,

    // We start with the stalker effect lights up the keys you've pressed recently
    &StalkerEffect,

    // LED effect that turns off all the LEDs.
    &LEDOff,

    // The rainbow effect changes the color of all of the keyboard's keys at the same time
    // running through all the colors of the rainbow.
    &LEDRainbowEffect,

    // The rainbow wave effect lights up your keyboard with all the colors of a rainbow
    // and slowly moves the rainbow across your keyboard
    &LEDRainbowWaveEffect,

    // The chase effect follows the adventure of a blue pixel which chases a red pixel across
    // your keyboard. Spoiler: the blue pixel never catches the red pixel
    &LEDChaseEffect,

    // These static effects turn your keyboard's LEDs a variety of colors
    &solidRed, &solidOrange, &solidYellow, &solidGreen, &solidBlue, &solidIndigo, &solidViolet,

    // The breathe effect slowly pulses all of the LEDs on your keyboard
    &LEDBreatheEffect,

    // The AlphaSquare effect prints each character you type, using your
    // keyboard's LEDs as a display
    &AlphaSquareEffect,


    // The numpad plugin is responsible for lighting up the 'numpad' mode
    // with a custom LED effect
    &NumPad,

    // The macros plugin adds support for macros
    &Macros,

    // The MouseKeys plugin lets you add keys to your keymap which move the mouse.
    &MouseKeys
  );

  // While we hope to improve this in the future, the NumPad plugin
  // needs to be explicitly told which keymap layer is your numpad layer
  NumPad.numPadLayer = NUMPAD;

  // We configure the AlphaSquare effect to use RED letters
  AlphaSquare.color = { 255, 0, 0 };

  // We set the brightness of the rainbow effects to 150 (on a scale of 0-255)
  // This draws more than 500mA, but looks much nicer than a dimmer effect
  LEDRainbowEffect.brightness(150);
  LEDRainbowWaveEffect.brightness(150);

  // The LED Stalker mode has a few effects. The one we like is
  // called 'BlazingTrail'. For details on other options,
  // see https://github.com/keyboardio/Kaleidoscope-LED-Stalker
  StalkerEffect.variant = STALKER(BlazingTrail);

  // We want to make sure that the firmware starts with LED effects off
  // This avoids over-taxing devices that don't have a lot of power to share
  // with USB devices
  LEDOff.activate();
}

/** loop is the second of the standard Arduino sketch functions.
    As you might expect, it runs in a loop, never exiting.

    For Kaleidoscope-based keyboard firmware, you usually just want to
    call Kaleidoscope.loop(); and not do anything custom here.
*/

void loop() {
  Kaleidoscope.loop();
}
