From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 1/2] gpiolib: Fix missing updates of bitmap index
Date: Mon, 24 Sep 2018 01:53:35 +0200
Message-ID: <20180923235336.22148-2-jmkrzyszt@gmail.com>
References: <2785169.v6aIfS3K2k@z50>
 <20180923235336.22148-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180923235336.22148-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>, Peter Korsgaard <peter.korsgaard@barco.com>, Peter Rosin <peda@axentia.se>, Ulf Hansson <ulf.hansson@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, Dominik Brodowski <linux@dominikbrodowski.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kishon Vijay Abraham I <kishon@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jiri Slaby <jslaby@suse.com>, Willy Tarreau <w@1wt.eu>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-mmc@vger.kernel.org

In new code introduced by commit b17566a6b08b ("gpiolib: Implement fast
processing path in get/set array"), bitmap index is not updated with
next found zero bit position as it should while skipping over pins
already processed via fast bitmap path, possibly resulting in an
infinite loop.  Fix it.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 drivers/gpio/gpiolib.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index a53d17745d21..7d9536a79a66 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2880,8 +2880,8 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 			__set_bit(hwgpio, mask);
 
 			if (array_info)
-				find_next_zero_bit(array_info->get_mask,
-						   array_size, i);
+				i = find_next_zero_bit(array_info->get_mask,
+						       array_size, i);
 			else
 				i++;
 		} while ((i < array_size) &&
@@ -2905,7 +2905,8 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 			trace_gpio_value(desc_to_gpio(desc), 1, value);
 
 			if (array_info)
-				find_next_zero_bit(array_info->get_mask, i, j);
+				j = find_next_zero_bit(array_info->get_mask, i,
+						       j);
 			else
 				j++;
 		}
@@ -3192,8 +3193,8 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 			}
 
 			if (array_info)
-				find_next_zero_bit(array_info->set_mask,
-						   array_size, i);
+				i = find_next_zero_bit(array_info->set_mask,
+						       array_size, i);
 			else
 				i++;
 		} while ((i < array_size) &&
-- 
2.16.4
