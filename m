From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v7 1/4] gpiolib: Pass bitmaps, not integer arrays, to
 get/set array
Date: Mon, 3 Sep 2018 16:24:16 +0200
Message-ID: <CAMuHMdXU394+E3Z3tR-6iRSiWVDWUpxPLZdxg8zdgWxW5+SOOg@mail.gmail.com>
References: <20180831225616.29221-1-jmkrzyszt@gmail.com> <20180902120144.6855-1-jmkrzyszt@gmail.com>
 <20180902120144.6855-2-jmkrzyszt@gmail.com> <20180903043129.GA17856@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180903043129.GA17856@bombadil.infradead.org>
Sender: netdev-owner@vger.kernel.org
To: Matthew Wilcox <willy@infradead.org>
Cc: Janusz Krzysztofik <jmkrzyszt@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>, peter.korsgaard@barco.com, Peter Rosin <peda@axentia.se>, Ulf Hansson <ulf.hansson@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, Dominik Brodowski <linux@dominikbrodowski.net>, Greg KH <gregkh@linuxfoundation.org>, Kishon Vijay Abraham I <kishon@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald <pmeerw@pmeerw.net>, Jiri Slaby <jslaby@suse.com>, Willy Tarreau <w@1wt.eu>
List-Id: linux-mmc@vger.kernel.org

On Mon, Sep 3, 2018 at 6:31 AM Matthew Wilcox <willy@infradead.org> wrote:
> > +++ b/drivers/auxdisplay/hd44780.c
> > @@ -62,17 +62,12 @@ static void hd44780_strobe_gpio(struct hd44780 *hd)
> >  /* write to an LCD panel register in 8 bit GPIO mode */
> >  static void hd44780_write_gpio8(struct hd44780 *hd, u8 val, unsigned int rs)
> >  {
> > -     int values[10]; /* for DATA[0-7], RS, RW */
> > -     unsigned int i, n;
> > -
> > -     for (i = 0; i < 8; i++)
> > -             values[PIN_DATA0 + i] = !!(val & BIT(i));
> > -     values[PIN_CTRL_RS] = rs;
> > -     n = 9;
> > -     if (hd->pins[PIN_CTRL_RW]) {
> > -             values[PIN_CTRL_RW] = 0;
> > -             n++;
> > -     }
> > +     DECLARE_BITMAP(values, 10); /* for DATA[0-7], RS, RW */
> > +     unsigned int n;
> > +
> > +     *values = val;
> > +     __assign_bit(8, values, rs);
> > +     n = hd->pins[PIN_CTRL_RW] ? 10 : 9;
>
> Doesn't this assume little endian bitmaps?  Has anyone tested this on
> big-endian machines?

include/linux/bitops.h:

static __always_inline void __assign_bit(long nr, volatile unsigned long *addr,
                                         bool value)
{
        if (value)
                __set_bit(nr, addr);
        else
                __clear_bit(nr, addr);
}

include/asm-generic/bitops/non-atomic.h:

static inline void __set_bit(int nr, volatile unsigned long *addr)
{
        unsigned long mask = BIT_MASK(nr);
        unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);

        *p  |= mask;
}

include/linux/bits.h:

#define BIT_MASK(nr)            (1UL << ((nr) % BITS_PER_LONG))

Looks like native endianness to me.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
