From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v6 1/4] gpiolib: Pass bitmaps, not integer arrays, to
 get/set array
Date: Sat, 1 Sep 2018 02:23:17 +0200
Message-ID: <47a7e66f-8635-7131-8a0c-c26cf849fd50@axentia.se>
References: <20180829204900.19390-1-jmkrzyszt@gmail.com>
 <20180831225616.29221-1-jmkrzyszt@gmail.com>
 <20180831225616.29221-2-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180831225616.29221-2-jmkrzyszt@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>, Peter Korsgaard <peter.korsgaard@barco.com>, Ulf Hansson <ulf.hansson@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, Dominik Brodowski <linux@dominikbrodowski.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kishon Vijay Abraham I <kishon@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jiri Slaby <jslaby@suse.com>, Willy Tarreau <w@1wt.eu>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-doc@vger.kernel.org, linux-i2
List-Id: linux-mmc@vger.kernel.org

On 2018-09-01 00:56, Janusz Krzysztofik wrote:
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

> diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
> index 401308e3d036..e28ddc20000d 100644
> --- a/drivers/i2c/muxes/i2c-mux-gpio.c
> +++ b/drivers/i2c/muxes/i2c-mux-gpio.c
> @@ -22,18 +22,16 @@ struct gpiomux {
>  	struct i2c_mux_gpio_platform_data data;
>  	unsigned gpio_base;
>  	struct gpio_desc **gpios;
> -	int *values;
>  };
>  
>  static void i2c_mux_gpio_set(const struct gpiomux *mux, unsigned val)
>  {
> -	int i;
> -
> -	for (i = 0; i < mux->data.n_gpios; i++)
> -		mux->values[i] = (val >> i) & 1;
> +	DECLARE_BITMAP(value_bitmap, mux->data.n_gpios);

Picking a random driver for this comment, it applies to many of them.

I think this creates a VLA? Can't you, for the bit-count, just go with
BITS_PER_TYPE(unsigned)? Or whatever is appropriate for the driver
in question.

Also, I find that where you use DECLARE_BITMAP, the _bitmap suffix is
just noise and I would very much like to zap it.

Cheers,
Peter

> +	
> +	*value_bitmap = val;
>  
>  	gpiod_set_array_value_cansleep(mux->data.n_gpios,
> -				       mux->gpios, mux->values);
> +				       mux->gpios, value_bitmap);
>  }
>  
>  static int i2c_mux_gpio_select(struct i2c_mux_core *muxc, u32 chan)
> @@ -182,15 +180,13 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
>  		return -EPROBE_DEFER;
>  
>  	muxc = i2c_mux_alloc(parent, &pdev->dev, mux->data.n_values,
> -			     mux->data.n_gpios * sizeof(*mux->gpios) +
> -			     mux->data.n_gpios * sizeof(*mux->values), 0,
> +			     mux->data.n_gpios * sizeof(*mux->gpios), 0,
>  			     i2c_mux_gpio_select, NULL);
>  	if (!muxc) {
>  		ret = -ENOMEM;
>  		goto alloc_failed;
>  	}
>  	mux->gpios = muxc->priv;
> -	mux->values = (int *)(mux->gpios + mux->data.n_gpios);
>  	muxc->priv = mux;
>  
>  	platform_set_drvdata(pdev, muxc);
