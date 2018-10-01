From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] gpiolib: Fix incorrect use of find_next_zero_bit()
Date: Mon, 1 Oct 2018 08:46:16 +0200
Message-ID: <20181001064618eucas1p28ccab6242ec7f562912a83584a65e768~ZaSpX0FfS1643816438eucas1p2f@eucas1p2.samsung.com>
References: <20180923235336.22148-2-jmkrzyszt@gmail.com>
 <CGME20180929121916epcas4p2eb8be6cdd6b11d675510f0a54b546bb5@epcas4p2.samsung.com>
 <20180929122022.6825-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20180929122022.6825-1-jmkrzyszt@gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Yegor Yefremov <yegorslists@googlemail.com>, netdev@vger.kernel.org, linux-i2c@vger.kernel.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, devel@driverdev.osuosl.org, Florian Fainelli <f.fainelli@gmail.com>, Peter Rosin <peda@axentia.se>, Krzysztof Kozlowski <krzk@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, linux-iio@vger.kernel.org, Peter Korsgaard <peter.korsgaard@barco.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Michael Hennerich <Michael.Hennerich@analog.com>, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, linux-gpio@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, Lars-Peter Clausen <lars@metafoo.de>, Sebastien
List-Id: linux-mmc@vger.kernel.org

Hi Janusz,

On 2018-09-29 14:20, Janusz Krzysztofik wrote:
> Commit b17566a6b08b ("gpiolib: Implement fast processing path in
> get/set array"), already fixed to some extent with commit 5d581d7e8cdc
> ("gpiolib: Fix missing updates of bitmap index"), introduced a new mode
> of processing bitmaps where bits applicable for fast bitmap processing
> path are supposed to be skipped while iterating bits which don't apply.
> Unfortunately, find_next_zero_bit() function supposed to skip over
> those fast bits is always called with a 'start' argument equal to an
> index of last zero bit found and returns that index value again an
> again, causing an infinite loop.
>
> Fix it by incrementing the index uncoditionally before
> find_next_zero_bit() is optionally called.
>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
> Marek,
>
> Could you please test it on top of next-20180920 with "gpiolib: Fix
> missing updates of bitmap index" and optionally "mmc: pwrseq_simple:
> Fix incorrect handling of GPIO bitmap" also applied?

This patch finally fixes the boot issue on Samsung Chromebook Snow.
Thanks!

>
> Thanks,
> Janusz
>
>
>  drivers/gpio/gpiolib.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 6ae13e3e05f1..940b543e966d 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -2878,12 +2878,11 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
>  			int hwgpio = gpio_chip_hwgpio(desc);
>  
>  			__set_bit(hwgpio, mask);
> +			i++;
>  
>  			if (array_info)
>  				i = find_next_zero_bit(array_info->get_mask,
>  						       array_size, i);
> -			else
> -				i++;
>  		} while ((i < array_size) &&
>  			 (desc_array[i]->gdev->chip == chip));
>  
> @@ -2903,12 +2902,11 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
>  				value = !value;
>  			__assign_bit(j, value_bitmap, value);
>  			trace_gpio_value(desc_to_gpio(desc), 1, value);
> +			j++;
>  
>  			if (array_info)
>  				j = find_next_zero_bit(array_info->get_mask, i,
>  						       j);
> -			else
> -				j++;
>  		}
>  
>  		if (mask != fastpath)
> @@ -3191,12 +3189,11 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
>  					__clear_bit(hwgpio, bits);
>  				count++;
>  			}
> +			i++;
>  
>  			if (array_info)
>  				i = find_next_zero_bit(array_info->set_mask,
>  						       array_size, i);
> -			else
> -				i++;
>  		} while ((i < array_size) &&
>  			 (desc_array[i]->gdev->chip == chip));
>  		/* push collected bits to outputs */

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
