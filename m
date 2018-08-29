From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [RFC RFT PATCH v4 1/4] gpiolib: Pass bitmaps, not integer arrays, to get/set array
Date: Wed, 29 Aug 2018 20:01:01 +0200
Message-ID: <21039309.e3MgZOjmZl@z50>
References: <20180813223448.21316-1-jmkrzyszt@gmail.com> <20180820234341.5271-2-jmkrzyszt@gmail.com> <CANiq72kM9bYJ1Q+dbLumjfQLZW223ZTrYEFqfQ2Jv2SAjrD1NA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CANiq72kM9bYJ1Q+dbLumjfQLZW223ZTrYEFqfQ2Jv2SAjrD1NA@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Peter Korsgaard <peter.korsgaard@barco.com>, Peter Rosin <peda@axentia.se>, Ulf Hansson <ulf.hansson@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, Dominik Brodowski <linux@dominikbrodowski.net>, Kishon Vijay Abraham I <kishon@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-gpio@vger.kernel.org, Linux Doc Mailing List <linux-doc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Wednesday, August 29, 2018 2:03:18 PM CEST Miguel Ojeda wrote:
> Hi Janusz,
> 
> On Tue, Aug 21, 2018 at 1:43 AM, Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> > Most users of get/set array functions iterate consecutive bits of data,
> > usually a single integer, while or processing array of results obtained
> > from or building an array of values to be passed to those functions.
> > Save time wasted on those iterations by changing the functions' API to
> > accept bitmaps.
> >
> > All current users are updated as well.
> >
> > More benefits from the change are expected as soon as planned support
> > for accepting/passing those bitmaps directly from/to respective GPIO
> > chip callbacks if applicable is implemented.
> >
> > Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> > ---
> >  Documentation/driver-api/gpio/consumer.rst  | 22 ++++----
> >  drivers/auxdisplay/hd44780.c                | 52 +++++++++--------
> 
> [CC'ing Willy and Geert for hd44780]
> 
> > diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
> > index f1a42f0f1ded..d340473aa142 100644
> > --- a/drivers/auxdisplay/hd44780.c
> > +++ b/drivers/auxdisplay/hd44780.c
> > @@ -62,20 +62,19 @@ static void hd44780_strobe_gpio(struct hd44780 *hd)
> >  /* write to an LCD panel register in 8 bit GPIO mode */
> >  static void hd44780_write_gpio8(struct hd44780 *hd, u8 val, unsigned int rs)
> >  {
> > -       int values[10]; /* for DATA[0-7], RS, RW */
> > -       unsigned int i, n;
> > +       unsigned long value_bitmap[1];  /* for DATA[0-7], RS, RW */
> 
> Why [1]? I understand it is because in other cases it may be more than
> one,

Yes, I tried to point out the fact the new API accepts a bitmap of an arbitrary 
length, and I tried to use the same code pattern across changes to the API 
users.

> but...
> 
> > +       unsigned int n;
> >
> > -       for (i = 0; i < 8; i++)
> > -               values[PIN_DATA0 + i] = !!(val & BIT(i));
> > -       values[PIN_CTRL_RS] = rs;
> > +       value_bitmap[0] = val;
> > +       __assign_bit(PIN_CTRL_RS, value_bitmap, rs);
> >         n = 9;
> >         if (hd->pins[PIN_CTRL_RW]) {
> > -               values[PIN_CTRL_RW] = 0;
> > +               __clear_bit(PIN_CTRL_RW, value_bitmap);
> >                 n++;
> >         }
> >
> >         /* Present the data to the port */
> > -       gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA0], values);
> > +       gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA0], value_bitmap);
> >
> >         hd44780_strobe_gpio(hd);
> >  }
> > @@ -83,32 +82,31 @@ static void hd44780_write_gpio8(struct hd44780 *hd, u8 val, unsigned int rs)
> >  /* write to an LCD panel register in 4 bit GPIO mode */
> >  static void hd44780_write_gpio4(struct hd44780 *hd, u8 val, unsigned int rs)
> >  {
> > -       int values[10]; /* for DATA[0-7], RS, RW, but DATA[0-3] is unused */
> > -       unsigned int i, n;
> > +       /* for DATA[0-7], RS, RW, but DATA[0-3] is unused */
> > +       unsigned long value_bitmap[0];
> 
> This one is even more strange... :-)

This one is an error, should be 1 of course :-), thanks.

> > +       unsigned int n;
> >
> >         /* High nibble + RS, RW */
> > -       for (i = 4; i < 8; i++)
> > -               values[PIN_DATA0 + i] = !!(val & BIT(i));
> > -       values[PIN_CTRL_RS] = rs;
> > +       value_bitmap[0] = val;
> > +       __assign_bit(PIN_CTRL_RS, value_bitmap, rs);
> >         n = 5;
> >         if (hd->pins[PIN_CTRL_RW]) {
> > -               values[PIN_CTRL_RW] = 0;
> > +               __clear_bit(PIN_CTRL_RW, value_bitmap);
> >                 n++;
> >         }
> > +       value_bitmap[0] = value_bitmap[0] >> PIN_DATA4;
> 
> Maybe >>=?

OK.

Answering you question below:
To make my changes as clear as I could imagine, I decided to use the same indexing as in the original code, i.e., assign high nibble of val to bits 4-7 and two other values - rs and an optional 0 - to bits 8 and 9, respectively.
Unlike in case of array of integers, where for the high nibble part you could just pass a pointer to a sub-array starting at the 5th value (i.e., &values[PIN_DATA4]), it was not possible to do the same for and arbitrary bit of a bitmap, e.g., pass a pointer to the 5th bit of *value_bitmap as an argument pointing to bit 0 of a bitmap to be processed. That's why I shifted the bitmap right by 4 bits.
Then, ...

> >
> >         /* Present the data to the port */
> > -       gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4],
> > -                                      &values[PIN_DATA4]);
> > +       gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4], value_bitmap);
> >
> >         hd44780_strobe_gpio(hd);
> >
> >         /* Low nibble */
> > -       for (i = 0; i < 4; i++)
> > -               values[PIN_DATA4 + i] = !!(val & BIT(i));
> > +       value_bitmap[0] &= ~((1 << PIN_DATA4) - 1);
> > +       value_bitmap[0] |= val & ~((1 << PIN_DATA4) - 1);
> 
> Are you sure this is correct? You are basically doing an or of
> value_bitmap and val and clearing the low-nibble.

having the rs and optional 0 already assigned to bits 4 and 5 of the bitmap, I just cleared bits 0-3 still containing the high nibble of val and assigned the low nibble of it to those bits, getting a result ready to be passed as an argument to gpiod_set_array_value_cansleep() below.

I hope I didn't miss anything.

Thanks,
Janusz

> >
> >         /* Present the data to the port */
> > -       gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4],
> > -                                      &values[PIN_DATA4]);
> > +       gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4], value_bitmap);
> >
> >         hd44780_strobe_gpio(hd);
> >  }
> 
> Cheers,
> Miguel
> 
