From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [PATCH v5 1/4] gpiolib: Pass bitmaps, not integer arrays, to get/set array
Date: Sun, 02 Sep 2018 12:19:11 +0200
Message-ID: <2195152.WzNjLO0DAH@z50>
References: <20180820234341.5271-1-jmkrzyszt@gmail.com> <20180829204900.19390-2-jmkrzyszt@gmail.com> <CANiq72kJT15ELkYr2U5r4-pvGunQFLmZ5dhdZLnjmM7NWBnkNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CANiq72kJT15ELkYr2U5r4-pvGunQFLmZ5dhdZLnjmM7NWBnkNQ@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Peter Korsgaard <peter.korsgaard@barco.com>, Peter Rosin <peda@axentia.se>, Ulf Hansson <ulf.hansson@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, Dominik Brodowski <linux@dominikbrodowski.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kishon Vijay Abraham I <kishon@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jiri Slaby <jslaby@suse.com>, Willy Tarreau <w@1wt.eu>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux
List-Id: linux-mmc@vger.kernel.org

Hi Miguel,

On Thursday, August 30, 2018 1:10:59 PM CEST Miguel Ojeda wrote:
> Hi Janusz,
> 
> On Wed, Aug 29, 2018 at 10:48 PM, Janusz Krzysztofik
> <jmkrzyszt@gmail.com> wrote:
> > ...
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
> > +       value_bitmap[0] >>= PIN_DATA4;
> >
> >         /* Present the data to the port */
> > -       gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4],
> > -                                      &values[PIN_DATA4]);
> > +       gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4], 
value_bitmap);
> >
> >         hd44780_strobe_gpio(hd);
> >
> >         /* Low nibble */
> > -       for (i = 0; i < 4; i++)
> > -               values[PIN_DATA4 + i] = !!(val & BIT(i));
> > +       value_bitmap[0] &= ~((1 << PIN_DATA4) - 1);
> > +       value_bitmap[0] |= val & ~((1 << PIN_DATA4) - 1);
> 
> This is still wrong! What I originally meant in my v4 review is that
> there is an extra ~ in the second line.

Indeed, that's wrong, I missed your original point, sorry.

> Also, a couple of general comments:
> 
>  - Please review the list of CCs (I was not CC'd originally, so maybe
> there are other maintainers that aren't, either)

That's probably because early versions of the series, prior to v4, were not 
touching existing GPIO API so there were no changes to users of gpiod_get/
set_array_value() and their variants. From v4 on, you are in the loop so don't 
worry, you haven't missed anything.
But anyway, thanks for your suggestion to review the Cc; list, I've done that 
for v7 and added still a few people who contributed most to the code being 
changed.

>  - In general, the new code seems harder to read than the original one
> (but that is my impression).

I hope we are slowly approaching acceptable readability in recent iterations.

Thanks,
Janusz
