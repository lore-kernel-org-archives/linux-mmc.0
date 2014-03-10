From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 2/6] mmc: slot-gpio: Split out CD IRQ request into a separate function
Date: Mon, 10 Mar 2014 15:02:40 +0200
Message-ID: <1394456564-13783-3-git-send-email-adrian.hunter@intel.com>
References: <1394456564-13783-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:52656 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753247AbaCJNEH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 10 Mar 2014 09:04:07 -0400
In-Reply-To: <1394456564-13783-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

In preparation for adding a descriptor-based CD GPIO
API, split out CD IRQ request into a separate function.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/slot-gpio.c | 58 ++++++++++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index 86547a2..47fa07e 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -139,6 +139,39 @@ int mmc_gpio_request_ro(struct mmc_host *host, unsigned int gpio)
 }
 EXPORT_SYMBOL(mmc_gpio_request_ro);
 
+static void mmc_gpiod_request_cd_irq(struct mmc_host *host)
+{
+	struct mmc_gpio *ctx = host->slot.handler_priv;
+	int ret, irq;
+
+	if (host->slot.cd_irq >= 0 || !ctx || !ctx->cd_gpio)
+		return;
+
+	irq = gpiod_to_irq(ctx->cd_gpio);
+
+	/*
+	 * Even if gpiod_to_irq() returns a valid IRQ number, the platform might
+	 * still prefer to poll, e.g., because that IRQ number is already used
+	 * by another unit and cannot be shared.
+	 */
+	if (irq >= 0 && host->caps & MMC_CAP_NEEDS_POLL)
+		irq = -EINVAL;
+
+	if (irq >= 0) {
+		ret = devm_request_threaded_irq(&host->class_dev, irq,
+			NULL, mmc_gpio_cd_irqt,
+			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+			ctx->cd_label, host);
+		if (ret < 0)
+			irq = ret;
+	}
+
+	host->slot.cd_irq = irq;
+
+	if (irq < 0)
+		host->caps |= MMC_CAP_NEEDS_POLL;
+}
+
 /**
  * mmc_gpio_request_cd - request a gpio for card-detection
  * @host: mmc host
@@ -162,7 +195,6 @@ int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio,
 			unsigned int debounce)
 {
 	struct mmc_gpio *ctx;
-	int irq = gpio_to_irq(gpio);
 	int ret;
 
 	ret = mmc_gpio_alloc(host);
@@ -187,31 +219,11 @@ int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio,
 			return ret;
 	}
 
-	/*
-	 * Even if gpio_to_irq() returns a valid IRQ number, the platform might
-	 * still prefer to poll, e.g., because that IRQ number is already used
-	 * by another unit and cannot be shared.
-	 */
-	if (irq >= 0 && host->caps & MMC_CAP_NEEDS_POLL)
-		irq = -EINVAL;
-
-	if (irq >= 0) {
-		ret = devm_request_threaded_irq(&host->class_dev, irq,
-			NULL, mmc_gpio_cd_irqt,
-			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-			ctx->cd_label, host);
-		if (ret < 0)
-			irq = ret;
-	}
-
-	host->slot.cd_irq = irq;
-
-	if (irq < 0)
-		host->caps |= MMC_CAP_NEEDS_POLL;
-
 	ctx->override_cd_active_level = true;
 	ctx->cd_gpio = gpio_to_desc(gpio);
 
+	mmc_gpiod_request_cd_irq(host);
+
 	return 0;
 }
 EXPORT_SYMBOL(mmc_gpio_request_cd);
-- 
1.8.3.2

