From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 24/29] mmc: add a simple generic OF parser
Date: Thu,  3 May 2012 17:05:53 +0200
Message-ID: <1336057558-11031-25-git-send-email-g.liakhovetski@gmx.de>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:54202 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756703Ab2ECPGF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 3 May 2012 11:06:05 -0400
In-Reply-To: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>

Many MMC host drivers already use OF data to obtain their platform-specific
configuration. Each of them is doing this in its special way, whereas many
parameters are identical and can easily be generalised. This patch adds
such a generic parser. So far it only adds and handles very few basic
properties. New ones can be added in the future as required.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/mmc/core/Makefile |    2 +
 drivers/mmc/core/of.c     |   91 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h  |   12 ++++++
 3 files changed, 105 insertions(+), 0 deletions(-)
 create mode 100644 drivers/mmc/core/of.c

diff --git a/drivers/mmc/core/Makefile b/drivers/mmc/core/Makefile
index 38ed210..aa7727e 100644
--- a/drivers/mmc/core/Makefile
+++ b/drivers/mmc/core/Makefile
@@ -9,4 +9,6 @@ mmc_core-y			:= core.o bus.o host.o \
 				   sdio_cis.o sdio_io.o sdio_irq.o \
 				   quirks.o slot-gpio.o
 
+mmc_core-$(CONFIG_OF)		+= of.o
+
 mmc_core-$(CONFIG_DEBUG_FS)	+= debugfs.o
diff --git a/drivers/mmc/core/of.c b/drivers/mmc/core/of.c
new file mode 100644
index 0000000..2fba115
--- /dev/null
+++ b/drivers/mmc/core/of.c
@@ -0,0 +1,91 @@
+/*
+ * Generic MMC OF parser
+ *
+ * Copyright (C) 2012, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/slot-gpio.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+
+/*
+ * Implementation-specific capabilities, that the controller driver usually
+ * cannot autodetect and has to receive from an external source, e.g., from
+ * platform data or from OF are:
+ *
+ * MMC_CAP_4_BIT_DATA: depends on the board layout: how many data lines are
+ *			connected
+ * MMC_CAP_8_BIT_DATA: ditto
+ * MMC_CAP2_INVERTED_CD: card-detect active-low (0 == card present)
+ * MMC_CAP2_INVERTED_RO: write-protect active-low (0 == read-only)
+ *	Some features might be supplied as GPIO bindings:
+ * MMC_CAP_SDIO_IRQ: depends, whether an SDIO IRQ line is connected
+ * MMC_CAP_NEEDS_POLL: is a card-detect pin connected?
+ * MMC_CAP_NONREMOVABLE: can also be a board feature, also, some media-types
+ *			(eMMC?) are intrinsicly non-removable
+ *	Others can be retrieved from regulators:
+ * MMC_CAP_POWER_OFF_CARD
+ */
+
+void mmc_of_get(struct mmc_host *mmc)
+{
+	struct device *dev = mmc_dev(mmc);
+	struct device_node *node = dev->of_node;
+	enum of_gpio_flags flags;
+	unsigned int gpio;
+	int ret;
+
+	if (!node || !of_device_is_available(node))
+		return;
+
+	if (of_get_property(node, "mmc,4_bit_data", NULL))
+		mmc->caps |= MMC_CAP_4_BIT_DATA;
+	if (of_get_property(node, "mmc,8_bit_data", NULL))
+		mmc->caps |= MMC_CAP_8_BIT_DATA;
+	if (of_get_property(node, "mmc,sdio_irq", NULL))
+		mmc->caps |= MMC_CAP_SDIO_IRQ;
+	if (of_get_property(node, "mmc,nonremovable", NULL))
+		mmc->caps |= MMC_CAP_NONREMOVABLE;
+	if (of_get_property(node, "mmc,needs_poll", NULL))
+		mmc->caps |= MMC_CAP_NEEDS_POLL;
+	if (of_get_property(node, "mmc,inverted_cd", NULL))
+		mmc->caps2 |= MMC_CAP2_INVERTED_CD;
+	if (of_get_property(node, "mmc,inverted_ro", NULL))
+		mmc->caps2 |= MMC_CAP2_INVERTED_RO;
+
+	/*
+	 * Both mmc_gpio_request_cd() and mmc_gpio_request_ro() check for
+	 * gpio_valid(), so, no need to check for error
+	 */
+
+	gpio = of_get_named_gpio_flags(node, "cd-gpios", 0, &flags);
+	ret = mmc_gpio_request_cd(mmc, gpio);
+	if (ret < 0)
+		dev_warn(mmc->parent, "Failed to obtain CD GPIO: %d\n", ret);
+
+	gpio = of_get_named_gpio_flags(node, "ro-gpios", 0, &flags);
+	ret = mmc_gpio_request_ro(mmc, gpio);
+	if (ret < 0)
+		dev_warn(mmc->parent, "Failed to obtain RO GPIO: %d\n", ret);
+}
+EXPORT_SYMBOL(mmc_of_get);
+
+void mmc_of_put(struct mmc_host *mmc)
+{
+	struct device_node *node = mmc_dev(mmc)->of_node;
+
+	if (!node || !of_device_is_available(node))
+		return;
+
+	mmc_gpio_free_ro(mmc);
+	mmc_gpio_free_cd(mmc);
+}
+EXPORT_SYMBOL(mmc_of_put);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index f8157a9..94b3805 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -450,4 +450,16 @@ static inline unsigned int mmc_host_clk_rate(struct mmc_host *host)
 	return host->ios.clock;
 }
 #endif
+
+#ifdef CONFIG_OF
+void mmc_of_get(struct mmc_host *mmc);
+void mmc_of_put(struct mmc_host *mmc);
+#else
+static inline void mmc_of_get(struct mmc_host *mmc)
+{
+}
+static inline void mmc_of_put(struct mmc_host *mmc)
+{
+}
+#endif
 #endif /* LINUX_MMC_HOST_H */
-- 
1.7.2.5

