From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH v5 1/4] gpiolib: Pass bitmaps, not integer arrays, to
 get/set array
Date: Thu, 30 Aug 2018 13:10:59 +0200
Message-ID: <CANiq72kJT15ELkYr2U5r4-pvGunQFLmZ5dhdZLnjmM7NWBnkNQ@mail.gmail.com>
References: <20180820234341.5271-1-jmkrzyszt@gmail.com> <20180829204900.19390-1-jmkrzyszt@gmail.com>
 <20180829204900.19390-2-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180829204900.19390-2-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Peter Korsgaard <peter.korsgaard@barco.com>, Peter Rosin <peda@axentia.se>, Ulf Hansson <ulf.hansson@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, Dominik Brodowski <linux@dominikbrodowski.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kishon Vijay Abraham I <kishon@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jiri Slaby <jslaby@suse.com>, Willy Tarreau <w@1wt.eu>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux
List-Id: linux-mmc@vger.kernel.org

Hi Janusz,

On Wed, Aug 29, 2018 at 10:48 PM, Janusz Krzysztofik
<jmkrzyszt@gmail.com> wrote:
> Most users of get/set array functions iterate consecutive bits of data,
> usually a single integer, while processing array of results obtained
> from, or building an array of values to be passed to those functions.
> Save time wasted on those iterations by changing the functions' API to
> accept bitmaps.
>
> All current users are updated as well.
>
> More benefits from the change are expected as soon as planned support
> for accepting/passing those bitmaps directly from/to respective GPIO
> chip callbacks if applicable is implemented.
>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
> Cc: Peter Korsgaard <peter.korsgaard@barco.com>
> Cc: Peter Rosin <peda@axentia.se>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  Documentation/driver-api/gpio/consumer.rst  | 22 ++++----
>  drivers/auxdisplay/hd44780.c                | 52 +++++++++--------
>  drivers/bus/ts-nbus.c                       | 19 ++-----
>  drivers/gpio/gpio-max3191x.c                | 17 +++---
>  drivers/gpio/gpiolib.c                      | 86 +++++++++++++++--------------
>  drivers/gpio/gpiolib.h                      |  4 +-
>  drivers/i2c/muxes/i2c-mux-gpio.c            |  8 +--
>  drivers/mmc/core/pwrseq_simple.c            | 13 ++---
>  drivers/mux/gpio.c                          |  9 +--
>  drivers/net/phy/mdio-mux-gpio.c             |  3 +-
>  drivers/pcmcia/soc_common.c                 | 11 ++--
>  drivers/phy/motorola/phy-mapphone-mdm6600.c | 17 +++---
>  drivers/staging/iio/adc/ad7606.c            |  9 +--
>  drivers/tty/serial/serial_mctrl_gpio.c      |  7 ++-
>  include/linux/gpio/consumer.h               | 18 +++---
>  15 files changed, 140 insertions(+), 155 deletions(-)
>
> diff --git a/Documentation/driver-api/gpio/consumer.rst b/Documentation/driver-api/gpio/consumer.rst
> index aa03f389d41d..ed68042ddccf 100644
> --- a/Documentation/driver-api/gpio/consumer.rst
> +++ b/Documentation/driver-api/gpio/consumer.rst
> @@ -323,29 +323,29 @@ The following functions get or set the values of an array of GPIOs::
>
>         int gpiod_get_array_value(unsigned int array_size,
>                                   struct gpio_desc **desc_array,
> -                                 int *value_array);
> +                                 unsigned long *value_bitmap);
>         int gpiod_get_raw_array_value(unsigned int array_size,
>                                       struct gpio_desc **desc_array,
> -                                     int *value_array);
> +                                     unsigned long *value_bitmap);
>         int gpiod_get_array_value_cansleep(unsigned int array_size,
>                                            struct gpio_desc **desc_array,
> -                                          int *value_array);
> +                                          unsigned long *value_bitmap);
>         int gpiod_get_raw_array_value_cansleep(unsigned int array_size,
>                                            struct gpio_desc **desc_array,
> -                                          int *value_array);
> +                                          unsigned long *value_bitmap);
>
>         void gpiod_set_array_value(unsigned int array_size,
>                                    struct gpio_desc **desc_array,
> -                                  int *value_array)
> +                                  unsigned long *value_bitmap)
>         void gpiod_set_raw_array_value(unsigned int array_size,
>                                        struct gpio_desc **desc_array,
> -                                      int *value_array)
> +                                      unsigned long *value_bitmap)
>         void gpiod_set_array_value_cansleep(unsigned int array_size,
>                                             struct gpio_desc **desc_array,
> -                                           int *value_array)
> +                                           unsigned long *value_bitmap)
>         void gpiod_set_raw_array_value_cansleep(unsigned int array_size,
>                                                 struct gpio_desc **desc_array,
> -                                               int *value_array)
> +                                               unsigned long *value_bitmap)
>
>  The array can be an arbitrary set of GPIOs. The functions will try to access
>  GPIOs belonging to the same bank or chip simultaneously if supported by the
> @@ -356,8 +356,8 @@ accessed sequentially.
>  The functions take three arguments:
>         * array_size    - the number of array elements
>         * desc_array    - an array of GPIO descriptors
> -       * value_array   - an array to store the GPIOs' values (get) or
> -                         an array of values to assign to the GPIOs (set)
> +       * value_bitmap  - a bitmap to store the GPIOs' values (get) or
> +                         a bitmap of values to assign to the GPIOs (set)
>
>  The descriptor array can be obtained using the gpiod_get_array() function
>  or one of its variants. If the group of descriptors returned by that function
> @@ -366,7 +366,7 @@ the struct gpio_descs returned by gpiod_get_array()::
>
>         struct gpio_descs *my_gpio_descs = gpiod_get_array(...);
>         gpiod_set_array_value(my_gpio_descs->ndescs, my_gpio_descs->desc,
> -                             my_gpio_values);
> +                             my_gpio_value_bitmap);
>
>  It is also possible to access a completely arbitrary array of descriptors. The
>  descriptors may be obtained using any combination of gpiod_get() and
> diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
> index f1a42f0f1ded..bbbd6a29bf01 100644
> --- a/drivers/auxdisplay/hd44780.c
> +++ b/drivers/auxdisplay/hd44780.c
> @@ -62,20 +62,19 @@ static void hd44780_strobe_gpio(struct hd44780 *hd)
>  /* write to an LCD panel register in 8 bit GPIO mode */
>  static void hd44780_write_gpio8(struct hd44780 *hd, u8 val, unsigned int rs)
>  {
> -       int values[10]; /* for DATA[0-7], RS, RW */
> -       unsigned int i, n;
> +       unsigned long value_bitmap[1];  /* for DATA[0-7], RS, RW */

(I read your comments in the other email)

I still find this odd, but if everyone is going to have this change
done like this, consistency is better.

> +       unsigned int n;
>
> -       for (i = 0; i < 8; i++)
> -               values[PIN_DATA0 + i] = !!(val & BIT(i));
> -       values[PIN_CTRL_RS] = rs;
> +       value_bitmap[0] = val;
> +       __assign_bit(PIN_CTRL_RS, value_bitmap, rs);
>         n = 9;
>         if (hd->pins[PIN_CTRL_RW]) {
> -               values[PIN_CTRL_RW] = 0;
> +               __clear_bit(PIN_CTRL_RW, value_bitmap);
>                 n++;
>         }
>
>         /* Present the data to the port */
> -       gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA0], values);
> +       gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA0], value_bitmap);
>
>         hd44780_strobe_gpio(hd);
>  }
> @@ -83,32 +82,31 @@ static void hd44780_write_gpio8(struct hd44780 *hd, u8 val, unsigned int rs)
>  /* write to an LCD panel register in 4 bit GPIO mode */
>  static void hd44780_write_gpio4(struct hd44780 *hd, u8 val, unsigned int rs)
>  {
> -       int values[10]; /* for DATA[0-7], RS, RW, but DATA[0-3] is unused */
> -       unsigned int i, n;
> +       /* for DATA[0-7], RS, RW, but DATA[0-3] is unused */
> +       unsigned long value_bitmap[1];

Ditto.

> +       unsigned int n;
>
>         /* High nibble + RS, RW */
> -       for (i = 4; i < 8; i++)
> -               values[PIN_DATA0 + i] = !!(val & BIT(i));
> -       values[PIN_CTRL_RS] = rs;
> +       value_bitmap[0] = val;
> +       __assign_bit(PIN_CTRL_RS, value_bitmap, rs);
>         n = 5;
>         if (hd->pins[PIN_CTRL_RW]) {
> -               values[PIN_CTRL_RW] = 0;
> +               __clear_bit(PIN_CTRL_RW, value_bitmap);
>                 n++;
>         }
> +       value_bitmap[0] >>= PIN_DATA4;
>
>         /* Present the data to the port */
> -       gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4],
> -                                      &values[PIN_DATA4]);
> +       gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4], value_bitmap);
>
>         hd44780_strobe_gpio(hd);
>
>         /* Low nibble */
> -       for (i = 0; i < 4; i++)
> -               values[PIN_DATA4 + i] = !!(val & BIT(i));
> +       value_bitmap[0] &= ~((1 << PIN_DATA4) - 1);
> +       value_bitmap[0] |= val & ~((1 << PIN_DATA4) - 1);

This is still wrong! What I originally meant in my v4 review is that
there is an extra ~ in the second line.

Also, a couple of general comments:

 - Please review the list of CCs (I was not CC'd originally, so maybe
there are other maintainers that aren't, either)
 - In general, the new code seems harder to read than the original one
(but that is my impression).

Thanks for your effort! :-)

Cheers,
Miguel
