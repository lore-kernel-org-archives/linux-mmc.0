From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 15/29] mmc: extend and rename cd-gpio helpers to handle more slot GPIO functions
Date: Thu,  3 May 2012 17:05:44 +0200
Message-ID: <1336057558-11031-16-git-send-email-g.liakhovetski@gmx.de>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:64740 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757416Ab2ECPGD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 3 May 2012 11:06:03 -0400
In-Reply-To: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org

GPIOs can be used in MMC/SD-card slots not only for hotplug detection, but
also to implement the write-protection pin. Rename cd-gpio helpers to
slot-gpio to make addition of further slot GPIO functions possible.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/core/Makefile       |    2 +-
 drivers/mmc/core/cd-gpio.c      |   83 ---------------------------------------
 drivers/mmc/core/slot-gpio.c    |   83 +++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/tmio_mmc_pio.c |    6 +-
 include/linux/mmc/cd-gpio.h     |   18 --------
 include/linux/mmc/slot-gpio.h   |   18 ++++++++
 6 files changed, 105 insertions(+), 105 deletions(-)
 delete mode 100644 drivers/mmc/core/cd-gpio.c
 create mode 100644 drivers/mmc/core/slot-gpio.c
 delete mode 100644 include/linux/mmc/cd-gpio.h
 create mode 100644 include/linux/mmc/slot-gpio.h

diff --git a/drivers/mmc/core/Makefile b/drivers/mmc/core/Makefile
index dca4428..38ed210 100644
--- a/drivers/mmc/core/Makefile
+++ b/drivers/mmc/core/Makefile
@@ -7,6 +7,6 @@ mmc_core-y			:= core.o bus.o host.o \
 				   mmc.o mmc_ops.o sd.o sd_ops.o \
 				   sdio.o sdio_ops.o sdio_bus.o \
 				   sdio_cis.o sdio_io.o sdio_irq.o \
-				   quirks.o cd-gpio.o
+				   quirks.o slot-gpio.o
 
 mmc_core-$(CONFIG_DEBUG_FS)	+= debugfs.o
diff --git a/drivers/mmc/core/cd-gpio.c b/drivers/mmc/core/cd-gpio.c
deleted file mode 100644
index f13e38d..0000000
--- a/drivers/mmc/core/cd-gpio.c
+++ /dev/null
@@ -1,83 +0,0 @@
-/*
- * Generic GPIO card-detect helper
- *
- * Copyright (C) 2011, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/err.h>
-#include <linux/gpio.h>
-#include <linux/interrupt.h>
-#include <linux/jiffies.h>
-#include <linux/mmc/cd-gpio.h>
-#include <linux/mmc/host.h>
-#include <linux/module.h>
-#include <linux/slab.h>
-
-struct mmc_cd_gpio {
-	unsigned int gpio;
-	char label[0];
-};
-
-static irqreturn_t mmc_cd_gpio_irqt(int irq, void *dev_id)
-{
-	/* Schedule a card detection after a debounce timeout */
-	mmc_detect_change(dev_id, msecs_to_jiffies(100));
-	return IRQ_HANDLED;
-}
-
-int mmc_cd_gpio_request(struct mmc_host *host, unsigned int gpio)
-{
-	size_t len = strlen(dev_name(host->parent)) + 4;
-	struct mmc_cd_gpio *cd;
-	int irq = gpio_to_irq(gpio);
-	int ret;
-
-	if (irq < 0)
-		return irq;
-
-	cd = kmalloc(sizeof(*cd) + len, GFP_KERNEL);
-	if (!cd)
-		return -ENOMEM;
-
-	snprintf(cd->label, len, "%s cd", dev_name(host->parent));
-
-	ret = gpio_request_one(gpio, GPIOF_DIR_IN, cd->label);
-	if (ret < 0)
-		goto egpioreq;
-
-	ret = request_threaded_irq(irq, NULL, mmc_cd_gpio_irqt,
-				   IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-				   cd->label, host);
-	if (ret < 0)
-		goto eirqreq;
-
-	cd->gpio = gpio;
-	host->hotplug.irq = irq;
-	host->hotplug.handler_priv = cd;
-
-	return 0;
-
-eirqreq:
-	gpio_free(gpio);
-egpioreq:
-	kfree(cd);
-	return ret;
-}
-EXPORT_SYMBOL(mmc_cd_gpio_request);
-
-void mmc_cd_gpio_free(struct mmc_host *host)
-{
-	struct mmc_cd_gpio *cd = host->hotplug.handler_priv;
-
-	if (!cd)
-		return;
-
-	free_irq(host->hotplug.irq, host);
-	gpio_free(cd->gpio);
-	kfree(cd);
-}
-EXPORT_SYMBOL(mmc_cd_gpio_free);
diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
new file mode 100644
index 0000000..17d705f
--- /dev/null
+++ b/drivers/mmc/core/slot-gpio.c
@@ -0,0 +1,83 @@
+/*
+ * Generic GPIO card-detect helper
+ *
+ * Copyright (C) 2011, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/err.h>
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/jiffies.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/slot-gpio.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+
+struct mmc_gpio {
+	unsigned int cd_gpio;
+	char cd_label[0];
+};
+
+static irqreturn_t mmc_gpio_cd_irqt(int irq, void *dev_id)
+{
+	/* Schedule a card detection after a debounce timeout */
+	mmc_detect_change(dev_id, msecs_to_jiffies(100));
+	return IRQ_HANDLED;
+}
+
+int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio)
+{
+	size_t len = strlen(dev_name(host->parent)) + 4;
+	struct mmc_gpio *ctx;
+	int irq = gpio_to_irq(gpio);
+	int ret;
+
+	if (irq < 0)
+		return irq;
+
+	ctx = kmalloc(sizeof(*ctx) + len, GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	snprintf(ctx->cd_label, len, "%s cd", dev_name(host->parent));
+
+	ret = gpio_request_one(gpio, GPIOF_DIR_IN, ctx->cd_label);
+	if (ret < 0)
+		goto egpioreq;
+
+	ret = request_threaded_irq(irq, NULL, mmc_gpio_cd_irqt,
+				   IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+				   ctx->cd_label, host);
+	if (ret < 0)
+		goto eirqreq;
+
+	ctx->cd_gpio = gpio;
+	host->hotplug.irq = irq;
+	host->hotplug.handler_priv = ctx;
+
+	return 0;
+
+eirqreq:
+	gpio_free(gpio);
+egpioreq:
+	kfree(ctx);
+	return ret;
+}
+EXPORT_SYMBOL(mmc_gpio_request_cd);
+
+void mmc_gpio_free_cd(struct mmc_host *host)
+{
+	struct mmc_gpio *ctx = host->hotplug.handler_priv;
+
+	if (!ctx)
+		return;
+
+	free_irq(host->hotplug.irq, host);
+	gpio_free(ctx->cd_gpio);
+	kfree(ctx);
+}
+EXPORT_SYMBOL(mmc_gpio_free_cd);
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 175cc71..7da63b5 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -34,8 +34,8 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/mfd/tmio.h>
-#include <linux/mmc/cd-gpio.h>
 #include <linux/mmc/host.h>
+#include <linux/mmc/slot-gpio.h>
 #include <linux/mmc/tmio.h>
 #include <linux/module.h>
 #include <linux/pagemap.h>
@@ -1034,7 +1034,7 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	dev_pm_qos_expose_latency_limit(&pdev->dev, 100);
 
 	if (pdata->flags & TMIO_MMC_USE_GPIO_CD) {
-		ret = mmc_cd_gpio_request(mmc, pdata->cd_gpio);
+		ret = mmc_gpio_request_cd(mmc, pdata->cd_gpio);
 		if (ret < 0) {
 			tmio_mmc_host_remove(_host);
 			return ret;
@@ -1066,7 +1066,7 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
 		 * This means we can miss a card-eject, but this is anyway
 		 * possible, because of delayed processing of hotplug events.
 		 */
-		mmc_cd_gpio_free(mmc);
+		mmc_gpio_free_cd(mmc);
 
 	if (!host->native_hotplug)
 		pm_runtime_get_sync(&pdev->dev);
diff --git a/include/linux/mmc/cd-gpio.h b/include/linux/mmc/cd-gpio.h
deleted file mode 100644
index cefaba0..0000000
--- a/include/linux/mmc/cd-gpio.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * Generic GPIO card-detect helper header
- *
- * Copyright (C) 2011, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef MMC_CD_GPIO_H
-#define MMC_CD_GPIO_H
-
-struct mmc_host;
-int mmc_cd_gpio_request(struct mmc_host *host, unsigned int gpio);
-void mmc_cd_gpio_free(struct mmc_host *host);
-
-#endif
diff --git a/include/linux/mmc/slot-gpio.h b/include/linux/mmc/slot-gpio.h
new file mode 100644
index 0000000..edfaa32
--- /dev/null
+++ b/include/linux/mmc/slot-gpio.h
@@ -0,0 +1,18 @@
+/*
+ * Generic GPIO card-detect helper header
+ *
+ * Copyright (C) 2011, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef MMC_SLOT_GPIO_H
+#define MMC_SLOT_GPIO_H
+
+struct mmc_host;
+int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio);
+void mmc_gpio_free_cd(struct mmc_host *host);
+
+#endif
-- 
1.7.2.5

