From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFC RFT PATCH v4 2/4] gpiolib: Identify arrays matching GPIO hardware
Date: Tue, 21 Aug 2018 01:43:39 +0200
Message-ID: <20180820234341.5271-3-jmkrzyszt@gmail.com>
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

Certain GPIO array lookup results may map directly to GPIO pins of a
single GPIO chip in hardware order.  If that condition is recognized
and handled efficiently, significant performance gain of get/set array
functions may be possible.

While processing a request for an array of GPIO descriptors, identify
those which represent corresponding pins of a single GPIO chip.  Skip
over pins which require open source or open drain special processing.
Moreover, identify pins which require inversion.  Pass a pointer to
that information with the array to the caller so it can benefit from
enhanced performance as soon as get/set array functions can accept and
make efficient use of it.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 Documentation/driver-api/gpio/consumer.rst |  4 +-
 drivers/gpio/gpiolib.c                     | 72 +++++++++++++++++++++++++++++-
 drivers/gpio/gpiolib.h                     |  9 ++++
 include/linux/gpio/consumer.h              |  9 ++++
 4 files changed, 92 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/gpio/consumer.rst b/Documentation/driver-api/gpio/consumer.rst
index ed68042ddccf..7e0298b9a7b9 100644
--- a/Documentation/driver-api/gpio/consumer.rst
+++ b/Documentation/driver-api/gpio/consumer.rst
@@ -109,9 +109,11 @@ For a function using multiple GPIOs all of those can be obtained with one call::
 					   enum gpiod_flags flags)
 
 This function returns a struct gpio_descs which contains an array of
-descriptors::
+descriptors.  It also contains a pointer to a gpiolib private structure which,
+if passed back to get/set array functions, may speed up I/O proocessing::
 
 	struct gpio_descs {
+		struct gpio_array *info;
 		unsigned int ndescs;
 		struct gpio_desc *desc[];
 	}
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index f0e9ffa8cab6..c1ed1c759345 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4174,7 +4174,9 @@ struct gpio_descs *__must_check gpiod_get_array(struct device *dev,
 {
 	struct gpio_desc *desc;
 	struct gpio_descs *descs;
-	int count;
+	struct gpio_array *array_info = NULL;
+	struct gpio_chip *chip;
+	int count, bitmap_size;
 
 	count = gpiod_count(dev, con_id);
 	if (count < 0)
@@ -4190,9 +4192,77 @@ struct gpio_descs *__must_check gpiod_get_array(struct device *dev,
 			gpiod_put_array(descs);
 			return ERR_CAST(desc);
 		}
+
 		descs->desc[descs->ndescs] = desc;
+
+		chip = gpiod_to_chip(desc);
+		/*
+		 * Select a chip of first array member
+		 * whose index matches its pin hardware number
+		 * as a candidate for fast bitmap processing.
+		 */
+		if (!array_info && gpio_chip_hwgpio(desc) == descs->ndescs) {
+			struct gpio_descs *array;
+
+			bitmap_size = BITS_TO_LONGS(chip->ngpio > count ?
+						    chip->ngpio : count);
+
+			array = kzalloc(struct_size(descs, desc, count) +
+					struct_size(array_info, invert_mask,
+					3 * bitmap_size), GFP_KERNEL);
+			if (!array) {
+				gpiod_put_array(descs);
+				return ERR_PTR(-ENOMEM);
+			}
+
+			memcpy(array, descs,
+			       struct_size(descs, desc, descs->ndescs + 1));
+			kfree(descs);
+
+			descs = array;
+			array_info = (void *)(descs->desc + count);
+			array_info->get_mask = array_info->invert_mask +
+						  bitmap_size;
+			array_info->set_mask = array_info->get_mask +
+						  bitmap_size;
+
+			array_info->desc = descs->desc;
+			array_info->size = count;
+			array_info->chip = chip;
+			bitmap_set(array_info->get_mask, descs->ndescs,
+				   count - descs->ndescs);
+			bitmap_set(array_info->set_mask, descs->ndescs,
+				   count - descs->ndescs);
+			descs->info = array_info;
+		}
+		/*
+		 * Unmark members which don't qualify for fast bitmap
+		 * processing (different chip, not in hardware order)
+		 */
+		if (array_info && (chip != array_info->chip ||
+		    gpio_chip_hwgpio(desc) != descs->ndescs)) {
+			__clear_bit(descs->ndescs, array_info->get_mask);
+			__clear_bit(descs->ndescs, array_info->set_mask);
+		} else if (array_info) {
+			/* Exclude open drain or open source from fast output */
+			if (gpiochip_line_is_open_drain(chip, descs->ndescs) ||
+			    gpiochip_line_is_open_source(chip, descs->ndescs))
+				__clear_bit(descs->ndescs,
+					    array_info->set_mask);
+			/* Identify 'fast' pins which require invertion */
+			if (gpiod_is_active_low(desc))
+				__set_bit(descs->ndescs,
+					  array_info->invert_mask);
+		}
+
 		descs->ndescs++;
 	}
+	if (array_info)
+		dev_dbg(dev,
+			"GPIO array info: chip=%s, size=%d, get_mask=%lx, set_mask=%lx, invert_mask=%lx\n",
+			array_info->chip->label, array_info->size,
+			*array_info->get_mask, *array_info->set_mask,
+			*array_info->invert_mask);
 	return descs;
 }
 EXPORT_SYMBOL_GPL(gpiod_get_array);
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 11e83d2eef89..b60905d558b1 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -183,6 +183,15 @@ static inline bool acpi_can_fallback_to_crs(struct acpi_device *adev,
 }
 #endif
 
+struct gpio_array {
+	struct gpio_desc	**desc;
+	unsigned int		size;
+	struct gpio_chip	*chip;
+	unsigned long		*get_mask;
+	unsigned long		*set_mask;
+	unsigned long		invert_mask[];
+};
+
 struct gpio_desc *gpiochip_get_desc(struct gpio_chip *chip, u16 hwnum);
 int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 				  unsigned int array_size,
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 1b21dc7b0fad..8dede3e886af 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -17,11 +17,20 @@ struct device;
  */
 struct gpio_desc;
 
+/**
+ * Opaque descriptor for a structure of GPIO array attributes.  This structure
+ * is attached to struct gpiod_descs obtained from gpiod_get_array() and can be
+ * passed back to get/set array functions in order to activate fast processing
+ * path if applicable.
+ */
+struct gpio_array;
+
 /**
  * Struct containing an array of descriptors that can be obtained using
  * gpiod_get_array().
  */
 struct gpio_descs {
+	struct gpio_array *info;
 	unsigned int ndescs;
 	struct gpio_desc *desc[];
 };
-- 
2.16.4
