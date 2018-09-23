From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 2/2] gpiolib: Fix array members of same chip processed separately
Date: Mon, 24 Sep 2018 01:53:36 +0200
Message-ID: <20180923235336.22148-3-jmkrzyszt@gmail.com>
References: <2785169.v6aIfS3K2k@z50>
 <20180923235336.22148-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180923235336.22148-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>, Peter Korsgaard <peter.korsgaard@barco.com>, Peter Rosin <peda@axentia.se>, Ulf Hansson <ulf.hansson@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, Dominik Brodowski <linux@dominikbrodowski.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kishon Vijay Abraham I <kishon@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jiri Slaby <jslaby@suse.com>, Willy Tarreau <w@1wt.eu>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-mmc@vger.kernel.org

New code introduced by commit bf9346f5d47b ("gpiolib: Identify arrays
matching GPIO hardware") forcibly tries to find an array member which
has its array index number equal to its hardware pin number and set
up an array info for possible fast bitmap processing of all arrray
pins belonging to that chip which also satisfy that numbering rule.

Depending on array content, it may happen that consecutive array
members which belong to the same chip but don't have array indexes
equal to their pin hardware numbers will be split into groups, some of
them processed together via the fast bitmap path, and rest of them
separetely.  However, applications may expect all those pins being
processed together with a single call to .set_multiple() chip callback,
like that was done before the change.

Limit applicability of fast bitmap processing path to cases where all
pins of consecutive array members starting from 0 which belong to the
same chip have their hardware numbers equal to their corresponding
array indexes.  That should still speed up processing of applications
using whole GPIO banks as I/O ports, while not breaking simultaneous
manipulation of consecutive pins of the same chip which don't follow
the equal numbering rule.

Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 Documentation/driver-api/gpio/board.rst | 19 +++++++++++++-----
 drivers/gpio/gpiolib.c                  | 35 +++++++++++++++++++++++----------
 2 files changed, 39 insertions(+), 15 deletions(-)

diff --git a/Documentation/driver-api/gpio/board.rst b/Documentation/driver-api/gpio/board.rst
index c66821e033c2..a0f294e2e250 100644
--- a/Documentation/driver-api/gpio/board.rst
+++ b/Documentation/driver-api/gpio/board.rst
@@ -202,9 +202,18 @@ mapped to the device determines if the array qualifies for fast bitmap
 processing.  If yes, a bitmap is passed over get/set array functions directly
 between a caller and a respective .get/set_multiple() callback of a GPIO chip.
 
-In order to qualify for fast bitmap processing, the pin mapping must meet the
+In order to qualify for fast bitmap processing, the array must meet the
 following requirements:
-- it must belong to the same chip as other 'fast' pins of the function,
-- its index within the function must match its hardware number within the chip.
-
-Open drain and open source pins are excluded from fast bitmap output processing.
+- pin hardware number of array member 0 must also be 0,
+- pin hardware numbers of consecutive array members which belong to the same
+  chip as member 0 does must also match their array indexes.
+
+Otherwise fast bitmap processing path is not used in order to avoid consecutive
+pins which belong to the same chip but are not in hardware order being processed
+separately.
+
+If the array applies for fast bitmap processing path, pins which belong to
+different chips than member 0 does, as well as those with indexes different from
+their hardware pin numbers, are excluded from the fast path, both input and
+output.  Moreover, open drain and open source pins are excluded from fast bitmap
+output processing.
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 7d9536a79a66..6ae13e3e05f1 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4376,11 +4376,10 @@ struct gpio_descs *__must_check gpiod_get_array(struct device *dev,
 
 		chip = gpiod_to_chip(desc);
 		/*
-		 * Select a chip of first array member
-		 * whose index matches its pin hardware number
-		 * as a candidate for fast bitmap processing.
+		 * If pin hardware number of array member 0 is also 0, select
+		 * its chip as a candidate for fast bitmap processing path.
 		 */
-		if (!array_info && gpio_chip_hwgpio(desc) == descs->ndescs) {
+		if (descs->ndescs == 0 && gpio_chip_hwgpio(desc) == 0) {
 			struct gpio_descs *array;
 
 			bitmap_size = BITS_TO_LONGS(chip->ngpio > count ?
@@ -4414,14 +4413,30 @@ struct gpio_descs *__must_check gpiod_get_array(struct device *dev,
 				   count - descs->ndescs);
 			descs->info = array_info;
 		}
-		/*
-		 * Unmark members which don't qualify for fast bitmap
-		 * processing (different chip, not in hardware order)
-		 */
-		if (array_info && (chip != array_info->chip ||
-		    gpio_chip_hwgpio(desc) != descs->ndescs)) {
+		/* Unmark array members which don't belong to the 'fast' chip */
+		if (array_info && array_info->chip != chip) {
 			__clear_bit(descs->ndescs, array_info->get_mask);
 			__clear_bit(descs->ndescs, array_info->set_mask);
+		}
+		/*
+		 * Detect array members which belong to the 'fast' chip
+		 * but their pins are not in hardware order.
+		 */
+		else if (array_info &&
+			   gpio_chip_hwgpio(desc) != descs->ndescs) {
+			/*
+			 * Don't use fast path if all array members processed so
+			 * far belong to the same chip as this one but its pin
+			 * hardware number is different from its array index.
+			 */
+			if (bitmap_full(array_info->get_mask, descs->ndescs)) {
+				array_info = NULL;
+			} else {
+				__clear_bit(descs->ndescs,
+					    array_info->get_mask);
+				__clear_bit(descs->ndescs,
+					    array_info->set_mask);
+			}
 		} else if (array_info) {
 			/* Exclude open drain or open source from fast output */
 			if (gpiochip_line_is_open_drain(chip, descs->ndescs) ||
-- 
2.16.4
