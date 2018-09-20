From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [PATCH v7 4/4] gpiolib: Implement fast processing path in get/set
 array
Date: Thu, 20 Sep 2018 18:21:09 +0200
Message-ID: <15226900.TQMLYV7PZ0@z50>
References: <20180831225616.29221-1-jmkrzyszt@gmail.com>
 <20180920101151eucas1p221f5a1715b8556bb9d99bf08fe09ce6f~WE-_cEf4l0754207542eucas1p27@eucas1p2.samsung.com>
 <9860023.SlBYqtbjDV@z50>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
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
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>, linux-doc@vger.kernel.org, linux-iio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Peter Rosin <peda@axentia.se>, netdev@vger.kernel.org, linux-i2c@vger.kernel.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, devel@driverdev.osuosl.org, Florian Fainelli <f.fainelli@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Tony Lindgren <tony@atomide.com>, Lukas Wunner <lukas@wunner.de>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Michael Hennerich <Michael.Hennerich@analog.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-gpio@vger.kernel.org, Russ
List-Id: linux-mmc@vger.kernel.org

On Thursday, September 20, 2018 5:48:22 PM CEST Janusz Krzysztofik wrote:
> On Thursday, September 20, 2018 12:11:48 PM CEST Marek Szyprowski wrote:
> > Hi All,
> > 
> > On 2018-09-02 14:01, Janusz Krzysztofik wrote:
> > > Certain GPIO descriptor arrays returned by gpio_get_array() may contain
> > > information on direct mapping of array members to pins of a single GPIO
> > > chip in hardware order.  In such cases, bitmaps of values can be passed
> > > directly from/to the chip's .get/set_multiple() callbacks without
> > > wasting time on iterations.
> > >
> > > Add respective code to gpiod_get/set_array_bitmap_complex() functions.
> > > Pins not applicable for fast path are processed as before, skipping
> > > over the 'fast' ones.
> > >
> > > Cc: Jonathan Corbet <corbet@lwn.net>
> > > Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> > 
> > I've just noticed that this patch landed in today's linux-next. Sadly it
> > breaks booting of Exynos5250-based Samsung Snow Chromebook (ARM 32bit,
> > device-tree source arch/arm/boot/dts/exynos5250-snow.dts).
> > 
> > Booting hangs after detecting MMC cards. Reverting this patch fixes the
> > boot. I will try later to add some debugs and investigate it further what
> > really happens when booting hangs.
> 
> Hi Marek,
> 
> Thanks for reporting. Could you please try the following fix?

Hi again,

I realized the patch was not correct, j, not i, should be updated in second 
hunk. Please try the following one.

Thanks,
Janusz

>From a919c504850f6cb40e8e81267a3a37537f7c4fd4 Mon Sep 17 00:00:00 2001
From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Date: Thu, 20 Sep 2018 17:37:21 +0200
Subject: [PATCH] gpiolib: Fix bitmap index not updated

While skipping fast path bits, bitmap index is not updated with next
found zero bit position. Fix it.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 drivers/gpio/gpiolib.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index a53d17745d21..369bdd358fcc 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2880,7 +2880,7 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 			__set_bit(hwgpio, mask);
 
 			if (array_info)
-				find_next_zero_bit(array_info->get_mask,
+				i = find_next_zero_bit(array_info->get_mask,
 						   array_size, i);
 			else
 				i++;
@@ -2905,7 +2905,8 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 			trace_gpio_value(desc_to_gpio(desc), 1, value);
 
 			if (array_info)
-				find_next_zero_bit(array_info->get_mask, i, j);
+				j = find_next_zero_bit(array_info->get_mask, i,
+						       j);
 			else
 				j++;
 		}
@@ -3192,7 +3193,7 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 			}
 
 			if (array_info)
-				find_next_zero_bit(array_info->set_mask,
+				i = find_next_zero_bit(array_info->set_mask,
 						   array_size, i);
 			else
 				i++;
-- 
2.16.4
