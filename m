From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 20/29] mmc: add CD GPIO polling support to slot functions
Date: Thu,  3 May 2012 17:05:49 +0200
Message-ID: <1336057558-11031-21-git-send-email-g.liakhovetski@gmx.de>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:65339 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757400Ab2ECPGD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 3 May 2012 11:06:03 -0400
In-Reply-To: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org

A simple extension of mmc slot functions add support for CD GPIO polling
for cases, where the GPIO cannot produce interrupts or this is for some
reason not desired.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/core/slot-gpio.c  |   42 +++++++++++++++++++++++++++++-----------
 include/linux/mmc/slot-gpio.h |    2 +
 2 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index 11a8ef1..1491fd8 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
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
+		!(host->caps2 & MMC_CAP2_INVERTED_CD);
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
@@ -49,20 +58,25 @@ int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio)
 	if (ret < 0)
 		goto egpioreq;
 
-	ret = request_threaded_irq(irq, NULL, mmc_gpio_cd_irqt,
-				   IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-				   ctx->cd_label, host);
-	if (ret < 0)
-		goto eirqreq;
+	/*
+	 * Even if gpio_to_irq() returns a valid IRQ number, the platform might
+	 * still prefer to poll, e.g., because that IRQ number is already used
+	 * by another unit and cannot be shared.
+	 */
+	if (host->caps & MMC_CAP_NEEDS_POLL || irq < 0) {
+		host->caps |= MMC_CAP_NEEDS_POLL;
+		host->slot.cd_irq = -EINVAL;
+	} else if (!request_threaded_irq(irq, NULL, mmc_gpio_cd_irqt,
+				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+				ctx->cd_label, host)) {
+		host->slot.cd_irq = irq;
+	}
 
 	ctx->cd_gpio = gpio;
-	host->slot.cd_irq = irq;
 	host->slot.handler_priv = ctx;
 
 	return 0;
 
-eirqreq:
-	gpio_free(gpio);
 egpioreq:
 	kfree(ctx);
 	return ret;
@@ -76,8 +90,12 @@ void mmc_gpio_free_cd(struct mmc_host *host)
 	if (!ctx)
 		return;
 
-	free_irq(host->slot.cd_irq, host);
+	if (host->slot.cd_irq >= 0) {
+		free_irq(host->slot.cd_irq, host);
+		host->slot.cd_irq = -EINVAL;
+	}
 	gpio_free(ctx->cd_gpio);
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

