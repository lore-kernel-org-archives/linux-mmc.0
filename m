From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v7 4/4] gpiolib: Implement fast processing path in
 get/set array
Date: Thu, 20 Sep 2018 21:05:29 +0300
Message-ID: <20180920180529.hjc54yoqmvnpvvt7@mwanda>
References: <20180831225616.29221-1-jmkrzyszt@gmail.com>
 <CGME20180920101151eucas1p221f5a1715b8556bb9d99bf08fe09ce6f@eucas1p2.samsung.com>
 <20180920101151eucas1p221f5a1715b8556bb9d99bf08fe09ce6f~WE-_cEf4l0754207542eucas1p27@eucas1p2.samsung.com>
 <9860023.SlBYqtbjDV@z50>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <9860023.SlBYqtbjDV@z50>
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
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>, linux-doc@vger.kernel.org, linux-iio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Yegor Yefremov <yegorslists@googlemail.com>, "David S. Miller" <davem@davemloft.net>, linux-i2c@vger.kernel.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Marek Szyprowski <m.szyprowski@samsung.com>, devel@driverdev.osuosl.org, Florian Fainelli <f.fainelli@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Krzysztof Kozlowski <krzk@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Tony Lindgren <tony@atomide.com>, Peter Korsgaard <peter.korsgaard@barco.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Michael Hennerich <Michael.Hennerich@analog.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pe>
List-Id: linux-mmc@vger.kernel.org

On Thu, Sep 20, 2018 at 05:48:22PM +0200, Janusz Krzysztofik wrote:
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index a53d17745d21..5bc3447949c9 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -2880,7 +2880,7 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
>  			__set_bit(hwgpio, mask);
>  
>  			if (array_info)
> -				find_next_zero_bit(array_info->get_mask,
> +				i = find_next_zero_bit(array_info->get_mask,
>  						   array_size, i);

We could mark find_next_zero_bit() and friends as a __must_check
functions so we avoid this bug in the future.  I have a more complicated
idea how to detect these bugs in a generic way using Smatch but it will
take longer to implement.

regards,
dan carpenter
