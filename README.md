[![Build Status](https://travis-ci.org/ppelleti/hs-powermate.svg?branch=master)](https://travis-ci.org/ppelleti/hs-powermate)

This library is for interfacing the [Griffin PowerMate USB][1] with
Haskell.  This library only works on Linux, and is primarily intended
for headless/embedded Linux systems such as the Raspberry Pi.  (Other
[solutions][2] [already][3] [exist][4] for interfacing the PowerMate
with desktop Linux.)  Besides reading events from the PowerMate, you
can also control the brightness of the built-in LED.

Before plugging in the PowerMate, create the file
`/etc/udev/rules.d/60-powermate.rules` with the following contents:

    ACTION=="add", ENV{ID_USB_DRIVER}=="powermate", SYMLINK+="input/powermate", MODE="0666"

This will cause the PowerMate to show up as `/dev/input/powermate`
when it is plugged in, which is where the library expects to find it.

Besides the library, this package includes two example programs,
`powermate-print` and `powermate-pulse`.  `powermate-print` simply
prints out the events it receives from the PowerMate.
`powermate-pulse` does the same thing, but also pulses the blue LED.

[1]: https://griffintechnology.com/us/powermate
[2]: https://github.com/stefansundin/powermate-linux
[3]: http://gizmod.sourceforge.net/
[4]: https://www.bedroomlan.org/projects/evrouter2
