From: Domenico Andreoli <dr.domenico.andreoli@gmail.com>
Subject: [PATCH 1/2] Add OF binding helpers for MMC drivers
Date: Thu, 21 Apr 2011 15:19:57 +0200
Message-ID: <20110421131957.GB15194@dandreoli.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33185 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321Ab1DUNUB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2011 09:20:01 -0400
Received: by wwa36 with SMTP id 36so2086112wwa.1
        for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2011 06:20:00 -0700 (PDT)
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, spi-devel-general@lists.sourceforge.net

From: Domenico Andreoli <cavokz@gmail.com>

This patch adds helpers to manage OF binding of MMC DeviceTree configs.
They don't cover all the MMC configuration cases, indeed are only a
slight generalization of those found in the MMC-over-SPI driver. More
will come later.

Signed-off-by: Domenico Andreoli <cavokz@gmail.com>
---
 drivers/of/Kconfig     |    4 +
 drivers/of/Makefile    |    1 +
 drivers/of/of_mmc.c    |  165 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of_mmc.h |   50 +++++++++++++++
 4 files changed, 220 insertions(+)

Index: b/drivers/of/Kconfig
===================================================================
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -59,6 +59,10 @@ config OF_I2C
 	help
 	  OpenFirmware I2C accessors
 
+config OF_MMC
+	depends on MMC
+	def_bool y
+
 config OF_NET
 	depends on NETDEVICES
 	def_bool y
Index: b/drivers/of/Makefile
===================================================================
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_OF_DEVICE) += device.o plat
 obj-$(CONFIG_OF_GPIO)   += gpio.o
 obj-$(CONFIG_OF_CLOCK)	+= clock.o
 obj-$(CONFIG_OF_I2C)	+= of_i2c.o
+obj-$(CONFIG_OF_MMC)	+= of_mmc.o
 obj-$(CONFIG_OF_NET)	+= of_net.o
 obj-$(CONFIG_OF_SPI)	+= of_spi.o
 obj-$(CONFIG_OF_MDIO)	+= of_mdio.o
Index: b/drivers/of/of_mmc.c
===================================================================
--- /dev/null
+++ b/drivers/of/of_mmc.c
@@ -0,0 +1,165 @@
+/*
+ * OF helpers for the MMC API
+ *
+ * Copyright (c) 2011 Domenico Andreoli
+ *
+ * Heavily inspired by the OF support to the MMC-over-SPI driver made
+ * by Anton Vorontsov
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/mmc/core.h>
+#include <linux/gpio.h>
+#include <linux/of.h>
+#include <linux/of_mmc.h>
+#include <linux/of_gpio.h>
+
+static int of_read_mmc_gpio(struct of_mmc_crg *crg, int gpio_num)
+{
+	int value, active_low;
+
+	BUG_ON(gpio_num >= NUM_MMC_GPIOS);
+
+	/* hitting this means that DeviceTree left this gpio unspecified
+	 * by purpose but driver didn't take any measure to define its
+	 * behavior (i.e. aborting probe phase or disabling the feature).
+	 * driver needs to call of_is_valid_mmc_crg() for each expected
+	 * gpio to detect this case.
+	 */
+	if (WARN_ON(crg->gpios[gpio_num] < 0))
+		return -1;
+
+	value = gpio_get_value(crg->gpios[gpio_num]);
+	active_low = crg->alow_gpios[gpio_num];
+	return value ^ active_low;
+}
+
+int of_get_mmc_cd_gpio(struct of_mmc_crg *crg)
+{
+	return of_read_mmc_gpio(crg, CD_MMC_GPIO);
+}
+EXPORT_SYMBOL(of_get_mmc_cd_gpio);
+
+int of_get_mmc_ro_gpio(struct of_mmc_crg *crg)
+{
+	return of_read_mmc_gpio(crg, WP_MMC_GPIO);
+}
+EXPORT_SYMBOL(of_get_mmc_ro_gpio);
+
+int of_is_valid_mmc_crg(struct of_mmc_crg *crg, int gpio_num)
+{
+	BUG_ON(gpio_num >= NUM_MMC_GPIOS);
+	return gpio_is_valid(crg->gpios[gpio_num]);
+}
+EXPORT_SYMBOL(of_is_valid_mmc_crg);
+
+int of_get_mmc_crg(struct device *dev, struct device_node *np,
+                   int cd_off, struct of_mmc_crg *crg)
+{
+	int *gpio, *alow;
+	int i, ret;
+
+	memset(crg, 0, sizeof(*crg));
+	crg->cd_irq = -1;
+
+	gpio = crg->gpios;
+	alow = crg->alow_gpios;
+	for (i = 0; i < NUM_MMC_GPIOS; i++, gpio++, alow++) {
+		enum of_gpio_flags gpio_flags;
+		*gpio = of_get_gpio_flags(np, cd_off+i, &gpio_flags);
+		*alow = !!(gpio_flags & OF_GPIO_ACTIVE_LOW);
+
+		if (*gpio == -EEXIST || *gpio == -ENOENT) {
+			/* driver needs to define proper meaning of this missing
+			   gpio (i.e. abort probe or disable the feature) */
+			pr_debug("%s: gpio #%d is not specified\n", __func__, i);
+			continue;
+		}
+		if (*gpio < 0) {
+			pr_debug("%s: invalid configuration\n", __func__);
+			ret = *gpio;
+			break;
+		}
+		if (!gpio_is_valid(*gpio)) {
+			pr_debug("%s: gpio #%d is not valid: %d\n", __func__, i, *gpio);
+			ret = -EINVAL;
+			break;
+		}
+		ret = gpio_request(*gpio, dev_name(dev));
+		if (ret < 0) {
+			pr_debug("%s: gpio #%d is not available: %d\n", __func__, i, *gpio);
+			break;
+		}
+	}
+
+	if (i < NUM_MMC_GPIOS) {
+		while (--gpio >= crg->gpios)
+			if (gpio_is_valid(*gpio))
+				gpio_free(*gpio);
+		return ret;
+	}
+
+	if (gpio_is_valid(crg->gpios[CD_MMC_GPIO])) {
+		gpio_direction_input(crg->gpios[CD_MMC_GPIO]);
+		crg->cd_irq = gpio_to_irq(crg->gpios[CD_MMC_GPIO]);
+		if (crg->cd_irq < 0)
+			pr_debug("%s: cannot get cd irq number\n", __func__);
+	}
+	if (gpio_is_valid(crg->gpios[WP_MMC_GPIO]))
+		gpio_direction_input(crg->gpios[WP_MMC_GPIO]);
+
+	return 0;
+}
+EXPORT_SYMBOL(of_get_mmc_crg);
+
+void of_put_mmc_crg(struct of_mmc_crg *crg)
+{
+	int i;
+	for (i = 0; i < NUM_MMC_GPIOS; i++)
+		if (gpio_is_valid(crg->gpios[i]))
+			gpio_free(crg->gpios[i]);
+}
+EXPORT_SYMBOL(of_put_mmc_crg);
+
+u32 of_get_mmc_ocr_mask(struct device_node *np)
+{
+	const u32 *voltage_ranges;
+	int num_ranges;
+	u32 ocr_mask;
+	int i, j;
+
+	voltage_ranges = of_get_property(np, "voltage-ranges", &num_ranges);
+	num_ranges = num_ranges / sizeof(*voltage_ranges) / 2;
+	if (!voltage_ranges || !num_ranges) {
+		pr_debug("%s: voltage-ranges unspecified\n", __func__);
+		return 0;
+	}
+
+	ocr_mask = 0;
+	for (i = 0, j = 0; i < num_ranges; i++) {
+		int vdd_min = be32_to_cpup(voltage_ranges++);
+		int vdd_max = be32_to_cpup(voltage_ranges++);
+		u32 mask = mmc_vddrange_to_ocrmask(vdd_min, vdd_max);
+
+		if (!mask) {
+			pr_debug("%s: voltage-range #%d is invalid\n", __func__, i);
+			return 0;
+		}
+		ocr_mask |= mask;
+	}
+
+	return ocr_mask;
+}
+EXPORT_SYMBOL(of_get_mmc_ocr_mask);
+
+MODULE_AUTHOR("Domenico Andreoli <cavok@gmail.com>");
+MODULE_LICENSE("GPL");
Index: b/include/linux/of_mmc.h
===================================================================
--- /dev/null
+++ b/include/linux/of_mmc.h
@@ -0,0 +1,50 @@
+/*
+ * OF helpers for the MMC API
+ *
+ * Copyright (c) 2011 Domenico Andreoli
+ *
+ * Heavily inspired by the OF support to the MMC-over-SPI driver made
+ * by Anton Vorontsov
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __LINUX_OF_MMC_H
+#define __LINUX_OF_MMC_H
+
+#include <linux/of.h>
+#include <linux/gpio.h>
+
+#ifdef CONFIG_OF_MMC
+
+enum {
+	CD_MMC_GPIO = 0,
+	WP_MMC_GPIO,
+	NUM_MMC_GPIOS,
+};
+
+/* Card detect and Read only Gpio data */
+struct of_mmc_crg {
+	int gpios[NUM_MMC_GPIOS];
+	int alow_gpios[NUM_MMC_GPIOS];
+	int cd_irq;
+};
+
+extern u32 of_get_mmc_ocr_mask(struct device_node *);
+extern int of_get_mmc_crg(struct device *, struct device_node *,
+                          int cd_off, struct of_mmc_crg *);
+
+/* if board does not use cd interrupts, driver can optimize polling
+   using this function. */
+extern int of_get_mmc_cd_gpio(struct of_mmc_crg *);
+/* sense switch on sd cards */
+extern int of_get_mmc_ro_gpio(struct of_mmc_crg *);
+extern int of_is_valid_mmc_crg(struct of_mmc_crg *, int gpio_num);
+extern void of_put_mmc_crg(struct of_mmc_crg *);
+
+#endif /* CONFIG_OF_MMC */
+
+#endif /* __LINUX_OF_MMC_H */
