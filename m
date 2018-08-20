From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFC RFT PATCH v4 3/4] gpiolib: Pass array info to get/set array
 functions
Date: Tue, 21 Aug 2018 01:43:40 +0200
Message-ID: <20180820234341.5271-4-jmkrzyszt@gmail.com>
References: <20180813223448.21316-1-jmkrzyszt@gmail.com>
 <20180820234341.5271-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20180820234341.5271-1-jmkrzyszt@gmail.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>, linux-doc@vger.kernel.org, linux-iio@vger.kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>, netdev@vger.kernel.org, linux-i2c@vger.kernel.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, devel@driverdev.osuosl.org, Florian Fainelli <f.fainelli@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Michael Hennerich <Michael.Hennerich@analog.com>, linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>, Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>, Peter Korsgaard <peter.korsgaard@barco.com>, Hartmut Knaack <kna>
List-Id: linux-mmc@vger.kernel.org

In order to make use of array info obtained from gpiod_get_array() and
speed up processing of arrays matching single GPIO chip layout, that
information must be passed to get/set array functions.  Extend the
functions' API with that additional parameter and update all users.
Pass NULL if a user bulids an array itself from single GPIOs.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 Documentation/driver-api/gpio/consumer.rst  | 14 ++++++++++--
 drivers/auxdisplay/hd44780.c                | 12 ++++++----
 drivers/bus/ts-nbus.c                       |  6 +++--
 drivers/gpio/gpio-max3191x.c                |  6 +++--
 drivers/gpio/gpiolib.c                      | 34 ++++++++++++++++++++---------
 drivers/gpio/gpiolib.h                      |  2 ++
 drivers/i2c/muxes/i2c-mux-gpio.c            |  2 +-
 drivers/mmc/core/pwrseq_simple.c            |  2 +-
 drivers/mux/gpio.c                          |  3 ++-
 drivers/net/phy/mdio-mux-gpio.c             |  2 +-
 drivers/pcmcia/soc_common.c                 |  3 ++-
 drivers/phy/motorola/phy-mapphone-mdm6600.c |  4 +++-
 drivers/staging/iio/adc/ad7606.c            |  3 ++-
 drivers/tty/serial/serial_mctrl_gpio.c      |  2 +-
 include/linux/gpio/consumer.h               |  8 +++++++
 15 files changed, 75 insertions(+), 28 deletions(-)

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
index d340473aa142..6ae81632bc44 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -74,7 +74,8 @@ static void hd44780_write_gpio8(struct hd44780 *hd, u8 val, unsigned int rs)
 	}
 
 	/* Present the data to the port */
-	gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA0], value_bitmap);
+	gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA0], NULL,
+				       value_bitmap);
 
 	hd44780_strobe_gpio(hd);
 }
@@ -97,7 +98,8 @@ static void hd44780_write_gpio4(struct hd44780 *hd, u8 val, unsigned int rs)
 	value_bitmap[0] = value_bitmap[0] >> PIN_DATA4;
 
 	/* Present the data to the port */
-	gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4], value_bitmap);
+	gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4], NULL,
+				       value_bitmap);
 
 	hd44780_strobe_gpio(hd);
 
@@ -106,7 +108,8 @@ static void hd44780_write_gpio4(struct hd44780 *hd, u8 val, unsigned int rs)
 	value_bitmap[0] |= val & ~((1 << PIN_DATA4) - 1);
 
 	/* Present the data to the port */
-	gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4], value_bitmap);
+	gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4], NULL,
+				       value_bitmap);
 
 	hd44780_strobe_gpio(hd);
 }
@@ -169,7 +172,8 @@ static void hd44780_write_cmd_raw_gpio4(struct charlcd *lcd, int cmd)
 	value_bitmap[0] = value_bitmap[0] >> PIN_DATA4;
 
 	/* Present the data to the port */
-	gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4], value_bitmap);
+	gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4], NULL,
+				       value_bitmap);
 
 	hd44780_strobe_gpio(hd);
 }
diff --git a/drivers/bus/ts-nbus.c b/drivers/bus/ts-nbus.c
index ce6c1e89236d..000d756eb42c 100644
--- a/drivers/bus/ts-nbus.c
+++ b/drivers/bus/ts-nbus.c
@@ -112,7 +112,8 @@ static void ts_nbus_reset_bus(struct ts_nbus *ts_nbus)
 {
 	unsigned long value_bitmap[1] = { 0, };
 
-	gpiod_set_array_value_cansleep(8, ts_nbus->data->desc, value_bitmap);
+	gpiod_set_array_value_cansleep(8, ts_nbus->data->desc,
+				       ts_nbus->data->info, value_bitmap);
 	gpiod_set_value_cansleep(ts_nbus->csn, 0);
 	gpiod_set_value_cansleep(ts_nbus->strobe, 0);
 	gpiod_set_value_cansleep(ts_nbus->ale, 0);
@@ -155,7 +156,8 @@ static void ts_nbus_write_byte(struct ts_nbus *ts_nbus, u8 byte)
 	struct gpio_descs *gpios = ts_nbus->data;
 	unsigned long value_bitmap[1] = { byte, };
 
-	gpiod_set_array_value_cansleep(8, gpios->desc, value_bitmap);
+	gpiod_set_array_value_cansleep(8, gpios->desc, gpios->info,
+				       value_bitmap);
 }
 
 /*
diff --git a/drivers/gpio/gpio-max3191x.c b/drivers/gpio/gpio-max3191x.c
index c4ec1c82af27..4b43b5dabfd2 100644
--- a/drivers/gpio/gpio-max3191x.c
+++ b/drivers/gpio/gpio-max3191x.c
@@ -313,6 +313,7 @@ static int max3191x_set_config(struct gpio_chip *gpio, unsigned int offset,
 
 static void gpiod_set_array_single_value_cansleep(unsigned int ndescs,
 						  struct gpio_desc **desc,
+						  struct gpio_array *info,
 						  int value)
 {
 	unsigned long *value_bitmap;
@@ -327,7 +328,7 @@ static void gpiod_set_array_single_value_cansleep(unsigned int ndescs,
 	else
 		bitmap_zero(value_bitmap, ndescs);
 
-	gpiod_set_array_value_cansleep(ndescs, desc, value_bitmap);
+	gpiod_set_array_value_cansleep(ndescs, desc, info, value_bitmap);
 	kfree(value_bitmap);
 }
 
@@ -400,7 +401,8 @@ static int max3191x_probe(struct spi_device *spi)
 	if (max3191x->modesel_pins)
 		gpiod_set_array_single_value_cansleep(
 				 max3191x->modesel_pins->ndescs,
-				 max3191x->modesel_pins->desc, max3191x->mode);
+				 max3191x->modesel_pins->desc,
+				 max3191x->modesel_pins->info, max3191x->mode);
 
 	max3191x->ignore_uv = device_property_read_bool(dev,
 						  "maxim,ignore-undervoltage");
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index c1ed1c759345..4d26cdbdb7cf 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -435,7 +435,7 @@ static long linehandle_ioctl(struct file *filep, unsigned int cmd,
 		int ret = gpiod_get_array_value_complex(false,
 							true,
 							lh->numdescs,
-							lh->descs,
+							lh->descs, NULL,
 							value_bitmap);
 		if (ret)
 			return ret;
@@ -467,7 +467,7 @@ static long linehandle_ioctl(struct file *filep, unsigned int cmd,
 		return gpiod_set_array_value_complex(false,
 					      true,
 					      lh->numdescs,
-					      lh->descs,
+					      lh->descs, NULL,
 					      value_bitmap);
 	}
 	return -EINVAL;
@@ -2784,6 +2784,7 @@ static int gpio_chip_get_multiple(struct gpio_chip *chip,
 int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 				  unsigned int array_size,
 				  struct gpio_desc **desc_array,
+				  struct gpio_array *array_info,
 				  unsigned long *value_bitmap)
 {
 	int i = 0;
@@ -2908,12 +2909,14 @@ EXPORT_SYMBOL_GPL(gpiod_get_value);
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
 
@@ -2931,12 +2934,14 @@ EXPORT_SYMBOL_GPL(gpiod_get_raw_array_value);
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
 
@@ -3029,6 +3034,7 @@ static void gpio_chip_set_multiple(struct gpio_chip *chip,
 int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 				   unsigned int array_size,
 				   struct gpio_desc **desc_array,
+				   struct gpio_array *array_info,
 				   unsigned long *value_bitmap)
 {
 	int i = 0;
@@ -3166,12 +3172,13 @@ EXPORT_SYMBOL_GPL(gpiod_set_value);
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
 
@@ -3189,12 +3196,13 @@ EXPORT_SYMBOL_GPL(gpiod_set_raw_array_value);
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
 
@@ -3426,13 +3434,15 @@ EXPORT_SYMBOL_GPL(gpiod_get_value_cansleep);
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
 
@@ -3449,13 +3459,15 @@ EXPORT_SYMBOL_GPL(gpiod_get_raw_array_value_cansleep);
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
 
@@ -3508,13 +3520,14 @@ EXPORT_SYMBOL_GPL(gpiod_set_value_cansleep);
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
 
@@ -3548,13 +3561,14 @@ void gpiod_add_lookup_tables(struct gpiod_lookup_table **tables, size_t n)
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
index d675e0ca2fa4..aa3857ab42b5 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -34,7 +34,7 @@ static void i2c_mux_gpio_set(const struct gpiomux *mux, unsigned val)
 		mux->values[i] = (val >> i) & 1;
 
 	gpiod_set_array_value_cansleep(mux->data.n_gpios,
-				       mux->gpios, value_bitmap);
+				       mux->gpios, NULL, value_bitmap);
 }
 
 static int i2c_mux_gpio_select(struct i2c_mux_core *muxc, u32 chan)
diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index 0d6e3a5be3ba..5cf7eda8f68f 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -46,7 +46,7 @@ static void mmc_pwrseq_simple_set_gpios_value(struct mmc_pwrseq_simple *pwrseq,
 		value_bitmap[0] = value;
 
 		gpiod_set_array_value_cansleep(nvalues, reset_gpios->desc,
-					       value_bitmap);
+					       reset_gpios->info, value_bitmap);
 	}
 }
 
diff --git a/drivers/mux/gpio.c b/drivers/mux/gpio.c
index cc2d5f50472a..879f9f3f45dd 100644
--- a/drivers/mux/gpio.c
+++ b/drivers/mux/gpio.c
@@ -30,7 +30,8 @@ static int mux_gpio_set(struct mux_control *mux, int state)
 		mux_gpio->val[i] = (state >> i) & 1;
 
 	gpiod_set_array_value_cansleep(mux_gpio->gpios->ndescs,
-				       mux_gpio->gpios->desc, value_bitmap);
+				       mux_gpio->gpios->desc,
+				       mux_gpio->gpios->info, value_bitmap);
 
 	return 0;
 }
diff --git a/drivers/net/phy/mdio-mux-gpio.c b/drivers/net/phy/mdio-mux-gpio.c
index 8e1ec750277e..c0ffa03c916b 100644
--- a/drivers/net/phy/mdio-mux-gpio.c
+++ b/drivers/net/phy/mdio-mux-gpio.c
@@ -37,7 +37,7 @@ static int mdio_mux_gpio_switch_fn(int current_child, int desired_child,
 		s->values[n] = (desired_child >> n) & 1;
 
 	gpiod_set_array_value_cansleep(s->gpios->ndescs, s->gpios->desc,
-				       value_bitmap);
+				       s->gpios->info, value_bitmap);
 
 	return 0;
 }
diff --git a/drivers/pcmcia/soc_common.c b/drivers/pcmcia/soc_common.c
index e0f89155c474..55978198cd2b 100644
--- a/drivers/pcmcia/soc_common.c
+++ b/drivers/pcmcia/soc_common.c
@@ -366,7 +366,8 @@ static int soc_common_pcmcia_config_skt(
 		}
 
 		if (n)
-			gpiod_set_array_value_cansleep(n, descs, value_bitmap);
+			gpiod_set_array_value_cansleep(n, descs, NULL,
+						       value_bitmap);
 
 		/*
 		 * This really needs a better solution.  The IRQ
diff --git a/drivers/phy/motorola/phy-mapphone-mdm6600.c b/drivers/phy/motorola/phy-mapphone-mdm6600.c
index b6477c3599c4..8f508338ec56 100644
--- a/drivers/phy/motorola/phy-mapphone-mdm6600.c
+++ b/drivers/phy/motorola/phy-mapphone-mdm6600.c
@@ -162,7 +162,8 @@ static void phy_mdm6600_cmd(struct phy_mdm6600 *ddata, int val)
 	value_bitmap[0] = val & ((1 << PHY_MDM6600_NR_CMD_LINES) - 1);
 
 	gpiod_set_array_value_cansleep(PHY_MDM6600_NR_CMD_LINES,
-				       ddata->cmd_gpios->desc, value_bitmap);
+				       ddata->cmd_gpios->desc,
+				       ddata->cmd_gpios->info, value_bitmap);
 }
 
 /**
@@ -181,6 +182,7 @@ static void phy_mdm6600_status(struct work_struct *work)
 
 	error = gpiod_get_array_value_cansleep(PHY_MDM6600_NR_STATUS_LINES,
 					       ddata->status_gpios->desc,
+					       ddata->status_gpios->info,
 					       value_bitmap);
 	if (error)
 		return;
diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
index 0eca047bc1cc..eb779d825724 100644
--- a/drivers/staging/iio/adc/ad7606.c
+++ b/drivers/staging/iio/adc/ad7606.c
@@ -230,7 +230,8 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 		value_bitmap[0] = ret;
 
 		mutex_lock(&st->lock);
-		gpiod_set_array_value(3, st->gpio_os->desc, value_bitmap);
+		gpiod_set_array_value(3, st->gpio_os->desc, st->gpio_os->info,
+				      value_bitmap);
 		st->oversampling = val;
 		mutex_unlock(&st->lock);
 
diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
index bb8b4756d72d..8a04e3be5419 100644
--- a/drivers/tty/serial/serial_mctrl_gpio.c
+++ b/drivers/tty/serial/serial_mctrl_gpio.c
@@ -53,7 +53,7 @@ void mctrl_gpio_set(struct mctrl_gpios *gpios, unsigned int mctrl)
 				     !!(mctrl & mctrl_gpios_desc[i].mctrl));
 			count++;
 		}
-	gpiod_set_array_value(count, desc_array, value_bitmap);
+	gpiod_set_array_value(count, desc_array, NULL, value_bitmap);
 }
 EXPORT_SYMBOL_GPL(mctrl_gpio_set);
 
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 8dede3e886af..bf037ebe2ed8 100644
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
-- 
2.16.4
