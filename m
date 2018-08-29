From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [RFC RFT PATCH v4 1/4] gpiolib: Pass bitmaps, not integer arrays,
 to get/set array
Date: Wed, 29 Aug 2018 14:03:18 +0200
Message-ID: <CANiq72kM9bYJ1Q+dbLumjfQLZW223ZTrYEFqfQ2Jv2SAjrD1NA@mail.gmail.com>
References: <20180813223448.21316-1-jmkrzyszt@gmail.com>
 <20180820234341.5271-1-jmkrzyszt@gmail.com>
 <20180820234341.5271-2-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20180820234341.5271-2-jmkrzyszt@gmail.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, linux-iio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Network Development <netdev@vger.kernel.org>, linux-i2c@vger.kernel.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, devel@driverdev.osuosl.org, Florian Fainelli <f.fainelli@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Kishon Vijay Abraham I <kishon@ti.com>, Willy Tarreau <w@1wt.eu>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Michael Hennerich <Michael.Hennerich@analog.com>, linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mmc@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Peter Rosin <peda@axe>
List-Id: linux-mmc@vger.kernel.org

Hi Janusz,

On Tue, Aug 21, 2018 at 1:43 AM, Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> Most users of get/set array functions iterate consecutive bits of data,
> usually a single integer, while or processing array of results obtained
> from or building an array of values to be passed to those functions.
> Save time wasted on those iterations by changing the functions' API to
> accept bitmaps.
>
> All current users are updated as well.
>
> More benefits from the change are expected as soon as planned support
> for accepting/passing those bitmaps directly from/to respective GPIO
> chip callbacks if applicable is implemented.
>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> ---
>  Documentation/driver-api/gpio/consumer.rst  | 22 ++++----
>  drivers/auxdisplay/hd44780.c                | 52 +++++++++--------

[CC'ing Willy and Geert for hd44780]

> diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
> index f1a42f0f1ded..d340473aa142 100644
> --- a/drivers/auxdisplay/hd44780.c
> +++ b/drivers/auxdisplay/hd44780.c
> @@ -62,20 +62,19 @@ static void hd44780_strobe_gpio(struct hd44780 *hd)
>  /* write to an LCD panel register in 8 bit GPIO mode */
>  static void hd44780_write_gpio8(struct hd44780 *hd, u8 val, unsigned int rs)
>  {
> -       int values[10]; /* for DATA[0-7], RS, RW */
> -       unsigned int i, n;
> +       unsigned long value_bitmap[1];  /* for DATA[0-7], RS, RW */

Why [1]? I understand it is because in other cases it may be more than
one, but...

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
> +       unsigned long value_bitmap[0];

This one is even more strange... :-)

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
> +       value_bitmap[0] = value_bitmap[0] >> PIN_DATA4;

Maybe >>=?

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

Are you sure this is correct? You are basically doing an or of
value_bitmap and val and clearing the low-nibble.

>
>         /* Present the data to the port */
> -       gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4],
> -                                      &values[PIN_DATA4]);
> +       gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4], value_bitmap);
>
>         hd44780_strobe_gpio(hd);
>  }

Cheers,
Miguel
