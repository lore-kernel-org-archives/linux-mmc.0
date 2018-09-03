From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v7 1/4] gpiolib: Pass bitmaps, not integer arrays, to
 get/set array
Date: Mon, 3 Sep 2018 17:07:44 +0200
Message-ID: <CAMuHMdXScsLg+LsQDn0dU8qSV30uWaeGQsNDPssm0H5y6UPAWw@mail.gmail.com>
References: <20180831225616.29221-1-jmkrzyszt@gmail.com> <20180902120144.6855-1-jmkrzyszt@gmail.com>
 <20180902120144.6855-2-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180902120144.6855-2-jmkrzyszt@gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>, peter.korsgaard@barco.com, Peter Rosin <peda@axentia.se>, Ulf Hansson <ulf.hansson@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, Dominik Brodowski <linux@dominikbrodowski.net>, Greg KH <gregkh@linuxfoundation.org>, Kishon Vijay Abraham I <kishon@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald <pmeerw@pmeerw.net>, Jiri Slaby <jslaby@suse.com>, Willy Tarreau <w@1wt.eu>, "open list:DOCUMENTATION" <linux-doc@vger.>
List-Id: linux-mmc@vger.kernel.org

Hi Janusz,

On Sun, Sep 2, 2018 at 2:01 PM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
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
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Peter Korsgaard <peter.korsgaard@barco.com>
> Cc: Peter Rosin <peda@axentia.se>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Rojhalat Ibrahim <imr@rtschenk.de>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Russell King <rmk+kernel@armlinux.org.uk>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: Yegor Yefremov <yegorslists@googlemail.com>
> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> --- a/drivers/auxdisplay/hd44780.c
> +++ b/drivers/auxdisplay/hd44780.c
> @@ -62,17 +62,12 @@ static void hd44780_strobe_gpio(struct hd44780 *hd)
>  /* write to an LCD panel register in 8 bit GPIO mode */
>  static void hd44780_write_gpio8(struct hd44780 *hd, u8 val, unsigned int rs)
>  {
> -       int values[10]; /* for DATA[0-7], RS, RW */
> -       unsigned int i, n;
> -
> -       for (i = 0; i < 8; i++)
> -               values[PIN_DATA0 + i] = !!(val & BIT(i));
> -       values[PIN_CTRL_RS] = rs;
> -       n = 9;
> -       if (hd->pins[PIN_CTRL_RW]) {
> -               values[PIN_CTRL_RW] = 0;
> -               n++;
> -       }
> +       DECLARE_BITMAP(values, 10); /* for DATA[0-7], RS, RW */
> +       unsigned int n;
> +
> +       *values = val;

Given DECLARE_BITMAP() creates an array, the above line looks a bit funny now.

IMHO, either you use

    unsigned long values;
    values = val;
    __assign_bit(8, &values, rs);

or

    DECLARE_BITMAP(values, 10);
    values[0] = val;
    __assign_bit(8, values, rs);

Nevertheless, for hd44780.c:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
