From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v7 0/4] gpiolib: speed up GPIO array processing
Date: Sun,  2 Sep 2018 14:01:40 +0200
Message-ID: <20180902120144.6855-1-jmkrzyszt@gmail.com>
References: <20180831225616.29221-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20180831225616.29221-1-jmkrzyszt@gmail.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>, linux-doc@vger.kernel.org, linux-iio@vger.kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>, Peter Rosin <peda@axentia.se>, netdev@vger.kernel.org, linux-i2c@vger.kernel.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, devel@driverdev.osuosl.org, Florian Fainelli <f.fainelli@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>, Tony Lindgren <tony@atomide.com>, Lukas Wunner <lukas@wunner.de>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Michael Hennerich <Michael.Hennerich@analog.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-gpio@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, Lars-Peter Clausen <lars@metafoo.de>, Yeg
List-Id: linux-mmc@vger.kernel.org


The goal is to boost performance of get/set array functions while
processing GPIO arrays which represent pins of a signle chip in
hardware order.  If resulting performance is close to PIO, GPIO API
can be used for data I/O without much loss of speed.

Created and tested on a low end Amstrad Delta board with NAND driver
updated to use GPIO API for data I/O.  Performance degrade compared to
PIO is much better than before the optimization though not quite
satisfactory on my test hardware.


Janusz Krzysztofik (4):
      gpiolib: Pass bitmaps, not integer arrays, to get/set array
      gpiolib: Identify arrays matching GPIO hardware
      gpiolib: Pass array info to get/set array functions
      gpiolib: Implement fast processing path in get/set array


Changelog:
v7:
- add more people to Cc: - authors and/or those who contributed most to
  the drivers in scope of the change,
[PATCH v7 1/4] gpiolib: Pass bitmaps, not integer arrays, to get/set:
- avoid VLAs, use data source type bit number as bitmap size if not
  constant - great recommendation by Peter Rosin, thanks,
- revert names of local variables declared with DECLARE_BITMAP() from
  'value_bitmap' to original names of value arrays they replace (but not
  'value_array') - inspired by Peter Rosin suggestion - thanks!
drivers/gpio/gpio-max3191x.c:
- use bitmap_alloc() to be more consistent with DECLARE_BITMAP() pattern
  used by other consumers,
drivers/phy/motorola/phy-mapphone-mdm6600.c:
- no need to mask unused bits of val before its assignment to bitmap,
  passing PHY_MDM6600_NR_CMD_LINES to gpiod_set_array_value() as array/
  bitmap size provides sufficient protection.

v6:
[PATCH v6 1/4] gpiolib: Pass bitmaps, not integer arrays, to get/set
- use DECLARE_BITMAP() macro for declaring value_bitmap - great idea by
  David Laight, thanks!
drivers/auxdisplay/hd44780.c:
- simplify the code and adjust comments as recommended by Geert
  Uytterhoeven - thanks!,
drivers/i2c/muxes/i2c-mux-gpio.c:
- drop .values member of struct gpiomux - details provided by Peter
  Rosin, thanks!, 
drivers/mux/gpio.c:
- drop .val member of struct mux_gpio - details provided by Peter
  Rosin, thanks!,
drivers/net/phy/mdio-mux-gpio.c:
- drop .values member of struct mdio_mux_gpio_state and its processsing.

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
 drivers/auxdisplay/hd44780.c                |   67 ++----
 drivers/bus/ts-nbus.c                       |   20 --
 drivers/gpio/gpio-max3191x.c                |   16 +
 drivers/gpio/gpiolib.c                      |  273 ++++++++++++++++++++++------
 drivers/gpio/gpiolib.h                      |   15 +
 drivers/i2c/muxes/i2c-mux-gpio.c            |   16 -
 drivers/mmc/core/pwrseq_simple.c            |   15 -
 drivers/mux/gpio.c                          |   16 -
 drivers/net/phy/mdio-mux-gpio.c             |   13 -
 drivers/pcmcia/soc_common.c                 |   10 -
 drivers/phy/motorola/phy-mapphone-mdm6600.c |   17 -
 drivers/staging/iio/adc/ad7606.c            |   12 -
 drivers/tty/serial/serial_mctrl_gpio.c      |    9 
 include/linux/gpio/consumer.h               |   35 ++-
 16 files changed, 396 insertions(+), 201 deletions(-)
