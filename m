From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v5 1/4] gpiolib: Pass bitmaps, not integer arrays, to
 get/set array
Date: Thu, 30 Aug 2018 09:40:47 +0200
Message-ID: <CAMuHMdW4QHuab8xuqNxc-yg_RiH0+Pb4yJryarDq6bgjtGvWsQ@mail.gmail.com>
References: <20180820234341.5271-1-jmkrzyszt@gmail.com> <20180829204900.19390-1-jmkrzyszt@gmail.com>
 <20180829204900.19390-2-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180829204900.19390-2-jmkrzyszt@gmail.com>
Sender: netdev-owner@vger.kernel.org
To: jmkrzyszt@gmail.com
Cc: Linus Walleij <linus.walleij@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>, peter.korsgaard@barco.com, Peter Rosin <peda@axentia.se>, Ulf Hansson <ulf.hansson@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, Dominik Brodowski <linux@dominikbrodowski.net>, Greg KH <gregkh@linuxfoundation.org>, Kishon Vijay Abraham I <kishon@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald <pmeerw@pmeerw.net>, Jiri Slaby <jslaby@suse.com>, Willy Tarreau <w@1wt.eu>, "open list:DOCUMENTATION" <linux-doc@vger.>
List-Id: linux-mmc@vger.kernel.org

Hi Janusz,

On Wed, Aug 29, 2018 at 10:48 PM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
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

Thanks for your patch!

> --- a/drivers/auxdisplay/hd44780.c
> +++ b/drivers/auxdisplay/hd44780.c
> @@ -62,20 +62,19 @@ static void hd44780_strobe_gpio(struct hd44780 *hd)
>  /* write to an LCD panel register in 8 bit GPIO mode */
>  static void hd44780_write_gpio8(struct hd44780 *hd, u8 val, unsigned int rs)
>  {
> -       int values[10]; /* for DATA[0-7], RS, RW */
> -       unsigned int i, n;
> +       unsigned long value_bitmap[1];  /* for DATA[0-7], RS, RW */
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

The clearing is not needed, as this has been done by 'value_bitmap[0] = val;'

>                 n++;
>         }

So the above block can be simplified to:

        n = hd->pins[PIN_CTRL_RW] ? 10 : 9;

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

This comment is not correct, as the low bits will be used.

        /* DATA[4-7], RS, RW */

> +       unsigned long value_bitmap[1];
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

Not needed.

>                 n++;
>         }

Hence:

        n = hd->pins[PIN_CTRL_RW] ? 6: 5;

> +       value_bitmap[0] >>= PIN_DATA4;

Yuck?!?

Isn't it more readable to just do:

        /* High nibble + RS, RW */
        value_bitmap[0] = val >> 4;
        __assign_bit(4, value_bitmap, rs);
        n = hd->pins[PIN_CTRL_RW] ? 6: 5;

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

... and:

         /* Low nibble */
        value_bitmap[0] &= ~0x0f;
        value_bitmap[0] |= val & 0x0f;

>
>         /* Present the data to the port */
> -       gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4],
> -                                      &values[PIN_DATA4]);
> +       gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4], value_bitmap);
>
>         hd44780_strobe_gpio(hd);
>  }
> @@ -155,23 +153,23 @@ static void hd44780_write_cmd_gpio4(struct charlcd *lcd, int cmd)
>  /* Send 4-bits of a command to the LCD panel in raw 4 bit GPIO mode */
>  static void hd44780_write_cmd_raw_gpio4(struct charlcd *lcd, int cmd)
>  {
> -       int values[10]; /* for DATA[0-7], RS, RW, but DATA[0-3] is unused */
> +       /* for DATA[0-7], RS, RW, but DATA[0-3] is unused */

This comment is not correct, as the low bits will be used.

        /* DATA[4-7], RS, RW */

> +       unsigned long value_bitmap[1];
>         struct hd44780 *hd = lcd->drvdata;
> -       unsigned int i, n;
> +       unsigned int n;
>
>         /* Command nibble + RS, RW */
> -       for (i = 0; i < 4; i++)
> -               values[PIN_DATA4 + i] = !!(cmd & BIT(i));
> -       values[PIN_CTRL_RS] = 0;
> +       value_bitmap[0] = cmd << PIN_DATA4;
> +       __clear_bit(PIN_CTRL_RS, value_bitmap);

Implied by the assignment above.

>         n = 5;
>         if (hd->pins[PIN_CTRL_RW]) {
> -               values[PIN_CTRL_RW] = 0;
> +               __clear_bit(PIN_CTRL_RW, value_bitmap);
>                 n++;
>         }
> +       value_bitmap[0] = value_bitmap[0] >> PIN_DATA4;

Hence:

        /* Command nibble + RS, RW */
        value_bitmap[0] = cmd;
        n = hd->pins[PIN_CTRL_RW] ? 6: 5;


>
>         /* Present the data to the port */
> -       gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4],
> -                                      &values[PIN_DATA4]);
> +       gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4], value_bitmap);
>
>         hd44780_strobe_gpio(hd);
>  }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
