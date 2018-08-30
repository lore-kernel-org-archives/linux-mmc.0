From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v5 1/4] gpiolib: Pass bitmaps, not integer arrays, to
 get/set array
Date: Thu, 30 Aug 2018 06:30:11 +0200
Message-ID: <9d9a4272-9a31-937d-720b-1946930dec09@axentia.se>
References: <20180820234341.5271-1-jmkrzyszt@gmail.com>
 <20180829204900.19390-1-jmkrzyszt@gmail.com>
 <20180829204900.19390-2-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180829204900.19390-2-jmkrzyszt@gmail.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>, Peter Korsgaard <peter.korsgaard@barco.com>, Ulf Hansson <ulf.hansson@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, Dominik Brodowski <linux@dominikbrodowski.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kishon Vijay Abraham I <kishon@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jiri Slaby <jslaby@suse.com>, Willy Tarreau <w@1wt.eu>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-doc@vger.kernel.org, linux-i2
List-Id: linux-mmc@vger.kernel.org

On 2018-08-29 22:48, Janusz Krzysztofik wrote:
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
> index 401308e3d036..4e36e0eac7a3 100644
> --- a/drivers/i2c/muxes/i2c-mux-gpio.c
> +++ b/drivers/i2c/muxes/i2c-mux-gpio.c
> @@ -22,18 +22,16 @@ struct gpiomux {
>  	struct i2c_mux_gpio_platform_data data;
>  	unsigned gpio_base;
>  	struct gpio_desc **gpios;
> -	int *values;
> +	int *values; /* FIXME: no longer needed */

That's a half-measure...

>  };
>  
>  static void i2c_mux_gpio_set(const struct gpiomux *mux, unsigned val)
>  {
> +	unsigned long value_bitmap[1] = { val, };
>  	int i;

...and i is no longer needed. Hmm, I'd expect a warning about that?

>  
> -	for (i = 0; i < mux->data.n_gpios; i++)
> -		mux->values[i] = (val >> i) & 1;
> -
>  	gpiod_set_array_value_cansleep(mux->data.n_gpios,
> -				       mux->gpios, mux->values);
> +				       mux->gpios, value_bitmap);
>  }
>  
>  static int i2c_mux_gpio_select(struct i2c_mux_core *muxc, u32 chan)
> diff --git a/drivers/mux/gpio.c b/drivers/mux/gpio.c
> index 6fdd9316db8b..734e1b43aed6 100644
> --- a/drivers/mux/gpio.c
> +++ b/drivers/mux/gpio.c
> @@ -17,20 +17,17 @@
>  
>  struct mux_gpio {
>  	struct gpio_descs *gpios;
> -	int *val;
> +	int *val; /* FIXME: no longer needed */
>  };
>  
>  static int mux_gpio_set(struct mux_control *mux, int state)
>  {
>  	struct mux_gpio *mux_gpio = mux_chip_priv(mux->chip);
> +	unsigned long value_bitmap[1] = { state, };
>  	int i;
>  
> -	for (i = 0; i < mux_gpio->gpios->ndescs; i++)
> -		mux_gpio->val[i] = (state >> i) & 1;
> -
>  	gpiod_set_array_value_cansleep(mux_gpio->gpios->ndescs,
> -				       mux_gpio->gpios->desc,
> -				       mux_gpio->val);
> +				       mux_gpio->gpios->desc, value_bitmap);
>  
>  	return 0;
>  }

Dito for this driver. Just squash the following and be done with
it, no attribution needed...

With that (for the changes in i2c-mux-gpio.c and mux/gpio.c)

Reviewed-by: Peter Rosin <peda@axentia.se>

Linus, I expect this will will end up in some immutable branch for me
to pick up, in case I need to? Not that I expect further work to clash
in these two drivers, but...

Cheers,
Peter

diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index 4e36e0eac7a3..06a89a29250a 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -22,13 +22,11 @@ struct gpiomux {
 	struct i2c_mux_gpio_platform_data data;
 	unsigned gpio_base;
 	struct gpio_desc **gpios;
-	int *values; /* FIXME: no longer needed */
 };
 
 static void i2c_mux_gpio_set(const struct gpiomux *mux, unsigned val)
 {
 	unsigned long value_bitmap[1] = { val, };
-	int i;
 
 	gpiod_set_array_value_cansleep(mux->data.n_gpios,
 				       mux->gpios, value_bitmap);
@@ -180,15 +178,13 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 		return -EPROBE_DEFER;
 
 	muxc = i2c_mux_alloc(parent, &pdev->dev, mux->data.n_values,
-			     mux->data.n_gpios * sizeof(*mux->gpios) +
-			     mux->data.n_gpios * sizeof(*mux->values), 0,
+			     mux->data.n_gpios * sizeof(*mux->gpios), 0,
 			     i2c_mux_gpio_select, NULL);
 	if (!muxc) {
 		ret = -ENOMEM;
 		goto alloc_failed;
 	}
 	mux->gpios = muxc->priv;
-	mux->values = (int *)(mux->gpios + mux->data.n_gpios);
 	muxc->priv = mux;
 
 	platform_set_drvdata(pdev, muxc);
diff --git a/drivers/mux/gpio.c b/drivers/mux/gpio.c
index 734e1b43aed6..eb1798677dfd 100644
--- a/drivers/mux/gpio.c
+++ b/drivers/mux/gpio.c
@@ -17,14 +17,12 @@
 
 struct mux_gpio {
 	struct gpio_descs *gpios;
-	int *val; /* FIXME: no longer needed */
 };
 
 static int mux_gpio_set(struct mux_control *mux, int state)
 {
 	struct mux_gpio *mux_gpio = mux_chip_priv(mux->chip);
 	unsigned long value_bitmap[1] = { state, };
-	int i;
 
 	gpiod_set_array_value_cansleep(mux_gpio->gpios->ndescs,
 				       mux_gpio->gpios->desc, value_bitmap);
@@ -55,13 +53,11 @@ static int mux_gpio_probe(struct platform_device *pdev)
 	if (pins < 0)
 		return pins;
 
-	mux_chip = devm_mux_chip_alloc(dev, 1, sizeof(*mux_gpio) +
-				       pins * sizeof(*mux_gpio->val));
+	mux_chip = devm_mux_chip_alloc(dev, 1, sizeof(*mux_gpio));
 	if (IS_ERR(mux_chip))
 		return PTR_ERR(mux_chip);
 
 	mux_gpio = mux_chip_priv(mux_chip);
-	mux_gpio->val = (int *)(mux_gpio + 1);
 	mux_chip->ops = &mux_gpio_ops;
 
 	mux_gpio->gpios = devm_gpiod_get_array(dev, "mux", GPIOD_OUT_LOW);
