From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [PATCH v7 4/4] gpiolib: Implement fast processing path in get/set array
Date: Thu, 20 Sep 2018 17:48:22 +0200
Message-ID: <9860023.SlBYqtbjDV@z50>
References: <20180831225616.29221-1-jmkrzyszt@gmail.com> <CGME20180920101151eucas1p221f5a1715b8556bb9d99bf08fe09ce6f@eucas1p2.samsung.com> <20180920101151eucas1p221f5a1715b8556bb9d99bf08fe09ce6f~WE-_cEf4l0754207542eucas1p27@eucas1p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180920101151eucas1p221f5a1715b8556bb9d99bf08fe09ce6f~WE-_cEf4l0754207542eucas1p27@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>, Peter Korsgaard <peter.korsgaard@barco.com>, Peter Rosin <peda@axentia.se>, Ulf Hansson <ulf.hansson@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, Dominik Brodowski <linux@dominikbrodowski.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kishon Vijay Abraham I <kishon@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jiri Slaby <jslaby@suse.com>, Willy Tarreau <w@1wt.eu>
List-Id: linux-mmc@vger.kernel.org

On Thursday, September 20, 2018 12:11:48 PM CEST Marek Szyprowski wrote:
> Hi All,
> 
> On 2018-09-02 14:01, Janusz Krzysztofik wrote:
> > Certain GPIO descriptor arrays returned by gpio_get_array() may contain
> > information on direct mapping of array members to pins of a single GPIO
> > chip in hardware order.  In such cases, bitmaps of values can be passed
> > directly from/to the chip's .get/set_multiple() callbacks without
> > wasting time on iterations.
> >
> > Add respective code to gpiod_get/set_array_bitmap_complex() functions.
> > Pins not applicable for fast path are processed as before, skipping
> > over the 'fast' ones.
> >
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> 
> I've just noticed that this patch landed in today's linux-next. Sadly it
> breaks booting of Exynos5250-based Samsung Snow Chromebook (ARM 32bit,
> device-tree source arch/arm/boot/dts/exynos5250-snow.dts).
> 
> Booting hangs after detecting MMC cards. Reverting this patch fixes the
> boot. I will try later to add some debugs and investigate it further what
> really happens when booting hangs.

Hi Marek,

Thanks for reporting. Could you please try the following fix?

Thanks,
Janusz

>From d7ecd435bfb4972766b63ac383a43875700c7452 Mon Sep 17 00:00:00 2001
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
index a53d17745d21..5bc3447949c9 100644
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
+				i = find_next_zero_bit(array_info->get_mask, i,
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
