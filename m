From: Peter Rosin <peda@axentia.se>
Subject: Re: [RFC RFT PATCH v4 1/4] gpiolib: Pass bitmaps, not integer arrays,
 to get/set array
Date: Tue, 21 Aug 2018 08:49:24 +0200
Message-ID: <0e79bdc3-ca20-6823-c86f-5e9da7dafbc9@axentia.se>
References: <20180813223448.21316-1-jmkrzyszt@gmail.com>
 <20180820234341.5271-1-jmkrzyszt@gmail.com>
 <20180820234341.5271-2-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180820234341.5271-2-jmkrzyszt@gmail.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>, Peter Korsgaard <peter.korsgaard@barco.com>, Ulf Hansson <ulf.hansson@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, Dominik Brodowski <linux@dominikbrodowski.net>, Kishon Vijay Abraham I <kishon@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.
List-Id: linux-mmc@vger.kernel.org

On 2018-08-21 01:43, Janusz Krzysztofik wrote:
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
>  drivers/bus/ts-nbus.c                       | 19 ++-----
>  drivers/gpio/gpio-max3191x.c                | 17 +++---
>  drivers/gpio/gpiolib.c                      | 86 +++++++++++++++--------------
>  drivers/gpio/gpiolib.h                      |  4 +-
>  drivers/i2c/muxes/i2c-mux-gpio.c            |  3 +-
>  drivers/mmc/core/pwrseq_simple.c            | 13 ++---
>  drivers/mux/gpio.c                          |  4 +-
>  drivers/net/phy/mdio-mux-gpio.c             |  3 +-
>  drivers/pcmcia/soc_common.c                 | 11 ++--
>  drivers/phy/motorola/phy-mapphone-mdm6600.c | 17 +++---
>  drivers/staging/iio/adc/ad7606.c            |  9 +--
>  drivers/tty/serial/serial_mctrl_gpio.c      |  7 ++-
>  include/linux/gpio/consumer.h               | 18 +++---
>  15 files changed, 138 insertions(+), 147 deletions(-)
> 

*snip*

> diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
> index 401308e3d036..d675e0ca2fa4 100644
> --- a/drivers/i2c/muxes/i2c-mux-gpio.c
> +++ b/drivers/i2c/muxes/i2c-mux-gpio.c
> @@ -27,13 +27,14 @@ struct gpiomux {
>  
>  static void i2c_mux_gpio_set(const struct gpiomux *mux, unsigned val)
>  {
> +	unsigned long value_bitmap[1] = { val, };
>  	int i;
>  
>  	for (i = 0; i < mux->data.n_gpios; i++)
>  		mux->values[i] = (val >> i) & 1;
>  
>  	gpiod_set_array_value_cansleep(mux->data.n_gpios,
> -				       mux->gpios, mux->values);
> +				       mux->gpios, value_bitmap);
>  }
>  
>  static int i2c_mux_gpio_select(struct i2c_mux_core *muxc, u32 chan)

Please take the opportunity to completely get rid of the values member
in struct mux_gpio. It no longer serves any purpose.

*snip*

> diff --git a/drivers/mux/gpio.c b/drivers/mux/gpio.c
> index 6fdd9316db8b..cc2d5f50472a 100644
> --- a/drivers/mux/gpio.c
> +++ b/drivers/mux/gpio.c
> @@ -23,14 +23,14 @@ struct mux_gpio {
>  static int mux_gpio_set(struct mux_control *mux, int state)
>  {
>  	struct mux_gpio *mux_gpio = mux_chip_priv(mux->chip);
> +	unsigned long value_bitmap[1] = { state, };
>  	int i;
>  
>  	for (i = 0; i < mux_gpio->gpios->ndescs; i++)
>  		mux_gpio->val[i] = (state >> i) & 1;
>  
>  	gpiod_set_array_value_cansleep(mux_gpio->gpios->ndescs,
> -				       mux_gpio->gpios->desc,
> -				       mux_gpio->val);
> +				       mux_gpio->gpios->desc, value_bitmap);
>  
>  	return 0;
>  }

Dito (but the member name is val).

*snip*

Cheers,
Peter
