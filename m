From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/4] gpiolib: Add gpiochip_find_by_name() and
 gpio_find_by_chip_name()
Date: Thu, 01 Mar 2012 10:55:24 -0800
Message-ID: <20120301185524.29210.60381.stgit@kaulin.local>
References: <20120301185044.29210.44521.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:20414 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756145Ab2CASz3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Mar 2012 13:55:29 -0500
In-Reply-To: <20120301185044.29210.44521.stgit@kaulin.local>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linuxkernel@vger.kernel.org
Cc: Linus Walleij <linus.walleij@stericsson.com>, Arnd Bergmann <arnd@arndb.de>, Rajendra Nayak <rnayak@ti.com>, linux-mmc@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Currently there is no way for drivers to request a GPIO on a particular
gpio chip. This makes it hard to support multiple GPIO controllers
with dynamic GPIO and interrupt numbering, such as with CONFIG_SPARSE_IRQ.

Make it easier for device drivers to find GPIOs on a specific gpio_chip
by adding two functions: gpiochip_find_by_name() and gpio_find_by_chip_name().

Note that as gpiochip_find() is already exported, we may as well
export gpiochip_find_by_name() too.

Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Linus Walleij <linus.walleij@stericsson.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/gpio/gpiolib.c     |   47 ++++++++++++++++++++++++++++++++++++++++++++
 include/asm-generic/gpio.h |    3 ++-
 2 files changed, 49 insertions(+), 1 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 17fdf4b..0e5bf55 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1173,6 +1173,53 @@ struct gpio_chip *gpiochip_find(void *data,
 }
 EXPORT_SYMBOL_GPL(gpiochip_find);
 
+static int match_name(struct gpio_chip *chip, void *data)
+{
+	const char *name = data;
+
+	return sysfs_streq(name, chip->label);
+}
+
+/**
+ * gpiochip_find_by_name() - iterator for locating a gpio_chip by name
+ * @name: name of the gpio_chip
+ *
+ * Similar to bus_find_device_by_name. It returns a reference to the
+ * first gpio_chip with matching name. It ignores NULL and empty names.
+ * If you need to do something more complex, then use gpiochip_find.
+ */
+struct gpio_chip *gpiochip_find_by_name(const char *name)
+{
+	if (!name || !strcmp(name, ""))
+		return NULL;
+
+	return gpiochip_find((void *)name, match_name);
+}
+EXPORT_SYMBOL_GPL(gpiochip_find_by_name);
+
+/**
+ * gpio_find_by_chip_name() - find a gpio on a specific gpio_chip
+ * @chip_name: name of the gpio_chip
+ * @gpio_offset: offset of the gpio on the gpio_chip
+ *
+ * Note that gpiochip_find_by_name returns the first matching
+ * gpio_chip name. For more complex matching, see gpio_find.
+ */
+int gpio_find_by_chip_name(const char *chip_name, unsigned gpio_offset)
+{
+	struct gpio_chip *chip;
+	int gpio, res;
+
+	chip = gpiochip_find_by_name(chip_name);
+	if (!chip)
+		return -ENODEV;
+
+	gpio = chip->base + gpio_offset;
+
+	return gpio;
+}
+EXPORT_SYMBOL_GPL(gpio_find_by_chip_name);
+
 /* These "optional" allocation calls help prevent drivers from stomping
  * on each other, and help provide better diagnostics in debugfs.
  * They're called even less than the "set direction" calls.
diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
index 1ff4e22..d7a2100 100644
--- a/include/asm-generic/gpio.h
+++ b/include/asm-generic/gpio.h
@@ -145,7 +145,8 @@ extern int __must_check gpiochip_remove(struct gpio_chip *chip);
 extern struct gpio_chip *gpiochip_find(void *data,
 					int (*match)(struct gpio_chip *chip,
 						     void *data));
-
+extern struct gpio_chip *gpiochip_find_by_name(const char *name);
+extern int gpio_find_by_chip_name(const char *chip_name, unsigned gpio_offset);
 
 /* Always use the library code for GPIO management calls,
  * or when sleeping may be involved.

