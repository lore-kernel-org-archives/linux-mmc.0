From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v6 4/4] gpiolib: Implement fast processing path in get/set array
Date: Sat,  1 Sep 2018 00:56:16 +0200
Message-ID: <20180831225616.29221-5-jmkrzyszt@gmail.com>
References: <20180829204900.19390-1-jmkrzyszt@gmail.com>
 <20180831225616.29221-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180831225616.29221-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>, Peter Korsgaard <peter.korsgaard@barco.com>, Peter Rosin <peda@axentia.se>, Ulf Hansson <ulf.hansson@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, Dominik Brodowski <linux@dominikbrodowski.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kishon Vijay Abraham I <kishon@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jiri Slaby <jslaby@suse.com>, Willy Tarreau <w@1wt.eu>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-mmc@vger.kernel.org

Certain GPIO descriptor arrays returned by gpio_get_array() may contain
information on direct mapping of array members to pins of a single GPIO
chip in hardware order.  In such cases, bitmaps of values can be passed
directly from/to the chip's .get/set_multiple() callbacks without
wasting time on iterations.

Add respective code to gpiod_get/set_array_bitmap_complex() functions.
Pins not applicable for fast path are processed as before, skipping
over the 'fast' ones.

Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 Documentation/driver-api/gpio/board.rst    | 15 ++++++
 Documentation/driver-api/gpio/consumer.rst |  8 +++
 drivers/gpio/gpiolib.c                     | 87 ++++++++++++++++++++++++++++--
 3 files changed, 105 insertions(+), 5 deletions(-)

diff --git a/Documentation/driver-api/gpio/board.rst b/Documentation/driver-api/gpio/board.rst
index 2c112553df84..c66821e033c2 100644
--- a/Documentation/driver-api/gpio/board.rst
+++ b/Documentation/driver-api/gpio/board.rst
@@ -193,3 +193,18 @@ And the table can be added to the board code as follows::
 
 The line will be hogged as soon as the gpiochip is created or - in case the
 chip was created earlier - when the hog table is registered.
+
+Arrays of pins
+--------------
+In addition to requesting pins belonging to a function one by one, a device may
+also request an array of pins assigned to the function.  The way those pins are
+mapped to the device determines if the array qualifies for fast bitmap
+processing.  If yes, a bitmap is passed over get/set array functions directly
+between a caller and a respective .get/set_multiple() callback of a GPIO chip.
+
+In order to qualify for fast bitmap processing, the pin mapping must meet the
+following requirements:
+- it must belong to the same chip as other 'fast' pins of the function,
+- its index within the function must match its hardware number within the chip.
+
+Open drain and open source pins are excluded from fast bitmap output processing.
diff --git a/Documentation/driver-api/gpio/consumer.rst b/Documentation/driver-api/gpio/consumer.rst
index 0afd95a12b10..cf992e5ab976 100644
--- a/Documentation/driver-api/gpio/consumer.rst
+++ b/Documentation/driver-api/gpio/consumer.rst
@@ -388,6 +388,14 @@ array_info should be set to NULL.
 Note that for optimal performance GPIOs belonging to the same chip should be
 contiguous within the array of descriptors.
 
+Still better performance may be achieved if array indexes of the descriptors
+match hardware pin numbers of a single chip.  If an array passed to a get/set
+array function matches the one obtained from gpiod_get_array() and array_info
+associated with the array is also passed, the function may take a fast bitmap
+processing path, passing the value_bitmap argument directly to the respective
+.get/set_multiple() callback of the chip.  That allows for utilization of GPIO
+banks as data I/O ports without much loss of performance.
+
 The return value of gpiod_get_array_value() and its variants is 0 on success
 or negative on error. Note the difference to gpiod_get_value(), which returns
 0 or 1 on success to convey the GPIO value. With the array functions, the GPIO
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 4d26cdbdb7cf..b799a89c4c17 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2787,7 +2787,36 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 				  struct gpio_array *array_info,
 				  unsigned long *value_bitmap)
 {
-	int i = 0;
+	int err, i = 0;
+
+	/*
+	 * Validate array_info against desc_array and its size.
+	 * It should immediately follow desc_array if both
+	 * have been obtained from the same gpiod_get_array() call.
+	 */
+	if (array_info && array_info->desc == desc_array &&
+	    array_size <= array_info->size &&
+	    (void *)array_info == desc_array + array_info->size) {
+		if (!can_sleep)
+			WARN_ON(array_info->chip->can_sleep);
+
+		err = gpio_chip_get_multiple(array_info->chip,
+					     array_info->get_mask,
+					     value_bitmap);
+		if (err)
+			return err;
+
+		if (!raw && !bitmap_empty(array_info->invert_mask, array_size))
+			bitmap_xor(value_bitmap, value_bitmap,
+				   array_info->invert_mask, array_size);
+
+		if (bitmap_full(array_info->get_mask, array_size))
+			return 0;
+
+		i = find_first_zero_bit(array_info->get_mask, array_size);
+	} else {
+		array_info = NULL;
+	}
 
 	while (i < array_size) {
 		struct gpio_chip *chip = desc_array[i]->gdev->chip;
@@ -2818,7 +2847,12 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 			int hwgpio = gpio_chip_hwgpio(desc);
 
 			__set_bit(hwgpio, mask);
-			i++;
+
+			if (array_info)
+				find_next_zero_bit(array_info->get_mask,
+						   array_size, i);
+			else
+				i++;
 		} while ((i < array_size) &&
 			 (desc_array[i]->gdev->chip == chip));
 
@@ -2829,7 +2863,7 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 			return ret;
 		}
 
-		for (j = first; j < i; j++) {
+		for (j = first; j < i; ) {
 			const struct gpio_desc *desc = desc_array[j];
 			int hwgpio = gpio_chip_hwgpio(desc);
 			int value = test_bit(hwgpio, bits);
@@ -2838,6 +2872,11 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 				value = !value;
 			__assign_bit(j, value_bitmap, value);
 			trace_gpio_value(desc_to_gpio(desc), 1, value);
+
+			if (array_info)
+				find_next_zero_bit(array_info->get_mask, i, j);
+			else
+				j++;
 		}
 
 		if (mask != fastpath)
@@ -3039,6 +3078,32 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 {
 	int i = 0;
 
+	/*
+	 * Validate array_info against desc_array and its size.
+	 * It should immediately follow desc_array if both
+	 * have been obtained from the same gpiod_get_array() call.
+	 */
+	if (array_info && array_info->desc == desc_array &&
+	    array_size <= array_info->size &&
+	    (void *)array_info == desc_array + array_info->size) {
+		if (!can_sleep)
+			WARN_ON(array_info->chip->can_sleep);
+
+		if (!raw && !bitmap_empty(array_info->invert_mask, array_size))
+			bitmap_xor(value_bitmap, value_bitmap,
+				   array_info->invert_mask, array_size);
+
+		gpio_chip_set_multiple(array_info->chip, array_info->set_mask,
+				       value_bitmap);
+
+		if (bitmap_full(array_info->set_mask, array_size))
+			return 0;
+
+		i = find_first_zero_bit(array_info->set_mask, array_size);
+	} else {
+		array_info = NULL;
+	}
+
 	while (i < array_size) {
 		struct gpio_chip *chip = desc_array[i]->gdev->chip;
 		unsigned long fastpath[2 * BITS_TO_LONGS(FASTPATH_NGPIO)];
@@ -3066,7 +3131,14 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 			int hwgpio = gpio_chip_hwgpio(desc);
 			int value = test_bit(i, value_bitmap);
 
-			if (!raw && test_bit(FLAG_ACTIVE_LOW, &desc->flags))
+			/*
+			 * Pins applicable for fast input but not for
+			 * fast output processing may have been already
+			 * inverted inside the fast path, skip them.
+			 */
+			if (!raw && !(array_info &&
+			    test_bit(i, array_info->invert_mask)) &&
+			    test_bit(FLAG_ACTIVE_LOW, &desc->flags))
 				value = !value;
 			trace_gpio_value(desc_to_gpio(desc), 0, value);
 			/*
@@ -3085,7 +3157,12 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 					__clear_bit(hwgpio, bits);
 				count++;
 			}
-			i++;
+
+			if (array_info)
+				find_next_zero_bit(array_info->set_mask,
+						   array_size, i);
+			else
+				i++;
 		} while ((i < array_size) &&
 			 (desc_array[i]->gdev->chip == chip));
 		/* push collected bits to outputs */
-- 
2.16.4
