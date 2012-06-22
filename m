From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 4/9 v4] mmc: add CD GPIO polling support to slot functions
Date: Fri, 22 Jun 2012 15:23:17 +0200
Message-ID: <1340371402-4801-5-git-send-email-g.liakhovetski@gmx.de>
References: <1340371402-4801-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:56410 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762097Ab2FVNXa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Jun 2012 09:23:30 -0400
In-Reply-To: <1340371402-4801-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>

A simple extension of mmc slot functions add support for CD GPIO polling
for cases, where the GPIO cannot produce interrupts or this is for some
reason not desired.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v4:

1. gpio variables are now signed
2. take care to mark gpio variables as invalid in hotplug context
3. MMC_CAP2_*_ACTIVE_HIGH inverted compared to v3

 drivers/mmc/core/slot-gpio.c  |   56 +++++++++++++++++++++++++++++++---------
 include/linux/mmc/slot-gpio.h |    2 +
 2 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index 468e5a0..92cba02 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -18,7 +18,7 @@
 #include <linux/slab.h>
 
 struct mmc_gpio {
-	unsigned int cd_gpio;
+	int cd_gpio;
 	char cd_label[0];
 };
 
@@ -29,6 +29,18 @@ static irqreturn_t mmc_gpio_cd_irqt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+int mmc_gpio_get_cd(struct mmc_host *host)
+{
+	struct mmc_gpio *ctx = host->slot.handler_priv;
+
+	if (!ctx || !gpio_is_valid(ctx->cd_gpio))
+		return -ENOSYS;
+
+	return !gpio_get_value_cansleep(ctx->cd_gpio) ^
+		!!(host->caps2 & MMC_CAP2_CD_ACTIVE_HIGH);
+}
+EXPORT_SYMBOL(mmc_gpio_get_cd);
+
 int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio)
 {
 	size_t len = strlen(dev_name(host->parent)) + 4;
@@ -36,9 +48,6 @@ int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio)
 	int irq = gpio_to_irq(gpio);
 	int ret;
 
-	if (irq < 0)
-		return irq;
-
 	ctx = kmalloc(sizeof(*ctx) + len, GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
@@ -49,20 +58,32 @@ int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio)
 	if (ret < 0)
 		goto egpioreq;
 
-	ret = request_threaded_irq(irq, NULL, mmc_gpio_cd_irqt,
+	/*
+	 * Even if gpio_to_irq() returns a valid IRQ number, the platform might
+	 * still prefer to poll, e.g., because that IRQ number is already used
+	 * by another unit and cannot be shared.
+	 */
+	if (irq >= 0 && host->caps & MMC_CAP_NEEDS_POLL)
+		irq = -EINVAL;
+
+	if (irq >= 0) {
+		ret = request_threaded_irq(irq, NULL, mmc_gpio_cd_irqt,
 			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 			ctx->cd_label, host);
-	if (ret < 0)
-		goto eirqreq;
+		if (ret < 0)
+			irq = ret;
+	}
 
-	ctx->cd_gpio = gpio;
 	host->slot.cd_irq = irq;
+
+	if (irq < 0)
+		host->caps |= MMC_CAP_NEEDS_POLL;
+
+	ctx->cd_gpio = gpio;
 	host->slot.handler_priv = ctx;
 
 	return 0;
 
-eirqreq:
-	gpio_free(gpio);
 egpioreq:
 	kfree(ctx);
 	return ret;
@@ -72,12 +93,21 @@ EXPORT_SYMBOL(mmc_gpio_request_cd);
 void mmc_gpio_free_cd(struct mmc_host *host)
 {
 	struct mmc_gpio *ctx = host->slot.handler_priv;
+	int gpio;
 
-	if (!ctx)
+	if (!ctx || !gpio_is_valid(ctx->cd_gpio))
 		return;
 
-	free_irq(host->slot.cd_irq, host);
-	gpio_free(ctx->cd_gpio);
+	if (host->slot.cd_irq >= 0) {
+		free_irq(host->slot.cd_irq, host);
+		host->slot.cd_irq = -EINVAL;
+	}
+
+	gpio = ctx->cd_gpio;
+	ctx->cd_gpio = -EINVAL;
+
+	gpio_free(gpio);
+	host->slot.handler_priv = NULL;
 	kfree(ctx);
 }
 EXPORT_SYMBOL(mmc_gpio_free_cd);
diff --git a/include/linux/mmc/slot-gpio.h b/include/linux/mmc/slot-gpio.h
index edfaa32..1a977d7 100644
--- a/include/linux/mmc/slot-gpio.h
+++ b/include/linux/mmc/slot-gpio.h
@@ -12,6 +12,8 @@
 #define MMC_SLOT_GPIO_H
 
 struct mmc_host;
+
+int mmc_gpio_get_cd(struct mmc_host *host);
 int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio);
 void mmc_gpio_free_cd(struct mmc_host *host);
 
-- 
1.7.2.5

