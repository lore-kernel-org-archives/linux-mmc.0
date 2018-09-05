From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v8 3/4] gpiolib: Pass array info to get/set array functions
Date: Wed,  5 Sep 2018 23:50:07 +0200
Message-ID: <20180905215008.1649-4-jmkrzyszt@gmail.com>
References: <20180902120144.6855-1-jmkrzyszt@gmail.com>
 <20180905215008.1649-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180905215008.1649-1-jmkrzyszt@gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>, Peter Korsgaard <peter.korsgaard@barco.com>, Peter Rosin <peda@axentia.se>, Ulf Hansson <ulf.hansson@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, Dominik Brodowski <linux@dominikbrodowski.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kishon Vijay Abraham I <kishon@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jiri Slaby <jslaby@suse.com>, Willy Tarreau <w@1wt.eu>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-mmc@vger.kernel.org

In order to make use of array info obtained from gpiod_get_array() and
speed up processing of arrays matching single GPIO chip layout, that
information must be passed to get/set array functions.  Extend the
functions' API with that additional parameter and update all users.
Pass NULL if a user builds an array itself from single GPIOs.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Peter Korsgaard <peter.korsgaard@barco.com>
Cc: Peter Rosin <peda@axentia.se>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Rojhalat Ibrahim <imr@rtschenk.de>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Yegor Yefremov <yegorslists@googlemail.com>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 Documentation/driver-api/gpio/consumer.rst  | 14 ++++++++--
 drivers/auxdisplay/hd44780.c                |  8 +++---
 drivers/bus/ts-nbus.c                       |  5 ++--
 drivers/gpio/gpio-max3191x.c                |  6 +++--
 drivers/gpio/gpiolib.c                      | 40 +++++++++++++++++++++++------
 drivers/gpio/gpiolib.h                      |  2 ++
 drivers/i2c/muxes/i2c-mux-gpio.c            |  3 ++-
 drivers/mmc/core/pwrseq_simple.c            |  2 +-
 drivers/mux/gpio.c                          |  3 ++-
 drivers/net/phy/mdio-mux-gpio.c             |  2 +-
 drivers/pcmcia/soc_common.c                 |  2 +-
 drivers/phy/motorola/phy-mapphone-mdm6600.c |  4 ++-
 drivers/staging/iio/adc/ad7606.c            |  3 ++-
 drivers/tty/serial/serial_mctrl_gpio.c      |  2 +-
 include/linux/gpio/consumer.h               | 16 ++++++++++++
 15 files changed, 86 insertions(+), 26 deletions(-)

diff --git a/Documentation/driver-api/gpio/consumer.rst b/Documentation/driver-api/gpio/consumer.rst
index 7e0298b9a7b9..0afd95a12b10 100644
--- a/Documentation/driver-api/gpio/consumer.rst
+++ b/Documentation/driver-api/gpio/consumer.rst
@@ -325,28 +325,36 @@ The following functions get or set the values of an array of GPIOs::
 
 	int gpiod_get_array_value(unsigned int array_size,
 				  struct gpio_desc **desc_array,
+				  struct gpio_array *array_info,
 				  unsigned long *value_bitmap);
 	int gpiod_get_raw_array_value(unsigned int array_size,
 				      struct gpio_desc **desc_array,
+				      struct gpio_array *array_info,
 				      unsigned long *value_bitmap);
 	int gpiod_get_array_value_cansleep(unsigned int array_size,
 					   struct gpio_desc **desc_array,
+					   struct gpio_array *array_info,
 					   unsigned long *value_bitmap);
 	int gpiod_get_raw_array_value_cansleep(unsigned int array_size,
 					   struct gpio_desc **desc_array,
+					   struct gpio_array *array_info,
 					   unsigned long *value_bitmap);
 
 	void gpiod_set_array_value(unsigned int array_size,
 				   struct gpio_desc **desc_array,
+				   struct gpio_array *array_info,
 				   unsigned long *value_bitmap)
 	void gpiod_set_raw_array_value(unsigned int array_size,
 				       struct gpio_desc **desc_array,
+				       struct gpio_array *array_info,
 				       unsigned long *value_bitmap)
 	void gpiod_set_array_value_cansleep(unsigned int array_size,
 					    struct gpio_desc **desc_array,
+					    struct gpio_array *array_info,
 					    unsigned long *value_bitmap)
 	void gpiod_set_raw_array_value_cansleep(unsigned int array_size,
 						struct gpio_desc **desc_array,
+						struct gpio_array *array_info,
 						unsigned long *value_bitmap)
 
 The array can be an arbitrary set of GPIOs. The functions will try to access
@@ -358,6 +366,7 @@ accessed sequentially.
 The functions take three arguments:
 	* array_size	- the number of array elements
 	* desc_array	- an array of GPIO descriptors
+	* array_info	- optional information obtained from gpiod_array_get()
 	* value_bitmap	- a bitmap to store the GPIOs' values (get) or
 			  a bitmap of values to assign to the GPIOs (set)
 
@@ -368,12 +377,13 @@ the struct gpio_descs returned by gpiod_get_array()::
 
 	struct gpio_descs *my_gpio_descs = gpiod_get_array(...);
 	gpiod_set_array_value(my_gpio_descs->ndescs, my_gpio_descs->desc,
-			      my_gpio_value_bitmap);
+			      my_gpio_descs->info, my_gpio_value_bitmap);
 
 It is also possible to access a completely arbitrary array of descriptors. The
 descriptors may be obtained using any combination of gpiod_get() and
 gpiod_get_array(). Afterwards the array of descriptors has to be setup
-manually before it can be passed to one of the above functions.
+manually before it can be passed to one of the above functions.  In that case,
+array_info should be set to NULL.
 
 Note that for optimal performance GPIOs belonging to the same chip should be
 contiguous within the array of descriptors.
diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index e9a893384362..9ad93ea42fdc 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -70,7 +70,7 @@ static void hd44780_write_gpio8(struct hd44780 *hd, u8 val, unsigned int rs)
 	n = hd->pins[PIN_CTRL_RW] ? 10 : 9;
 
 	/* Present the data to the port */
-	gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA0], values);
+	gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA0], NULL, values);
 
 	hd44780_strobe_gpio(hd);
 }
@@ -87,7 +87,7 @@ static void hd44780_write_gpio4(struct hd44780 *hd, u8 val, unsigned int rs)
 	n = hd->pins[PIN_CTRL_RW] ? 6 : 5;
 
 	/* Present the data to the port */
-	gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4], values);
+	gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4], NULL, values);
 
 	hd44780_strobe_gpio(hd);
 
@@ -96,7 +96,7 @@ static void hd44780_write_gpio4(struct hd44780 *hd, u8 val, unsigned int rs)
 	values[0] |= val & 0x0f;
 
 	/* Present the data to the port */
-	gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4], values);
+	gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4], NULL, values);
 
 	hd44780_strobe_gpio(hd);
 }
@@ -152,7 +152,7 @@ static void hd44780_write_cmd_raw_gpio4(struct charlcd *lcd, int cmd)
 	n = hd->pins[PIN_CTRL_RW] ? 6 : 5;
 
 	/* Present the data to the port */
-	gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4], values);
+	gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4], NULL, values);
 
 	hd44780_strobe_gpio(hd);
 }
diff --git a/drivers/bus/ts-nbus.c b/drivers/bus/ts-nbus.c
index 8dde7c77f62c..9989ce904a37 100644
--- a/drivers/bus/ts-nbus.c
+++ b/drivers/bus/ts-nbus.c
@@ -114,7 +114,8 @@ static void ts_nbus_reset_bus(struct ts_nbus *ts_nbus)
 
 	values[0] = 0;
 
-	gpiod_set_array_value_cansleep(8, ts_nbus->data->desc, values);
+	gpiod_set_array_value_cansleep(8, ts_nbus->data->desc,
+				       ts_nbus->data->info, values);
 	gpiod_set_value_cansleep(ts_nbus->csn, 0);
 	gpiod_set_value_cansleep(ts_nbus->strobe, 0);
 	gpiod_set_value_cansleep(ts_nbus->ale, 0);
@@ -159,7 +160,7 @@ static void ts_nbus_write_byte(struct ts_nbus *ts_nbus, u8 byte)
 
 	values[0] = byte;
 
-	gpiod_set_array_value_cansleep(8, gpios->desc, values);
+	gpiod_set_array_value_cansleep(8, gpios->desc, gpios->info, values);
 }
 
 /*
diff --git a/drivers/gpio/gpio-max3191x.c b/drivers/gpio/gpio-max3191x.c
index bd4a245fc5a0..9a8876abeb57 100644
--- a/drivers/gpio/gpio-max3191x.c
+++ b/drivers/gpio/gpio-max3191x.c
@@ -313,6 +313,7 @@ static int max3191x_set_config(struct gpio_chip *gpio, unsigned int offset,
 
 static void gpiod_set_array_single_value_cansleep(unsigned int ndescs,
 						  struct gpio_desc **desc,
+						  struct gpio_array *info,
 						  int value)
 {
 	unsigned long *values;
@@ -326,7 +327,7 @@ static void gpiod_set_array_single_value_cansleep(unsigned int ndescs,
 	else
 		bitmap_zero(values, ndescs);
 
-	gpiod_set_array_value_cansleep(ndescs, desc, values);
+	gpiod_set_array_value_cansleep(ndescs, desc, info, values);
 	kfree(values);
 }
 
@@ -399,7 +400,8 @@ static int max3191x_probe(struct spi_device *spi)
 	if (max3191x->modesel_pins)
 		gpiod_set_array_single_value_cansleep(
 				 max3191x->modesel_pins->ndescs,
-				 max3191x->modesel_pins->desc, max3191x->mode);
+				 max3191x->modesel_pins->desc,
+				 max3191x->modesel_pins->info, max3191x->mode);
 
 	max3191x->ignore_uv = device_property_read_bool(dev,
 						  "maxim,ignore-undervoltage");
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 141f39308a53..cd7c1deed132 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -436,6 +436,7 @@ static long linehandle_ioctl(struct file *filep, unsigned int cmd,
 							true,
 							lh->numdescs,
 							lh->descs,
+							NULL,
 							vals);
 		if (ret)
 			return ret;
@@ -468,6 +469,7 @@ static long linehandle_ioctl(struct file *filep, unsigned int cmd,
 					      true,
 					      lh->numdescs,
 					      lh->descs,
+					      NULL,
 					      vals);
 	}
 	return -EINVAL;
@@ -2784,6 +2786,7 @@ static int gpio_chip_get_multiple(struct gpio_chip *chip,
 int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 				  unsigned int array_size,
 				  struct gpio_desc **desc_array,
+				  struct gpio_array *array_info,
 				  unsigned long *value_bitmap)
 {
 	int i = 0;
@@ -2897,6 +2900,7 @@ EXPORT_SYMBOL_GPL(gpiod_get_value);
  * gpiod_get_raw_array_value() - read raw values from an array of GPIOs
  * @array_size: number of elements in the descriptor array / value bitmap
  * @desc_array: array of GPIO descriptors whose values will be read
+ * @array_info: information on applicability of fast bitmap processing path
  * @value_bitmap: bitmap to store the read values
  *
  * Read the raw values of the GPIOs, i.e. the values of the physical lines
@@ -2908,12 +2912,14 @@ EXPORT_SYMBOL_GPL(gpiod_get_value);
  */
 int gpiod_get_raw_array_value(unsigned int array_size,
 			      struct gpio_desc **desc_array,
+			      struct gpio_array *array_info,
 			      unsigned long *value_bitmap)
 {
 	if (!desc_array)
 		return -EINVAL;
 	return gpiod_get_array_value_complex(true, false, array_size,
-					     desc_array, value_bitmap);
+					     desc_array, array_info,
+					     value_bitmap);
 }
 EXPORT_SYMBOL_GPL(gpiod_get_raw_array_value);
 
@@ -2921,6 +2927,7 @@ EXPORT_SYMBOL_GPL(gpiod_get_raw_array_value);
  * gpiod_get_array_value() - read values from an array of GPIOs
  * @array_size: number of elements in the descriptor array / value bitmap
  * @desc_array: array of GPIO descriptors whose values will be read
+ * @array_info: information on applicability of fast bitmap processing path
  * @value_bitmap: bitmap to store the read values
  *
  * Read the logical values of the GPIOs, i.e. taking their ACTIVE_LOW status
@@ -2931,12 +2938,14 @@ EXPORT_SYMBOL_GPL(gpiod_get_raw_array_value);
  */
 int gpiod_get_array_value(unsigned int array_size,
 			  struct gpio_desc **desc_array,
+			  struct gpio_array *array_info,
 			  unsigned long *value_bitmap)
 {
 	if (!desc_array)
 		return -EINVAL;
 	return gpiod_get_array_value_complex(false, false, array_size,
-					     desc_array, value_bitmap);
+					     desc_array, array_info,
+					     value_bitmap);
 }
 EXPORT_SYMBOL_GPL(gpiod_get_array_value);
 
@@ -3029,6 +3038,7 @@ static void gpio_chip_set_multiple(struct gpio_chip *chip,
 int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 				   unsigned int array_size,
 				   struct gpio_desc **desc_array,
+				   struct gpio_array *array_info,
 				   unsigned long *value_bitmap)
 {
 	int i = 0;
@@ -3156,6 +3166,7 @@ EXPORT_SYMBOL_GPL(gpiod_set_value);
  * gpiod_set_raw_array_value() - assign values to an array of GPIOs
  * @array_size: number of elements in the descriptor array / value bitmap
  * @desc_array: array of GPIO descriptors whose values will be assigned
+ * @array_info: information on applicability of fast bitmap processing path
  * @value_bitmap: bitmap of values to assign
  *
  * Set the raw values of the GPIOs, i.e. the values of the physical lines
@@ -3166,12 +3177,13 @@ EXPORT_SYMBOL_GPL(gpiod_set_value);
  */
 int gpiod_set_raw_array_value(unsigned int array_size,
 			 struct gpio_desc **desc_array,
+			 struct gpio_array *array_info,
 			 unsigned long *value_bitmap)
 {
 	if (!desc_array)
 		return -EINVAL;
 	return gpiod_set_array_value_complex(true, false, array_size,
-					desc_array, value_bitmap);
+					desc_array, array_info, value_bitmap);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_raw_array_value);
 
@@ -3179,6 +3191,7 @@ EXPORT_SYMBOL_GPL(gpiod_set_raw_array_value);
  * gpiod_set_array_value() - assign values to an array of GPIOs
  * @array_size: number of elements in the descriptor array / value bitmap
  * @desc_array: array of GPIO descriptors whose values will be assigned
+ * @array_info: information on applicability of fast bitmap processing path
  * @value_bitmap: bitmap of values to assign
  *
  * Set the logical values of the GPIOs, i.e. taking their ACTIVE_LOW status
@@ -3189,12 +3202,13 @@ EXPORT_SYMBOL_GPL(gpiod_set_raw_array_value);
  */
 void gpiod_set_array_value(unsigned int array_size,
 			   struct gpio_desc **desc_array,
+			   struct gpio_array *array_info,
 			   unsigned long *value_bitmap)
 {
 	if (!desc_array)
 		return;
 	gpiod_set_array_value_complex(false, false, array_size, desc_array,
-				      value_bitmap);
+				      array_info, value_bitmap);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_array_value);
 
@@ -3416,6 +3430,7 @@ EXPORT_SYMBOL_GPL(gpiod_get_value_cansleep);
  * gpiod_get_raw_array_value_cansleep() - read raw values from an array of GPIOs
  * @array_size: number of elements in the descriptor array / value bitmap
  * @desc_array: array of GPIO descriptors whose values will be read
+ * @array_info: information on applicability of fast bitmap processing path
  * @value_bitmap: bitmap to store the read values
  *
  * Read the raw values of the GPIOs, i.e. the values of the physical lines
@@ -3426,13 +3441,15 @@ EXPORT_SYMBOL_GPL(gpiod_get_value_cansleep);
  */
 int gpiod_get_raw_array_value_cansleep(unsigned int array_size,
 				       struct gpio_desc **desc_array,
+				       struct gpio_array *array_info,
 				       unsigned long *value_bitmap)
 {
 	might_sleep_if(extra_checks);
 	if (!desc_array)
 		return -EINVAL;
 	return gpiod_get_array_value_complex(true, true, array_size,
-					     desc_array, value_bitmap);
+					     desc_array, array_info,
+					     value_bitmap);
 }
 EXPORT_SYMBOL_GPL(gpiod_get_raw_array_value_cansleep);
 
@@ -3440,6 +3457,7 @@ EXPORT_SYMBOL_GPL(gpiod_get_raw_array_value_cansleep);
  * gpiod_get_array_value_cansleep() - read values from an array of GPIOs
  * @array_size: number of elements in the descriptor array / value bitmap
  * @desc_array: array of GPIO descriptors whose values will be read
+ * @array_info: information on applicability of fast bitmap processing path
  * @value_bitmap: bitmap to store the read values
  *
  * Read the logical values of the GPIOs, i.e. taking their ACTIVE_LOW status
@@ -3449,13 +3467,15 @@ EXPORT_SYMBOL_GPL(gpiod_get_raw_array_value_cansleep);
  */
 int gpiod_get_array_value_cansleep(unsigned int array_size,
 				   struct gpio_desc **desc_array,
+				   struct gpio_array *array_info,
 				   unsigned long *value_bitmap)
 {
 	might_sleep_if(extra_checks);
 	if (!desc_array)
 		return -EINVAL;
 	return gpiod_get_array_value_complex(false, true, array_size,
-					     desc_array, value_bitmap);
+					     desc_array, array_info,
+					     value_bitmap);
 }
 EXPORT_SYMBOL_GPL(gpiod_get_array_value_cansleep);
 
@@ -3499,6 +3519,7 @@ EXPORT_SYMBOL_GPL(gpiod_set_value_cansleep);
  * gpiod_set_raw_array_value_cansleep() - assign values to an array of GPIOs
  * @array_size: number of elements in the descriptor array / value bitmap
  * @desc_array: array of GPIO descriptors whose values will be assigned
+ * @array_info: information on applicability of fast bitmap processing path
  * @value_bitmap: bitmap of values to assign
  *
  * Set the raw values of the GPIOs, i.e. the values of the physical lines
@@ -3508,13 +3529,14 @@ EXPORT_SYMBOL_GPL(gpiod_set_value_cansleep);
  */
 int gpiod_set_raw_array_value_cansleep(unsigned int array_size,
 					struct gpio_desc **desc_array,
+					struct gpio_array *array_info,
 					unsigned long *value_bitmap)
 {
 	might_sleep_if(extra_checks);
 	if (!desc_array)
 		return -EINVAL;
 	return gpiod_set_array_value_complex(true, true, array_size, desc_array,
-				      value_bitmap);
+				      array_info, value_bitmap);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_raw_array_value_cansleep);
 
@@ -3539,6 +3561,7 @@ void gpiod_add_lookup_tables(struct gpiod_lookup_table **tables, size_t n)
  * gpiod_set_array_value_cansleep() - assign values to an array of GPIOs
  * @array_size: number of elements in the descriptor array / value bitmap
  * @desc_array: array of GPIO descriptors whose values will be assigned
+ * @array_info: information on applicability of fast bitmap processing path
  * @value_bitmap: bitmap of values to assign
  *
  * Set the logical values of the GPIOs, i.e. taking their ACTIVE_LOW status
@@ -3548,13 +3571,14 @@ void gpiod_add_lookup_tables(struct gpiod_lookup_table **tables, size_t n)
  */
 void gpiod_set_array_value_cansleep(unsigned int array_size,
 				    struct gpio_desc **desc_array,
+				    struct gpio_array *array_info,
 				    unsigned long *value_bitmap)
 {
 	might_sleep_if(extra_checks);
 	if (!desc_array)
 		return;
 	gpiod_set_array_value_complex(false, true, array_size, desc_array,
-				      value_bitmap);
+				      array_info, value_bitmap);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_array_value_cansleep);
 
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index b60905d558b1..b65ca896b24d 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -196,10 +196,12 @@ struct gpio_desc *gpiochip_get_desc(struct gpio_chip *chip, u16 hwnum);
 int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 				  unsigned int array_size,
 				  struct gpio_desc **desc_array,
+				  struct gpio_array *array_info,
 				  unsigned long *value_bitmap);
 int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 				   unsigned int array_size,
 				   struct gpio_desc **desc_array,
+				   struct gpio_array *array_info,
 				   unsigned long *value_bitmap);
 
 /* This is just passed between gpiolib and devres */
diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index d835857bb094..13882a2a4f60 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -30,7 +30,8 @@ static void i2c_mux_gpio_set(const struct gpiomux *mux, unsigned val)
 
 	values[0] = val;
 
-	gpiod_set_array_value_cansleep(mux->data.n_gpios, mux->gpios, values);
+	gpiod_set_array_value_cansleep(mux->data.n_gpios, mux->gpios, NULL,
+				       values);
 }
 
 static int i2c_mux_gpio_select(struct i2c_mux_core *muxc, u32 chan)
diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index 902476ef9a0e..7f882a2bb872 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -46,7 +46,7 @@ static void mmc_pwrseq_simple_set_gpios_value(struct mmc_pwrseq_simple *pwrseq,
 		values[0] = value;
 
 		gpiod_set_array_value_cansleep(nvalues, reset_gpios->desc,
-					       values);
+					       reset_gpios->info, values);
 	}
 }
 
diff --git a/drivers/mux/gpio.c b/drivers/mux/gpio.c
index 46c44532fbd5..02c1f2c014e8 100644
--- a/drivers/mux/gpio.c
+++ b/drivers/mux/gpio.c
@@ -27,7 +27,8 @@ static int mux_gpio_set(struct mux_control *mux, int state)
 	values[0] = state;
 
 	gpiod_set_array_value_cansleep(mux_gpio->gpios->ndescs,
-				       mux_gpio->gpios->desc, values);
+				       mux_gpio->gpios->desc,
+				       mux_gpio->gpios->info, values);
 
 	return 0;
 }
diff --git a/drivers/net/phy/mdio-mux-gpio.c b/drivers/net/phy/mdio-mux-gpio.c
index e25ccfc8c070..fe34576262bd 100644
--- a/drivers/net/phy/mdio-mux-gpio.c
+++ b/drivers/net/phy/mdio-mux-gpio.c
@@ -34,7 +34,7 @@ static int mdio_mux_gpio_switch_fn(int current_child, int desired_child,
 	values[0] = desired_child;
 
 	gpiod_set_array_value_cansleep(s->gpios->ndescs, s->gpios->desc,
-				       values);
+				       s->gpios->info, values);
 
 	return 0;
 }
diff --git a/drivers/pcmcia/soc_common.c b/drivers/pcmcia/soc_common.c
index ac033d555700..3a8c84bb174d 100644
--- a/drivers/pcmcia/soc_common.c
+++ b/drivers/pcmcia/soc_common.c
@@ -364,7 +364,7 @@ static int soc_common_pcmcia_config_skt(
 		}
 
 		if (n)
-			gpiod_set_array_value_cansleep(n, descs, values);
+			gpiod_set_array_value_cansleep(n, descs, NULL, values);
 
 		/*
 		 * This really needs a better solution.  The IRQ
diff --git a/drivers/phy/motorola/phy-mapphone-mdm6600.c b/drivers/phy/motorola/phy-mapphone-mdm6600.c
index 9162b61ddb95..25d456a323c2 100644
--- a/drivers/phy/motorola/phy-mapphone-mdm6600.c
+++ b/drivers/phy/motorola/phy-mapphone-mdm6600.c
@@ -162,7 +162,8 @@ static void phy_mdm6600_cmd(struct phy_mdm6600 *ddata, int val)
 	values[0] = val;
 
 	gpiod_set_array_value_cansleep(PHY_MDM6600_NR_CMD_LINES,
-				       ddata->cmd_gpios->desc, values);
+				       ddata->cmd_gpios->desc,
+				       ddata->cmd_gpios->info, values);
 }
 
 /**
@@ -181,6 +182,7 @@ static void phy_mdm6600_status(struct work_struct *work)
 
 	error = gpiod_get_array_value_cansleep(PHY_MDM6600_NR_STATUS_LINES,
 					       ddata->status_gpios->desc,
+					       ddata->status_gpios->info,
 					       values);
 	if (error)
 		return;
diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
index 9c1d77d48700..b7810b1aad07 100644
--- a/drivers/staging/iio/adc/ad7606.c
+++ b/drivers/staging/iio/adc/ad7606.c
@@ -230,7 +230,8 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 		values[0] = ret;
 
 		mutex_lock(&st->lock);
-		gpiod_set_array_value(3, st->gpio_os->desc, values);
+		gpiod_set_array_value(3, st->gpio_os->desc, st->gpio_os->info,
+				      values);
 		st->oversampling = val;
 		mutex_unlock(&st->lock);
 
diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
index 7d9d2c7b6c39..39ed56214cd3 100644
--- a/drivers/tty/serial/serial_mctrl_gpio.c
+++ b/drivers/tty/serial/serial_mctrl_gpio.c
@@ -53,7 +53,7 @@ void mctrl_gpio_set(struct mctrl_gpios *gpios, unsigned int mctrl)
 				     mctrl & mctrl_gpios_desc[i].mctrl);
 			count++;
 		}
-	gpiod_set_array_value(count, desc_array, values);
+	gpiod_set_array_value(count, desc_array, NULL, values);
 }
 EXPORT_SYMBOL_GPL(mctrl_gpio_set);
 
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 0ffd71c0a77c..d7fbe30ece84 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -114,36 +114,44 @@ int gpiod_direction_output_raw(struct gpio_desc *desc, int value);
 int gpiod_get_value(const struct gpio_desc *desc);
 int gpiod_get_array_value(unsigned int array_size,
 			  struct gpio_desc **desc_array,
+			  struct gpio_array *array_info,
 			  unsigned long *value_bitmap);
 void gpiod_set_value(struct gpio_desc *desc, int value);
 void gpiod_set_array_value(unsigned int array_size,
 			   struct gpio_desc **desc_array,
+			   struct gpio_array *array_info,
 			   unsigned long *value_bitmap);
 int gpiod_get_raw_value(const struct gpio_desc *desc);
 int gpiod_get_raw_array_value(unsigned int array_size,
 			      struct gpio_desc **desc_array,
+			      struct gpio_array *array_info,
 			      unsigned long *value_bitmap);
 void gpiod_set_raw_value(struct gpio_desc *desc, int value);
 int gpiod_set_raw_array_value(unsigned int array_size,
 			       struct gpio_desc **desc_array,
+			       struct gpio_array *array_info,
 			       unsigned long *value_bitmap);
 
 /* Value get/set from sleeping context */
 int gpiod_get_value_cansleep(const struct gpio_desc *desc);
 int gpiod_get_array_value_cansleep(unsigned int array_size,
 				   struct gpio_desc **desc_array,
+				   struct gpio_array *array_info,
 				   unsigned long *value_bitmap);
 void gpiod_set_value_cansleep(struct gpio_desc *desc, int value);
 void gpiod_set_array_value_cansleep(unsigned int array_size,
 				    struct gpio_desc **desc_array,
+				    struct gpio_array *array_info,
 				    unsigned long *value_bitmap);
 int gpiod_get_raw_value_cansleep(const struct gpio_desc *desc);
 int gpiod_get_raw_array_value_cansleep(unsigned int array_size,
 				       struct gpio_desc **desc_array,
+				       struct gpio_array *array_info,
 				       unsigned long *value_bitmap);
 void gpiod_set_raw_value_cansleep(struct gpio_desc *desc, int value);
 int gpiod_set_raw_array_value_cansleep(unsigned int array_size,
 					struct gpio_desc **desc_array,
+					struct gpio_array *array_info,
 					unsigned long *value_bitmap);
 
 int gpiod_set_debounce(struct gpio_desc *desc, unsigned debounce);
@@ -341,6 +349,7 @@ static inline int gpiod_get_value(const struct gpio_desc *desc)
 }
 static inline int gpiod_get_array_value(unsigned int array_size,
 					struct gpio_desc **desc_array,
+					struct gpio_array *array_info,
 					unsigned long *value_bitmap)
 {
 	/* GPIO can never have been requested */
@@ -354,6 +363,7 @@ static inline void gpiod_set_value(struct gpio_desc *desc, int value)
 }
 static inline void gpiod_set_array_value(unsigned int array_size,
 					 struct gpio_desc **desc_array,
+					 struct gpio_array *array_info,
 					 unsigned long *value_bitmap)
 {
 	/* GPIO can never have been requested */
@@ -367,6 +377,7 @@ static inline int gpiod_get_raw_value(const struct gpio_desc *desc)
 }
 static inline int gpiod_get_raw_array_value(unsigned int array_size,
 					    struct gpio_desc **desc_array,
+					    struct gpio_array *array_info,
 					    unsigned long *value_bitmap)
 {
 	/* GPIO can never have been requested */
@@ -380,6 +391,7 @@ static inline void gpiod_set_raw_value(struct gpio_desc *desc, int value)
 }
 static inline int gpiod_set_raw_array_value(unsigned int array_size,
 					     struct gpio_desc **desc_array,
+					     struct gpio_array *array_info,
 					     unsigned long *value_bitmap)
 {
 	/* GPIO can never have been requested */
@@ -395,6 +407,7 @@ static inline int gpiod_get_value_cansleep(const struct gpio_desc *desc)
 }
 static inline int gpiod_get_array_value_cansleep(unsigned int array_size,
 				     struct gpio_desc **desc_array,
+				     struct gpio_array *array_info,
 				     unsigned long *value_bitmap)
 {
 	/* GPIO can never have been requested */
@@ -408,6 +421,7 @@ static inline void gpiod_set_value_cansleep(struct gpio_desc *desc, int value)
 }
 static inline void gpiod_set_array_value_cansleep(unsigned int array_size,
 					    struct gpio_desc **desc_array,
+					    struct gpio_array *array_info,
 					    unsigned long *value_bitmap)
 {
 	/* GPIO can never have been requested */
@@ -421,6 +435,7 @@ static inline int gpiod_get_raw_value_cansleep(const struct gpio_desc *desc)
 }
 static inline int gpiod_get_raw_array_value_cansleep(unsigned int array_size,
 					       struct gpio_desc **desc_array,
+					       struct gpio_array *array_info,
 					       unsigned long *value_bitmap)
 {
 	/* GPIO can never have been requested */
@@ -435,6 +450,7 @@ static inline void gpiod_set_raw_value_cansleep(struct gpio_desc *desc,
 }
 static inline int gpiod_set_raw_array_value_cansleep(unsigned int array_size,
 						struct gpio_desc **desc_array,
+						struct gpio_array *array_info,
 						unsigned long *value_bitmap)
 {
 	/* GPIO can never have been requested */
-- 
2.16.4
