From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v5 1/4] gpiolib: Pass bitmaps, not integer arrays, to get/set array
Date: Wed, 29 Aug 2018 22:48:57 +0200
Message-ID: <20180829204900.19390-2-jmkrzyszt@gmail.com>
References: <20180820234341.5271-1-jmkrzyszt@gmail.com>
 <20180829204900.19390-1-jmkrzyszt@gmail.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180829204900.19390-1-jmkrzyszt@gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>, Peter Korsgaard <peter.korsgaard@barco.com>, Peter Rosin <peda@axentia.se>, Ulf Hansson <ulf.hansson@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, Dominik Brodowski <linux@dominikbrodowski.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kishon Vijay Abraham I <kishon@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jiri Slaby <jslaby@suse.com>, Willy Tarreau <w@1wt.eu>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-mmc@vger.kernel.org

Most users of get/set array functions iterate consecutive bits of data,
usually a single integer, while processing array of results obtained
from, or building an array of values to be passed to those functions.
Save time wasted on those iterations by changing the functions' API to
accept bitmaps.

All current users are updated as well.

More benefits from the change are expected as soon as planned support
for accepting/passing those bitmaps directly from/to respective GPIO
chip callbacks if applicable is implemented.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
Cc: Peter Korsgaard <peter.korsgaard@barco.com>
Cc: Peter Rosin <peda@axentia.se>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 Documentation/driver-api/gpio/consumer.rst  | 22 ++++----
 drivers/auxdisplay/hd44780.c                | 52 +++++++++--------
 drivers/bus/ts-nbus.c                       | 19 ++-----
 drivers/gpio/gpio-max3191x.c                | 17 +++---
 drivers/gpio/gpiolib.c                      | 86 +++++++++++++++--------------
 drivers/gpio/gpiolib.h                      |  4 +-
 drivers/i2c/muxes/i2c-mux-gpio.c            |  8 +--
 drivers/mmc/core/pwrseq_simple.c            | 13 ++---
 drivers/mux/gpio.c                          |  9 +--
 drivers/net/phy/mdio-mux-gpio.c             |  3 +-
 drivers/pcmcia/soc_common.c                 | 11 ++--
 drivers/phy/motorola/phy-mapphone-mdm6600.c | 17 +++---
 drivers/staging/iio/adc/ad7606.c            |  9 +--
 drivers/tty/serial/serial_mctrl_gpio.c      |  7 ++-
 include/linux/gpio/consumer.h               | 18 +++---
 15 files changed, 140 insertions(+), 155 deletions(-)

diff --git a/Documentation/driver-api/gpio/consumer.rst b/Documentation/driver-api/gpio/consumer.rst
index aa03f389d41d..ed68042ddccf 100644
--- a/Documentation/driver-api/gpio/consumer.rst
+++ b/Documentation/driver-api/gpio/consumer.rst
@@ -323,29 +323,29 @@ The following functions get or set the values of an array of GPIOs::
 
 	int gpiod_get_array_value(unsigned int array_size,
 				  struct gpio_desc **desc_array,
-				  int *value_array);
+				  unsigned long *value_bitmap);
 	int gpiod_get_raw_array_value(unsigned int array_size,
 				      struct gpio_desc **desc_array,
-				      int *value_array);
+				      unsigned long *value_bitmap);
 	int gpiod_get_array_value_cansleep(unsigned int array_size,
 					   struct gpio_desc **desc_array,
-					   int *value_array);
+					   unsigned long *value_bitmap);
 	int gpiod_get_raw_array_value_cansleep(unsigned int array_size,
 					   struct gpio_desc **desc_array,
-					   int *value_array);
+					   unsigned long *value_bitmap);
 
 	void gpiod_set_array_value(unsigned int array_size,
 				   struct gpio_desc **desc_array,
-				   int *value_array)
+				   unsigned long *value_bitmap)
 	void gpiod_set_raw_array_value(unsigned int array_size,
 				       struct gpio_desc **desc_array,
-				       int *value_array)
+				       unsigned long *value_bitmap)
 	void gpiod_set_array_value_cansleep(unsigned int array_size,
 					    struct gpio_desc **desc_array,
-					    int *value_array)
+					    unsigned long *value_bitmap)
 	void gpiod_set_raw_array_value_cansleep(unsigned int array_size,
 						struct gpio_desc **desc_array,
-						int *value_array)
+						unsigned long *value_bitmap)
 
 The array can be an arbitrary set of GPIOs. The functions will try to access
 GPIOs belonging to the same bank or chip simultaneously if supported by the
@@ -356,8 +356,8 @@ accessed sequentially.
 The functions take three arguments:
 	* array_size	- the number of array elements
 	* desc_array	- an array of GPIO descriptors
-	* value_array	- an array to store the GPIOs' values (get) or
-			  an array of values to assign to the GPIOs (set)
+	* value_bitmap	- a bitmap to store the GPIOs' values (get) or
+			  a bitmap of values to assign to the GPIOs (set)
 
 The descriptor array can be obtained using the gpiod_get_array() function
 or one of its variants. If the group of descriptors returned by that function
@@ -366,7 +366,7 @@ the struct gpio_descs returned by gpiod_get_array()::
 
 	struct gpio_descs *my_gpio_descs = gpiod_get_array(...);
 	gpiod_set_array_value(my_gpio_descs->ndescs, my_gpio_descs->desc,
-			      my_gpio_values);
+			      my_gpio_value_bitmap);
 
 It is also possible to access a completely arbitrary array of descriptors. The
 descriptors may be obtained using any combination of gpiod_get() and
diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index f1a42f0f1ded..bbbd6a29bf01 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -62,20 +62,19 @@ static void hd44780_strobe_gpio(struct hd44780 *hd)
 /* write to an LCD panel register in 8 bit GPIO mode */
 static void hd44780_write_gpio8(struct hd44780 *hd, u8 val, unsigned int rs)
 {
-	int values[10];	/* for DATA[0-7], RS, RW */
-	unsigned int i, n;
+	unsigned long value_bitmap[1];	/* for DATA[0-7], RS, RW */
+	unsigned int n;
 
-	for (i = 0; i < 8; i++)
-		values[PIN_DATA0 + i] = !!(val & BIT(i));
-	values[PIN_CTRL_RS] = rs;
+	value_bitmap[0] = val;
+	__assign_bit(PIN_CTRL_RS, value_bitmap, rs);
 	n = 9;
 	if (hd->pins[PIN_CTRL_RW]) {
-		values[PIN_CTRL_RW] = 0;
+		__clear_bit(PIN_CTRL_RW, value_bitmap);
 		n++;
 	}
 
 	/* Present the data to the port */
-	gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA0], values);
+	gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA0], value_bitmap);
 
 	hd44780_strobe_gpio(hd);
 }
@@ -83,32 +82,31 @@ static void hd44780_write_gpio8(struct hd44780 *hd, u8 val, unsigned int rs)
 /* write to an LCD panel register in 4 bit GPIO mode */
 static void hd44780_write_gpio4(struct hd44780 *hd, u8 val, unsigned int rs)
 {
-	int values[10];	/* for DATA[0-7], RS, RW, but DATA[0-3] is unused */
-	unsigned int i, n;
+	/* for DATA[0-7], RS, RW, but DATA[0-3] is unused */
+	unsigned long value_bitmap[1];
+	unsigned int n;
 
 	/* High nibble + RS, RW */
-	for (i = 4; i < 8; i++)
-		values[PIN_DATA0 + i] = !!(val & BIT(i));
-	values[PIN_CTRL_RS] = rs;
+	value_bitmap[0] = val;
+	__assign_bit(PIN_CTRL_RS, value_bitmap, rs);
 	n = 5;
 	if (hd->pins[PIN_CTRL_RW]) {
-		values[PIN_CTRL_RW] = 0;
+		__clear_bit(PIN_CTRL_RW, value_bitmap);
 		n++;
 	}
+	value_bitmap[0] >>= PIN_DATA4;
 
 	/* Present the data to the port */
-	gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4],
-				       &values[PIN_DATA4]);
+	gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4], value_bitmap);
 
 	hd44780_strobe_gpio(hd);
 
 	/* Low nibble */
-	for (i = 0; i < 4; i++)
-		values[PIN_DATA4 + i] = !!(val & BIT(i));
+	value_bitmap[0] &= ~((1 << PIN_DATA4) - 1);
+	value_bitmap[0] |= val & ~((1 << PIN_DATA4) - 1);
 
 	/* Present the data to the port */
-	gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4],
-				       &values[PIN_DATA4]);
+	gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4], value_bitmap);
 
 	hd44780_strobe_gpio(hd);
 }
@@ -155,23 +153,23 @@ static void hd44780_write_cmd_gpio4(struct charlcd *lcd, int cmd)
 /* Send 4-bits of a command to the LCD panel in raw 4 bit GPIO mode */
 static void hd44780_write_cmd_raw_gpio4(struct charlcd *lcd, int cmd)
 {
-	int values[10];	/* for DATA[0-7], RS, RW, but DATA[0-3] is unused */
+	/* for DATA[0-7], RS, RW, but DATA[0-3] is unused */
+	unsigned long value_bitmap[1];
 	struct hd44780 *hd = lcd->drvdata;
-	unsigned int i, n;
+	unsigned int n;
 
 	/* Command nibble + RS, RW */
-	for (i = 0; i < 4; i++)
-		values[PIN_DATA4 + i] = !!(cmd & BIT(i));
-	values[PIN_CTRL_RS] = 0;
+	value_bitmap[0] = cmd << PIN_DATA4;
+	__clear_bit(PIN_CTRL_RS, value_bitmap);
 	n = 5;
 	if (hd->pins[PIN_CTRL_RW]) {
-		values[PIN_CTRL_RW] = 0;
+		__clear_bit(PIN_CTRL_RW, value_bitmap);
 		n++;
 	}
+	value_bitmap[0] = value_bitmap[0] >> PIN_DATA4;
 
 	/* Present the data to the port */
-	gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4],
-				       &values[PIN_DATA4]);
+	gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4], value_bitmap);
 
 	hd44780_strobe_gpio(hd);
 }
diff --git a/drivers/bus/ts-nbus.c b/drivers/bus/ts-nbus.c
index 073fd9011154..ce6c1e89236d 100644
--- a/drivers/bus/ts-nbus.c
+++ b/drivers/bus/ts-nbus.c
@@ -110,13 +110,9 @@ static void ts_nbus_set_direction(struct ts_nbus *ts_nbus, int direction)
  */
 static void ts_nbus_reset_bus(struct ts_nbus *ts_nbus)
 {
-	int i;
-	int values[8];
-
-	for (i = 0; i < 8; i++)
-		values[i] = 0;
+	unsigned long value_bitmap[1] = { 0, };
 
-	gpiod_set_array_value_cansleep(8, ts_nbus->data->desc, values);
+	gpiod_set_array_value_cansleep(8, ts_nbus->data->desc, value_bitmap);
 	gpiod_set_value_cansleep(ts_nbus->csn, 0);
 	gpiod_set_value_cansleep(ts_nbus->strobe, 0);
 	gpiod_set_value_cansleep(ts_nbus->ale, 0);
@@ -157,16 +153,9 @@ static int ts_nbus_read_byte(struct ts_nbus *ts_nbus, u8 *val)
 static void ts_nbus_write_byte(struct ts_nbus *ts_nbus, u8 byte)
 {
 	struct gpio_descs *gpios = ts_nbus->data;
-	int i;
-	int values[8];
-
-	for (i = 0; i < 8; i++)
-		if (byte & BIT(i))
-			values[i] = 1;
-		else
-			values[i] = 0;
+	unsigned long value_bitmap[1] = { byte, };
 
-	gpiod_set_array_value_cansleep(8, gpios->desc, values);
+	gpiod_set_array_value_cansleep(8, gpios->desc, value_bitmap);
 }
 
 /*
diff --git a/drivers/gpio/gpio-max3191x.c b/drivers/gpio/gpio-max3191x.c
index b5b9cb1fda50..c4ec1c82af27 100644
--- a/drivers/gpio/gpio-max3191x.c
+++ b/drivers/gpio/gpio-max3191x.c
@@ -315,17 +315,20 @@ static void gpiod_set_array_single_value_cansleep(unsigned int ndescs,
 						  struct gpio_desc **desc,
 						  int value)
 {
-	int i, *values;
+	unsigned long *value_bitmap;
 
-	values = kmalloc_array(ndescs, sizeof(*values), GFP_KERNEL);
-	if (!values)
+	value_bitmap = kmalloc_array(BITS_TO_LONGS(ndescs),
+				     sizeof(*value_bitmap), GFP_KERNEL);
+	if (!value_bitmap)
 		return;
 
-	for (i = 0; i < ndescs; i++)
-		values[i] = value;
+	if (value)
+		bitmap_fill(value_bitmap, ndescs);
+	else
+		bitmap_zero(value_bitmap, ndescs);
 
-	gpiod_set_array_value_cansleep(ndescs, desc, values);
-	kfree(values);
+	gpiod_set_array_value_cansleep(ndescs, desc, value_bitmap);
+	kfree(value_bitmap);
 }
 
 static struct gpio_descs *devm_gpiod_get_array_optional_count(
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e8f8a1999393..f0e9ffa8cab6 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -427,7 +427,7 @@ static long linehandle_ioctl(struct file *filep, unsigned int cmd,
 	struct linehandle_state *lh = filep->private_data;
 	void __user *ip = (void __user *)arg;
 	struct gpiohandle_data ghd;
-	int vals[GPIOHANDLES_MAX];
+	unsigned long value_bitmap[BITS_TO_LONGS(GPIOHANDLES_MAX)];
 	int i;
 
 	if (cmd == GPIOHANDLE_GET_LINE_VALUES_IOCTL) {
@@ -436,13 +436,13 @@ static long linehandle_ioctl(struct file *filep, unsigned int cmd,
 							true,
 							lh->numdescs,
 							lh->descs,
-							vals);
+							value_bitmap);
 		if (ret)
 			return ret;
 
 		memset(&ghd, 0, sizeof(ghd));
 		for (i = 0; i < lh->numdescs; i++)
-			ghd.values[i] = vals[i];
+			ghd.values[i] = test_bit(i, value_bitmap);
 
 		if (copy_to_user(ip, &ghd, sizeof(ghd)))
 			return -EFAULT;
@@ -461,14 +461,14 @@ static long linehandle_ioctl(struct file *filep, unsigned int cmd,
 
 		/* Clamp all values to [0,1] */
 		for (i = 0; i < lh->numdescs; i++)
-			vals[i] = !!ghd.values[i];
+			__assign_bit(i, value_bitmap, !!ghd.values[i]);
 
 		/* Reuse the array setting function */
 		return gpiod_set_array_value_complex(false,
 					      true,
 					      lh->numdescs,
 					      lh->descs,
-					      vals);
+					      value_bitmap);
 	}
 	return -EINVAL;
 }
@@ -2784,7 +2784,7 @@ static int gpio_chip_get_multiple(struct gpio_chip *chip,
 int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 				  unsigned int array_size,
 				  struct gpio_desc **desc_array,
-				  int *value_array)
+				  unsigned long *value_bitmap)
 {
 	int i = 0;
 
@@ -2835,7 +2835,7 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 
 			if (!raw && test_bit(FLAG_ACTIVE_LOW, &desc->flags))
 				value = !value;
-			value_array[j] = value;
+			__assign_bit(j, value_bitmap, value);
 			trace_gpio_value(desc_to_gpio(desc), 1, value);
 		}
 
@@ -2895,9 +2895,9 @@ EXPORT_SYMBOL_GPL(gpiod_get_value);
 
 /**
  * gpiod_get_raw_array_value() - read raw values from an array of GPIOs
- * @array_size: number of elements in the descriptor / value arrays
+ * @array_size: number of elements in the descriptor array / value bitmap
  * @desc_array: array of GPIO descriptors whose values will be read
- * @value_array: array to store the read values
+ * @value_bitmap: bitmap to store the read values
  *
  * Read the raw values of the GPIOs, i.e. the values of the physical lines
  * without regard for their ACTIVE_LOW status.  Return 0 in case of success,
@@ -2907,20 +2907,21 @@ EXPORT_SYMBOL_GPL(gpiod_get_value);
  * and it will complain if the GPIO chip functions potentially sleep.
  */
 int gpiod_get_raw_array_value(unsigned int array_size,
-			      struct gpio_desc **desc_array, int *value_array)
+			      struct gpio_desc **desc_array,
+			      unsigned long *value_bitmap)
 {
 	if (!desc_array)
 		return -EINVAL;
 	return gpiod_get_array_value_complex(true, false, array_size,
-					     desc_array, value_array);
+					     desc_array, value_bitmap);
 }
 EXPORT_SYMBOL_GPL(gpiod_get_raw_array_value);
 
 /**
  * gpiod_get_array_value() - read values from an array of GPIOs
- * @array_size: number of elements in the descriptor / value arrays
+ * @array_size: number of elements in the descriptor array / value bitmap
  * @desc_array: array of GPIO descriptors whose values will be read
- * @value_array: array to store the read values
+ * @value_bitnap: bitmap to store the read values
  *
  * Read the logical values of the GPIOs, i.e. taking their ACTIVE_LOW status
  * into account.  Return 0 in case of success, else an error code.
@@ -2929,12 +2930,13 @@ EXPORT_SYMBOL_GPL(gpiod_get_raw_array_value);
  * and it will complain if the GPIO chip functions potentially sleep.
  */
 int gpiod_get_array_value(unsigned int array_size,
-			  struct gpio_desc **desc_array, int *value_array)
+			  struct gpio_desc **desc_array,
+			  unsigned long *value_bitmap)
 {
 	if (!desc_array)
 		return -EINVAL;
 	return gpiod_get_array_value_complex(false, false, array_size,
-					     desc_array, value_array);
+					     desc_array, value_bitmap);
 }
 EXPORT_SYMBOL_GPL(gpiod_get_array_value);
 
@@ -3027,7 +3029,7 @@ static void gpio_chip_set_multiple(struct gpio_chip *chip,
 int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 				   unsigned int array_size,
 				   struct gpio_desc **desc_array,
-				   int *value_array)
+				   unsigned long *value_bitmap)
 {
 	int i = 0;
 
@@ -3056,7 +3058,7 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 		do {
 			struct gpio_desc *desc = desc_array[i];
 			int hwgpio = gpio_chip_hwgpio(desc);
-			int value = value_array[i];
+			int value = test_bit(i, value_bitmap);
 
 			if (!raw && test_bit(FLAG_ACTIVE_LOW, &desc->flags))
 				value = !value;
@@ -3152,9 +3154,9 @@ EXPORT_SYMBOL_GPL(gpiod_set_value);
 
 /**
  * gpiod_set_raw_array_value() - assign values to an array of GPIOs
- * @array_size: number of elements in the descriptor / value arrays
+ * @array_size: number of elements in the descriptor array / value bitmap
  * @desc_array: array of GPIO descriptors whose values will be assigned
- * @value_array: array of values to assign
+ * @value_bitmap: bitmap of values to assign
  *
  * Set the raw values of the GPIOs, i.e. the values of the physical lines
  * without regard for their ACTIVE_LOW status.
@@ -3163,20 +3165,21 @@ EXPORT_SYMBOL_GPL(gpiod_set_value);
  * complain if the GPIO chip functions potentially sleep.
  */
 int gpiod_set_raw_array_value(unsigned int array_size,
-			 struct gpio_desc **desc_array, int *value_array)
+			 struct gpio_desc **desc_array,
+			 unsigned long *value_bitmap)
 {
 	if (!desc_array)
 		return -EINVAL;
 	return gpiod_set_array_value_complex(true, false, array_size,
-					desc_array, value_array);
+					desc_array, value_bitmap);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_raw_array_value);
 
 /**
  * gpiod_set_array_value() - assign values to an array of GPIOs
- * @array_size: number of elements in the descriptor / value arrays
+ * @array_size: number of elements in the descriptor array / value bitmap
  * @desc_array: array of GPIO descriptors whose values will be assigned
- * @value_array: array of values to assign
+ * @value_bitmap: bitmap of values to assign
  *
  * Set the logical values of the GPIOs, i.e. taking their ACTIVE_LOW status
  * into account.
@@ -3185,12 +3188,13 @@ EXPORT_SYMBOL_GPL(gpiod_set_raw_array_value);
  * complain if the GPIO chip functions potentially sleep.
  */
 void gpiod_set_array_value(unsigned int array_size,
-			   struct gpio_desc **desc_array, int *value_array)
+			   struct gpio_desc **desc_array,
+			   unsigned long *value_bitmap)
 {
 	if (!desc_array)
 		return;
 	gpiod_set_array_value_complex(false, false, array_size, desc_array,
-				      value_array);
+				      value_bitmap);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_array_value);
 
@@ -3410,9 +3414,9 @@ EXPORT_SYMBOL_GPL(gpiod_get_value_cansleep);
 
 /**
  * gpiod_get_raw_array_value_cansleep() - read raw values from an array of GPIOs
- * @array_size: number of elements in the descriptor / value arrays
+ * @array_size: number of elements in the descriptor array / value bitmap
  * @desc_array: array of GPIO descriptors whose values will be read
- * @value_array: array to store the read values
+ * @value_bitmap: bitmap to store the read values
  *
  * Read the raw values of the GPIOs, i.e. the values of the physical lines
  * without regard for their ACTIVE_LOW status.  Return 0 in case of success,
@@ -3422,21 +3426,21 @@ EXPORT_SYMBOL_GPL(gpiod_get_value_cansleep);
  */
 int gpiod_get_raw_array_value_cansleep(unsigned int array_size,
 				       struct gpio_desc **desc_array,
-				       int *value_array)
+				       unsigned long *value_bitmap)
 {
 	might_sleep_if(extra_checks);
 	if (!desc_array)
 		return -EINVAL;
 	return gpiod_get_array_value_complex(true, true, array_size,
-					     desc_array, value_array);
+					     desc_array, value_bitmap);
 }
 EXPORT_SYMBOL_GPL(gpiod_get_raw_array_value_cansleep);
 
 /**
  * gpiod_get_array_value_cansleep() - read values from an array of GPIOs
- * @array_size: number of elements in the descriptor / value arrays
+ * @array_size: number of elements in the descriptor array / value bitmap
  * @desc_array: array of GPIO descriptors whose values will be read
- * @value_array: array to store the read values
+ * @value_bitmap: bitmap to store the read values
  *
  * Read the logical values of the GPIOs, i.e. taking their ACTIVE_LOW status
  * into account.  Return 0 in case of success, else an error code.
@@ -3445,13 +3449,13 @@ EXPORT_SYMBOL_GPL(gpiod_get_raw_array_value_cansleep);
  */
 int gpiod_get_array_value_cansleep(unsigned int array_size,
 				   struct gpio_desc **desc_array,
-				   int *value_array)
+				   unsigned long *value_bitmap)
 {
 	might_sleep_if(extra_checks);
 	if (!desc_array)
 		return -EINVAL;
 	return gpiod_get_array_value_complex(false, true, array_size,
-					     desc_array, value_array);
+					     desc_array, value_bitmap);
 }
 EXPORT_SYMBOL_GPL(gpiod_get_array_value_cansleep);
 
@@ -3493,9 +3497,9 @@ EXPORT_SYMBOL_GPL(gpiod_set_value_cansleep);
 
 /**
  * gpiod_set_raw_array_value_cansleep() - assign values to an array of GPIOs
- * @array_size: number of elements in the descriptor / value arrays
+ * @array_size: number of elements in the descriptor array / value bitmap
  * @desc_array: array of GPIO descriptors whose values will be assigned
- * @value_array: array of values to assign
+ * @value_bitmap: bitmap of values to assign
  *
  * Set the raw values of the GPIOs, i.e. the values of the physical lines
  * without regard for their ACTIVE_LOW status.
@@ -3504,13 +3508,13 @@ EXPORT_SYMBOL_GPL(gpiod_set_value_cansleep);
  */
 int gpiod_set_raw_array_value_cansleep(unsigned int array_size,
 					struct gpio_desc **desc_array,
-					int *value_array)
+					unsigned long *value_bitmap)
 {
 	might_sleep_if(extra_checks);
 	if (!desc_array)
 		return -EINVAL;
 	return gpiod_set_array_value_complex(true, true, array_size, desc_array,
-				      value_array);
+				      value_bitmap);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_raw_array_value_cansleep);
 
@@ -3533,9 +3537,9 @@ void gpiod_add_lookup_tables(struct gpiod_lookup_table **tables, size_t n)
 
 /**
  * gpiod_set_array_value_cansleep() - assign values to an array of GPIOs
- * @array_size: number of elements in the descriptor / value arrays
+ * @array_size: number of elements in the descriptor array / value bitmap
  * @desc_array: array of GPIO descriptors whose values will be assigned
- * @value_array: array of values to assign
+ * @value_bitmap: bitmap of values to assign
  *
  * Set the logical values of the GPIOs, i.e. taking their ACTIVE_LOW status
  * into account.
@@ -3544,13 +3548,13 @@ void gpiod_add_lookup_tables(struct gpiod_lookup_table **tables, size_t n)
  */
 void gpiod_set_array_value_cansleep(unsigned int array_size,
 				    struct gpio_desc **desc_array,
-				    int *value_array)
+				    unsigned long *value_bitmap)
 {
 	might_sleep_if(extra_checks);
 	if (!desc_array)
 		return;
 	gpiod_set_array_value_complex(false, true, array_size, desc_array,
-				      value_array);
+				      value_bitmap);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_array_value_cansleep);
 
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index a7e49fef73d4..11e83d2eef89 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -187,11 +187,11 @@ struct gpio_desc *gpiochip_get_desc(struct gpio_chip *chip, u16 hwnum);
 int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 				  unsigned int array_size,
 				  struct gpio_desc **desc_array,
-				  int *value_array);
+				  unsigned long *value_bitmap);
 int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 				   unsigned int array_size,
 				   struct gpio_desc **desc_array,
-				   int *value_array);
+				   unsigned long *value_bitmap);
 
 /* This is just passed between gpiolib and devres */
 struct gpio_desc *gpiod_get_from_of_node(struct device_node *node,
diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index 401308e3d036..4e36e0eac7a3 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -22,18 +22,16 @@ struct gpiomux {
 	struct i2c_mux_gpio_platform_data data;
 	unsigned gpio_base;
 	struct gpio_desc **gpios;
-	int *values;
+	int *values; /* FIXME: no longer needed */
 };
 
 static void i2c_mux_gpio_set(const struct gpiomux *mux, unsigned val)
 {
+	unsigned long value_bitmap[1] = { val, };
 	int i;
 
-	for (i = 0; i < mux->data.n_gpios; i++)
-		mux->values[i] = (val >> i) & 1;
-
 	gpiod_set_array_value_cansleep(mux->data.n_gpios,
-				       mux->gpios, mux->values);
+				       mux->gpios, value_bitmap);
 }
 
 static int i2c_mux_gpio_select(struct i2c_mux_core *muxc, u32 chan)
diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index a8b9fee4d62a..0d6e3a5be3ba 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -40,18 +40,13 @@ static void mmc_pwrseq_simple_set_gpios_value(struct mmc_pwrseq_simple *pwrseq,
 	struct gpio_descs *reset_gpios = pwrseq->reset_gpios;
 
 	if (!IS_ERR(reset_gpios)) {
-		int i, *values;
+		unsigned long value_bitmap[1];
 		int nvalues = reset_gpios->ndescs;
 
-		values = kmalloc_array(nvalues, sizeof(int), GFP_KERNEL);
-		if (!values)
-			return;
+		value_bitmap[0] = value;
 
-		for (i = 0; i < nvalues; i++)
-			values[i] = value;
-
-		gpiod_set_array_value_cansleep(nvalues, reset_gpios->desc, values);
-		kfree(values);
+		gpiod_set_array_value_cansleep(nvalues, reset_gpios->desc,
+					       value_bitmap);
 	}
 }
 
diff --git a/drivers/mux/gpio.c b/drivers/mux/gpio.c
index 6fdd9316db8b..734e1b43aed6 100644
--- a/drivers/mux/gpio.c
+++ b/drivers/mux/gpio.c
@@ -17,20 +17,17 @@
 
 struct mux_gpio {
 	struct gpio_descs *gpios;
-	int *val;
+	int *val; /* FIXME: no longer needed */
 };
 
 static int mux_gpio_set(struct mux_control *mux, int state)
 {
 	struct mux_gpio *mux_gpio = mux_chip_priv(mux->chip);
+	unsigned long value_bitmap[1] = { state, };
 	int i;
 
-	for (i = 0; i < mux_gpio->gpios->ndescs; i++)
-		mux_gpio->val[i] = (state >> i) & 1;
-
 	gpiod_set_array_value_cansleep(mux_gpio->gpios->ndescs,
-				       mux_gpio->gpios->desc,
-				       mux_gpio->val);
+				       mux_gpio->gpios->desc, value_bitmap);
 
 	return 0;
 }
diff --git a/drivers/net/phy/mdio-mux-gpio.c b/drivers/net/phy/mdio-mux-gpio.c
index bc90764a8b8d..8e1ec750277e 100644
--- a/drivers/net/phy/mdio-mux-gpio.c
+++ b/drivers/net/phy/mdio-mux-gpio.c
@@ -27,6 +27,7 @@ static int mdio_mux_gpio_switch_fn(int current_child, int desired_child,
 				   void *data)
 {
 	struct mdio_mux_gpio_state *s = data;
+	unsigned long value_bitmap[1] = { desired_child, };
 	unsigned int n;
 
 	if (current_child == desired_child)
@@ -36,7 +37,7 @@ static int mdio_mux_gpio_switch_fn(int current_child, int desired_child,
 		s->values[n] = (desired_child >> n) & 1;
 
 	gpiod_set_array_value_cansleep(s->gpios->ndescs, s->gpios->desc,
-				       s->values);
+				       value_bitmap);
 
 	return 0;
 }
diff --git a/drivers/pcmcia/soc_common.c b/drivers/pcmcia/soc_common.c
index c5f2344c189b..e0f89155c474 100644
--- a/drivers/pcmcia/soc_common.c
+++ b/drivers/pcmcia/soc_common.c
@@ -351,19 +351,22 @@ static int soc_common_pcmcia_config_skt(
 
 	if (ret == 0) {
 		struct gpio_desc *descs[2];
-		int values[2], n = 0;
+		unsigned long value_bitmap[1];
+		int n = 0;
 
 		if (skt->gpio_reset) {
 			descs[n] = skt->gpio_reset;
-			values[n++] = !!(state->flags & SS_RESET);
+			__assign_bit(n++, value_bitmap,
+				     !!(state->flags & SS_RESET));
 		}
 		if (skt->gpio_bus_enable) {
 			descs[n] = skt->gpio_bus_enable;
-			values[n++] = !!(state->flags & SS_OUTPUT_ENA);
+			__assign_bit(n++, value_bitmap,
+				     !!(state->flags & SS_OUTPUT_ENA));
 		}
 
 		if (n)
-			gpiod_set_array_value_cansleep(n, descs, values);
+			gpiod_set_array_value_cansleep(n, descs, value_bitmap);
 
 		/*
 		 * This really needs a better solution.  The IRQ
diff --git a/drivers/phy/motorola/phy-mapphone-mdm6600.c b/drivers/phy/motorola/phy-mapphone-mdm6600.c
index 0075fb0bef8c..b6477c3599c4 100644
--- a/drivers/phy/motorola/phy-mapphone-mdm6600.c
+++ b/drivers/phy/motorola/phy-mapphone-mdm6600.c
@@ -157,15 +157,12 @@ static const struct phy_ops gpio_usb_ops = {
  */
 static void phy_mdm6600_cmd(struct phy_mdm6600 *ddata, int val)
 {
-	int values[PHY_MDM6600_NR_CMD_LINES];
-	int i;
+	unsigned long value_bitmap[1];
 
-	val &= (1 << PHY_MDM6600_NR_CMD_LINES) - 1;
-	for (i = 0; i < PHY_MDM6600_NR_CMD_LINES; i++)
-		values[i] = (val & BIT(i)) >> i;
+	value_bitmap[0] = val & ((1 << PHY_MDM6600_NR_CMD_LINES) - 1);
 
 	gpiod_set_array_value_cansleep(PHY_MDM6600_NR_CMD_LINES,
-				       ddata->cmd_gpios->desc, values);
+				       ddata->cmd_gpios->desc, value_bitmap);
 }
 
 /**
@@ -176,7 +173,7 @@ static void phy_mdm6600_status(struct work_struct *work)
 {
 	struct phy_mdm6600 *ddata;
 	struct device *dev;
-	int values[PHY_MDM6600_NR_STATUS_LINES];
+	unsigned long value_bitmap[1] = { 0, };
 	int error, i, val = 0;
 
 	ddata = container_of(work, struct phy_mdm6600, status_work.work);
@@ -184,14 +181,14 @@ static void phy_mdm6600_status(struct work_struct *work)
 
 	error = gpiod_get_array_value_cansleep(PHY_MDM6600_NR_STATUS_LINES,
 					       ddata->status_gpios->desc,
-					       values);
+					       value_bitmap);
 	if (error)
 		return;
 
 	for (i = 0; i < PHY_MDM6600_NR_STATUS_LINES; i++) {
-		val |= values[i] << i;
+		val |= test_bit(i, value_bitmap) << i;
 		dev_dbg(ddata->dev, "XXX %s: i: %i values[i]: %i val: %i\n",
-			__func__, i, values[i], val);
+			__func__, i, test_bit(i, value_bitmap), val);
 	}
 	ddata->status = val;
 
diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
index 25b9fcd5e3a4..0eca047bc1cc 100644
--- a/drivers/staging/iio/adc/ad7606.c
+++ b/drivers/staging/iio/adc/ad7606.c
@@ -202,7 +202,7 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 			    long mask)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
-	int values[3];
+	unsigned long value_bitmap[1];
 	int ret, i;
 
 	switch (mask) {
@@ -227,13 +227,10 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 
-		values[0] = (ret >> 0) & 1;
-		values[1] = (ret >> 1) & 1;
-		values[2] = (ret >> 2) & 1;
+		value_bitmap[0] = ret;
 
 		mutex_lock(&st->lock);
-		gpiod_set_array_value(ARRAY_SIZE(values), st->gpio_os->desc,
-				      values);
+		gpiod_set_array_value(3, st->gpio_os->desc, value_bitmap);
 		st->oversampling = val;
 		mutex_unlock(&st->lock);
 
diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
index 1c06325beaca..bb8b4756d72d 100644
--- a/drivers/tty/serial/serial_mctrl_gpio.c
+++ b/drivers/tty/serial/serial_mctrl_gpio.c
@@ -40,7 +40,7 @@ void mctrl_gpio_set(struct mctrl_gpios *gpios, unsigned int mctrl)
 {
 	enum mctrl_gpio_idx i;
 	struct gpio_desc *desc_array[UART_GPIO_MAX];
-	int value_array[UART_GPIO_MAX];
+	unsigned long value_bitmap[BITS_TO_LONGS(UART_GPIO_MAX)];
 	unsigned int count = 0;
 
 	if (gpios == NULL)
@@ -49,10 +49,11 @@ void mctrl_gpio_set(struct mctrl_gpios *gpios, unsigned int mctrl)
 	for (i = 0; i < UART_GPIO_MAX; i++)
 		if (gpios->gpio[i] && mctrl_gpios_desc[i].dir_out) {
 			desc_array[count] = gpios->gpio[i];
-			value_array[count] = !!(mctrl & mctrl_gpios_desc[i].mctrl);
+			__assign_bit(count, value_bitmap,
+				     !!(mctrl & mctrl_gpios_desc[i].mctrl));
 			count++;
 		}
-	gpiod_set_array_value(count, desc_array, value_array);
+	gpiod_set_array_value(count, desc_array, value_bitmap);
 }
 EXPORT_SYMBOL_GPL(mctrl_gpio_set);
 
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 21ddbe440030..1b21dc7b0fad 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -104,36 +104,38 @@ int gpiod_direction_output_raw(struct gpio_desc *desc, int value);
 /* Value get/set from non-sleeping context */
 int gpiod_get_value(const struct gpio_desc *desc);
 int gpiod_get_array_value(unsigned int array_size,
-			  struct gpio_desc **desc_array, int *value_array);
+			  struct gpio_desc **desc_array,
+			  unsigned long *value_bitmap);
 void gpiod_set_value(struct gpio_desc *desc, int value);
 void gpiod_set_array_value(unsigned int array_size,
-			   struct gpio_desc **desc_array, int *value_array);
+			   struct gpio_desc **desc_array,
+			   unsigned long *value_bitmap);
 int gpiod_get_raw_value(const struct gpio_desc *desc);
 int gpiod_get_raw_array_value(unsigned int array_size,
 			      struct gpio_desc **desc_array,
-			      int *value_array);
+			      unsigned long *value_bitmap);
 void gpiod_set_raw_value(struct gpio_desc *desc, int value);
 int gpiod_set_raw_array_value(unsigned int array_size,
 			       struct gpio_desc **desc_array,
-			       int *value_array);
+			       unsigned long *value_bitmap);
 
 /* Value get/set from sleeping context */
 int gpiod_get_value_cansleep(const struct gpio_desc *desc);
 int gpiod_get_array_value_cansleep(unsigned int array_size,
 				   struct gpio_desc **desc_array,
-				   int *value_array);
+				   unsigned long *value_bitmap);
 void gpiod_set_value_cansleep(struct gpio_desc *desc, int value);
 void gpiod_set_array_value_cansleep(unsigned int array_size,
 				    struct gpio_desc **desc_array,
-				    int *value_array);
+				    unsigned long *value_bitmap);
 int gpiod_get_raw_value_cansleep(const struct gpio_desc *desc);
 int gpiod_get_raw_array_value_cansleep(unsigned int array_size,
 				       struct gpio_desc **desc_array,
-				       int *value_array);
+				       unsigned long *value_bitmap);
 void gpiod_set_raw_value_cansleep(struct gpio_desc *desc, int value);
 int gpiod_set_raw_array_value_cansleep(unsigned int array_size,
 					struct gpio_desc **desc_array,
-					int *value_array);
+					unsigned long *value_bitmap);
 
 int gpiod_set_debounce(struct gpio_desc *desc, unsigned debounce);
 int gpiod_set_transitory(struct gpio_desc *desc, bool transitory);
-- 
2.16.4
