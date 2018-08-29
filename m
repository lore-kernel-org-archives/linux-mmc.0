From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC RFT PATCH 0/4] gpiolib: speed up GPIO array processing
Date: Wed, 29 Aug 2018 12:19:41 +0200
Message-ID: <CAPDyKFoWrsq9Qu3AOM=6xmpqOGU8XwaAmKZr9_xD-dpAzwWENg@mail.gmail.com>
References: <20180813223448.21316-1-jmkrzyszt@gmail.com> <20180820234341.5271-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180820234341.5271-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>, Peter Korsgaard <peter.korsgaard@barco.com>, Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, Dominik Brodowski <linux@dominikbrodowski.net>, Kishon Vijay Abraham I <kishon@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org, linux-i2c@vger.kernel.
List-Id: linux-mmc@vger.kernel.org

On 21 August 2018 at 01:43, Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
>
> This series is a follow up of the former "mtd: rawnand: ams-delta: Use
> gpio-omap accessors for data I/O" which already contained some changes
> to gpiolib.  Those previous attempts were commented by Borris Brezillon
> who suggested using GPIO API modified to accept bitmaps, and by Linus
> Walleij who suggested still more great ideas for further immprovement
> of the proposed API changes - thanks!
>
> The goal is to boost performans of get/set array functions while
> processing GPIO arrays which represent pins of a signle chip in
> hardware order.  If resulting performance is close to PIO, GPIO API
> can be used for data I/O without much loss of speed.
>
> Created and tested on a low end Amstrad Delta board with NAND driver
> updated to use GPIO API for data I/O.  Performance degrade compared to
> PIO is much better than before the optimization but still not quite
> satisfactory.
>
>
> Janusz Krzysztofik (4):
>       gpiolib: Pass bitmaps, not integer arrays, to get/set array
>       gpiolib: Identify arrays matching GPIO hardware
>       gpiolib: Pass array info to get/set array functions
>       gpiolib: Implement fast processing path in get/set array
>
>
>  Documentation/driver-api/gpio/board.rst     |   15 +
>  Documentation/driver-api/gpio/consumer.rst  |   48 +++-
>  drivers/auxdisplay/hd44780.c                |   64 +++---
>  drivers/bus/ts-nbus.c                       |   25 --
>  drivers/gpio/gpio-max3191x.c                |   23 +-
>  drivers/gpio/gpiolib.c                      |  279 ++++++++++++++++++++++------
>  drivers/gpio/gpiolib.h                      |   15 +
>  drivers/i2c/muxes/i2c-mux-gpio.c            |    5
>  drivers/mmc/core/pwrseq_simple.c            |   15 -
>  drivers/mux/gpio.c                          |    7
>  drivers/net/phy/mdio-mux-gpio.c             |    5
>  drivers/pcmcia/soc_common.c                 |   14 -
>  drivers/phy/motorola/phy-mapphone-mdm6600.c |   21 +-
>  drivers/staging/iio/adc/ad7606.c            |   12 -
>  drivers/tty/serial/serial_mctrl_gpio.c      |    9
>  include/linux/gpio/consumer.h               |   35 ++-
>  16 files changed, 410 insertions(+), 182 deletions(-)
>

For the mmc related changes:

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
