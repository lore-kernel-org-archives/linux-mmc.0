From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v7 1/4] gpiolib: Pass bitmaps, not integer arrays, to
 get/set array
Date: Sun, 2 Sep 2018 15:21:54 +0200
Message-ID: <20180902132154.aishrx5shpvjrm2x@wunner.de>
References: <20180831225616.29221-1-jmkrzyszt@gmail.com>
 <20180902120144.6855-1-jmkrzyszt@gmail.com>
 <20180902120144.6855-2-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180902120144.6855-2-jmkrzyszt@gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>, Peter Korsgaard <peter.korsgaard@barco.com>, Peter Rosin <peda@axentia.se>, Ulf Hansson <ulf.hansson@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, Dominik Brodowski <linux@dominikbrodowski.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kishon Vijay Abraham I <kishon@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jiri Slaby <jslaby@suse.com>, Willy Tarreau <w@1wt.eu>
List-Id: linux-mmc@vger.kernel.org

On Sun, Sep 02, 2018 at 02:01:41PM +0200, Janusz Krzysztofik wrote:
> @@ -461,7 +461,7 @@ static long linehandle_ioctl(struct file *filep, unsigned int cmd,
>  
>  		/* Clamp all values to [0,1] */
>  		for (i = 0; i < lh->numdescs; i++)
> -			vals[i] = !!ghd.values[i];
> +			__assign_bit(i, vals, !!ghd.values[i]);

The "!!" becomes unnecessary and can be removed, same for the code
comment above.


>  /**
>   * gpiod_get_array_value() - read values from an array of GPIOs
> - * @array_size: number of elements in the descriptor / value arrays
> + * @array_size: number of elements in the descriptor array / value bitmap
>   * @desc_array: array of GPIO descriptors whose values will be read
> - * @value_array: array to store the read values
> + * @value_bitnap: bitmap to store the read values

Typo, s/bitnap/bitmap/

Otherwise LGTM.
