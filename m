From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 01/10 v3] mmc: extend and rename cd-gpio helpers to handle
 more slot GPIO functions
Date: Fri, 25 May 2012 17:15:51 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1205251331150.13353@axis700.grange>
References: <Pine.LNX.4.64.1205251045490.13353@axis700.grange>
 <Pine.LNX.4.64.1205251321020.13353@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:58410 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639Ab2EYPPz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 May 2012 11:15:55 -0400
In-Reply-To: <Pine.LNX.4.64.1205251321020.13353@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>, "S, Venkatraman" <svenkatr@ti.com>

GPIOs can be used in MMC/SD-card slots not only for hotplug detection, but
also to implement the write-protection pin. Rename cd-gpio helpers to
slot-gpio to make addition of further slot GPIO functions possible.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v3: use the IRQF_ONESHOT flag, thanks to Venkatraman for the comment.

 drivers/mmc/core/Makefile                    |    2 +-
 drivers/mmc/core/{cd-gpio.c => slot-gpio.c}  |   48 +++++++++++++-------------
 drivers/mmc/host/tmio_mmc_pio.c              |    6 ++--
 include/linux/mmc/{cd-gpio.h => slot-gpio.h} |    8 ++--
 4 files changed, 32 insertions(+), 32 deletions(-)
 rename drivers/mmc/core/{cd-gpio.c => slot-gpio.c} (53%)
 rename include/linux/mmc/{cd-gpio.h => slot-gpio.h} (68%)

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
diff --git a/drivers/mmc/core/cd-gpio.c b/drivers/mmc/core/slot-gpio.c
similarity index 53%
rename from drivers/mmc/core/cd-gpio.c
rename to drivers/mmc/core/slot-gpio.c
index f13e38d..9796710 100644
--- a/drivers/mmc/core/cd-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -12,72 +12,72 @@
 #include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/jiffies.h>
-#include <linux/mmc/cd-gpio.h>
 #include <linux/mmc/host.h>
+#include <linux/mmc/slot-gpio.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 
-struct mmc_cd_gpio {
-	unsigned int gpio;
-	char label[0];
+struct mmc_gpio {
+	unsigned int cd_gpio;
+	char cd_label[0];
 };
 
-static irqreturn_t mmc_cd_gpio_irqt(int irq, void *dev_id)
+static irqreturn_t mmc_gpio_cd_irqt(int irq, void *dev_id)
 {
 	/* Schedule a card detection after a debounce timeout */
 	mmc_detect_change(dev_id, msecs_to_jiffies(100));
 	return IRQ_HANDLED;
 }
 
-int mmc_cd_gpio_request(struct mmc_host *host, unsigned int gpio)
+int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio)
 {
 	size_t len = strlen(dev_name(host->parent)) + 4;
-	struct mmc_cd_gpio *cd;
+	struct mmc_gpio *ctx;
 	int irq = gpio_to_irq(gpio);
 	int ret;
 
 	if (irq < 0)
 		return irq;
 
-	cd = kmalloc(sizeof(*cd) + len, GFP_KERNEL);
-	if (!cd)
+	ctx = kmalloc(sizeof(*ctx) + len, GFP_KERNEL);
+	if (!ctx)
 		return -ENOMEM;
 
-	snprintf(cd->label, len, "%s cd", dev_name(host->parent));
+	snprintf(ctx->cd_label, len, "%s cd", dev_name(host->parent));
 
-	ret = gpio_request_one(gpio, GPIOF_DIR_IN, cd->label);
+	ret = gpio_request_one(gpio, GPIOF_DIR_IN, ctx->cd_label);
 	if (ret < 0)
 		goto egpioreq;
 
-	ret = request_threaded_irq(irq, NULL, mmc_cd_gpio_irqt,
-				   IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-				   cd->label, host);
+	ret = request_threaded_irq(irq, NULL, mmc_gpio_cd_irqt,
+			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+			ctx->cd_label, host);
 	if (ret < 0)
 		goto eirqreq;
 
-	cd->gpio = gpio;
+	ctx->cd_gpio = gpio;
 	host->hotplug.irq = irq;
-	host->hotplug.handler_priv = cd;
+	host->hotplug.handler_priv = ctx;
 
 	return 0;
 
 eirqreq:
 	gpio_free(gpio);
 egpioreq:
-	kfree(cd);
+	kfree(ctx);
 	return ret;
 }
-EXPORT_SYMBOL(mmc_cd_gpio_request);
+EXPORT_SYMBOL(mmc_gpio_request_cd);
 
-void mmc_cd_gpio_free(struct mmc_host *host)
+void mmc_gpio_free_cd(struct mmc_host *host)
 {
-	struct mmc_cd_gpio *cd = host->hotplug.handler_priv;
+	struct mmc_gpio *ctx = host->hotplug.handler_priv;
 
-	if (!cd)
+	if (!ctx)
 		return;
 
 	free_irq(host->hotplug.irq, host);
-	gpio_free(cd->gpio);
-	kfree(cd);
+	gpio_free(ctx->cd_gpio);
+	kfree(ctx);
 }
-EXPORT_SYMBOL(mmc_cd_gpio_free);
+EXPORT_SYMBOL(mmc_gpio_free_cd);
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index b731859..5261934 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -34,9 +34,9 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/mfd/tmio.h>
-#include <linux/mmc/cd-gpio.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
+#include <linux/mmc/slot-gpio.h>
 #include <linux/mmc/tmio.h>
 #include <linux/module.h>
 #include <linux/pagemap.h>
@@ -1025,7 +1025,7 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	dev_pm_qos_expose_latency_limit(&pdev->dev, 100);
 
 	if (pdata->flags & TMIO_MMC_USE_GPIO_CD) {
-		ret = mmc_cd_gpio_request(mmc, pdata->cd_gpio);
+		ret = mmc_gpio_request_cd(mmc, pdata->cd_gpio);
 		if (ret < 0) {
 			tmio_mmc_host_remove(_host);
 			return ret;
@@ -1057,7 +1057,7 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
 		 * This means we can miss a card-eject, but this is anyway
 		 * possible, because of delayed processing of hotplug events.
 		 */
-		mmc_cd_gpio_free(mmc);
+		mmc_gpio_free_cd(mmc);
 
 	if (!host->native_hotplug)
 		pm_runtime_get_sync(&pdev->dev);
diff --git a/include/linux/mmc/cd-gpio.h b/include/linux/mmc/slot-gpio.h
similarity index 68%
rename from include/linux/mmc/cd-gpio.h
rename to include/linux/mmc/slot-gpio.h
index cefaba0..edfaa32 100644
--- a/include/linux/mmc/cd-gpio.h
+++ b/include/linux/mmc/slot-gpio.h
@@ -8,11 +8,11 @@
  * published by the Free Software Foundation.
  */
 
-#ifndef MMC_CD_GPIO_H
-#define MMC_CD_GPIO_H
+#ifndef MMC_SLOT_GPIO_H
+#define MMC_SLOT_GPIO_H
 
 struct mmc_host;
-int mmc_cd_gpio_request(struct mmc_host *host, unsigned int gpio);
-void mmc_cd_gpio_free(struct mmc_host *host);
+int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio);
+void mmc_gpio_free_cd(struct mmc_host *host);
 
 #endif
-- 
1.7.2.5

