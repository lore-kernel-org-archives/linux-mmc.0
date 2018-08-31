From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATH v6 0/4] gpiolib: speed up GPIO array processing
Date: Sat,  1 Sep 2018 00:56:12 +0200
Message-ID: <20180831225616.29221-1-jmkrzyszt@gmail.com>
References: <20180829204900.19390-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180829204900.19390-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>, Peter Korsgaard <peter.korsgaard@barco.com>, Peter Rosin <peda@axentia.se>, Ulf Hansson <ulf.hansson@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, Dominik Brodowski <linux@dominikbrodowski.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kishon Vijay Abraham I <kishon@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jiri Slaby <jslaby@suse.com>, Willy Tarreau <w@1wt.eu>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-mmc@vger.kernel.org


The goal is to boost performance of get/set array functions while
processing GPIO arrays which represent pins of a signle chip in
hardware order.  If resulting performance is close to PIO, GPIO API
can be used for data I/O without much loss of speed.

Created and tested on a low end Amstrad Delta board with NAND driver
updated to use GPIO API for data I/O.  Performance degrade compared to
PIO is much better than before the optimization but still not quite
satisfactory.

Janusz Krzysztofik (4):
      gpiolib: Pass bitmaps, not integer arrays, to get/set array
      gpiolib: Identify arrays matching GPIO hardware
      gpiolib: Pass array info to get/set array functions
      gpiolib: Implement fast processing path in get/set array

Changelog:
v6:
[PATCH v6 1/4] gpiolib: Pass bitmaps, not integer arrays, to get/set
- use DECLARE_BITMAP() macro for declaring value_bitmap - great idea by
  David Laight, thanks!
drivers/auxdisplay/hd44780.c:
- simplify the code and adjust comments as recommended by Geert
  Uytterhoeven - thanks!,
drivers/i2c/muxes/i2c-mux-gpio.c:
- drop .values member of struct gpiomux - details prvided by Peter
  Rosin, thanks!, 
drivers/mux/gpio.c:
- drop .val member of struct mux_gpio - details prvided by Peter
  Rosin, thanks!,
drivers/net/phy/mdio-mux-gpio.c:
- drop .values member of struct mdio_mux_gpio_state and is processsing.

v5:
[PATCH v5 1/4] gpiolib: Pass bitmaps, not integer arrays, to get/set
- drivers/i2c/muxes/i2c-mux-gpio.c:
  - drop assigment of values to struct gpiomux.values, as recommended
    by Peter Rosin - thanks!,
  - mark the .values member of the structure as obsolete,
- drivers/mux/gpio.c:
  - drop assigment of values to struct mux_gpio.val, also recommended
    by Peter Rosin - thanks!,
  - merk the .val member of the structure as obsolete,
- drivers/auxdisplay/hd44780.c:
  - fix incorrect bitmap size,
  - use >>= operator to simplify notation,
  both catched by Miguel Ojeda - thanks!,
- add Cc: clauses as well as Acked-by: collected so far.
[PATCH v5 2/4] gpiolib: Identify arrays matching GPIO hardware
- add Cc: clause.
[PATCH v5 3/4] gpiolib: Pass array info to get/set array functions
- add Cc: clauses as well as Acked-by: collected so far.
[PATCH v5 4/4] gpiolib: Implement fast processing path in get/set
- add Cc: clause.

v4:
That series was a follow up of the former "mtd: rawnand: ams-delta: Use
gpio-omap accessors for data I/O" which already contained some changes
to gpiolib.  Those previous attempts were commented by Borris Brezillon
who suggested using GPIO API modified to accept bitmaps, and by Linus
Walleij who suggested still more great ideas for further immprovement
of the proposed API changes - thanks!

diffstat:
 Documentation/driver-api/gpio/board.rst     |   15 +
 Documentation/driver-api/gpio/consumer.rst  |   48 +++-
 drivers/auxdisplay/hd44780.c                |   74 +++----
 drivers/bus/ts-nbus.c                       |   27 +-
 drivers/gpio/gpio-max3191x.c                |   23 +-
 drivers/gpio/gpiolib.c                      |  279 ++++++++++++++++++++++------
 drivers/gpio/gpiolib.h                      |   15 +
 drivers/i2c/muxes/i2c-mux-gpio.c            |   16 -
 drivers/mmc/core/pwrseq_simple.c            |   15 -
 drivers/mux/gpio.c                          |   18 -
 drivers/net/phy/mdio-mux-gpio.c             |   13 -
 drivers/pcmcia/soc_common.c                 |   14 -
 drivers/phy/motorola/phy-mapphone-mdm6600.c |   21 +-
 drivers/staging/iio/adc/ad7606.c            |   12 -
 drivers/tty/serial/serial_mctrl_gpio.c      |    9 
 include/linux/gpio/consumer.h               |   35 ++-
 16 files changed, 417 insertions(+), 217 deletions(-)
