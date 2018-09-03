From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v7 1/4] gpiolib: Pass bitmaps, not integer arrays, to
 get/set array
Date: Sun, 2 Sep 2018 21:31:29 -0700
Message-ID: <20180903043129.GA17856@bombadil.infradead.org>
References: <20180831225616.29221-1-jmkrzyszt@gmail.com>
 <20180902120144.6855-1-jmkrzyszt@gmail.com>
 <20180902120144.6855-2-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180902120144.6855-2-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>, Peter Korsgaard <peter.korsgaard@barco.com>, Peter Rosin <peda@axentia.se>, Ulf Hansson <ulf.hansson@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, Dominik Brodowski <linux@dominikbrodowski.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kishon Vijay Abraham I <kishon@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jiri Slaby <jslaby@suse.com>, Willy Tarreau <w@1wt.eu>
List-Id: linux-mmc@vger.kernel.org

> +++ b/drivers/auxdisplay/hd44780.c
> @@ -62,17 +62,12 @@ static void hd44780_strobe_gpio(struct hd44780 *hd)
>  /* write to an LCD panel register in 8 bit GPIO mode */
>  static void hd44780_write_gpio8(struct hd44780 *hd, u8 val, unsigned int rs)
>  {
> -	int values[10];	/* for DATA[0-7], RS, RW */
> -	unsigned int i, n;
> -
> -	for (i = 0; i < 8; i++)
> -		values[PIN_DATA0 + i] = !!(val & BIT(i));
> -	values[PIN_CTRL_RS] = rs;
> -	n = 9;
> -	if (hd->pins[PIN_CTRL_RW]) {
> -		values[PIN_CTRL_RW] = 0;
> -		n++;
> -	}
> +	DECLARE_BITMAP(values, 10); /* for DATA[0-7], RS, RW */
> +	unsigned int n;
> +
> +	*values = val;
> +	__assign_bit(8, values, rs);
> +	n = hd->pins[PIN_CTRL_RW] ? 10 : 9;

Doesn't this assume little endian bitmaps?  Has anyone tested this on
big-endian machines?
