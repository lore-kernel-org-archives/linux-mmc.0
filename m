From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 1/3] mmc: slot-gpio: use devm_* managed functions to ease users
Date: Tue, 11 Dec 2012 22:32:18 +0800
Message-ID: <1355236340-21304-2-git-send-email-shawn.guo@linaro.org>
References: <1355236340-21304-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe003.messaging.microsoft.com ([216.32.180.186]:43299
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753114Ab2LKOdX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Dec 2012 09:33:23 -0500
In-Reply-To: <1355236340-21304-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>

Use devm_* managed functions, so that slot-gpio users do not have to
call mmc_gpio_free_ro/cd to free up resources requested in
mmc_gpio_request_ro/cd.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mmc/core/slot-gpio.c |   57 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 51 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index 16a1c0b..3242351 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -92,6 +92,20 @@ int mmc_gpio_get_cd(struct mmc_host *host)
 }
 EXPORT_SYMBOL(mmc_gpio_get_cd);
 
+/**
+ * mmc_gpio_request_ro - request a gpio for write-protection
+ * @host: mmc host
+ * @gpio: gpio number requested
+ *
+ * As devm_* managed functions are used in mmc_gpio_request_ro(), client
+ * drivers do not need to explicitly call mmc_gpio_free_ro() for freeing up,
+ * if the requesting and freeing are only needed at probing and unbinding time
+ * for once.  However, if client drivers do something special like runtime
+ * switching for write-protection, they are responsible for calling
+ * mmc_gpio_request_ro() and mmc_gpio_free_ro() as a pair on their own.
+ *
+ * Returns zero on success, else an error.
+ */
 int mmc_gpio_request_ro(struct mmc_host *host, unsigned int gpio)
 {
 	struct mmc_gpio *ctx;
@@ -106,7 +120,8 @@ int mmc_gpio_request_ro(struct mmc_host *host, unsigned int gpio)
 
 	ctx = host->slot.handler_priv;
 
-	ret = gpio_request_one(gpio, GPIOF_DIR_IN, ctx->ro_label);
+	ret = devm_gpio_request_one(&host->class_dev, gpio, GPIOF_DIR_IN,
+				    ctx->ro_label);
 	if (ret < 0)
 		return ret;
 
@@ -116,6 +131,20 @@ int mmc_gpio_request_ro(struct mmc_host *host, unsigned int gpio)
 }
 EXPORT_SYMBOL(mmc_gpio_request_ro);
 
+/**
+ * mmc_gpio_request_cd - request a gpio for card-detection
+ * @host: mmc host
+ * @gpio: gpio number requested
+ *
+ * As devm_* managed functions are used in mmc_gpio_request_cd(), client
+ * drivers do not need to explicitly call mmc_gpio_free_cd() for freeing up,
+ * if the requesting and freeing are only needed at probing and unbinding time
+ * for once.  However, if client drivers do something special like runtime
+ * switching for card-detection, they are responsible for calling
+ * mmc_gpio_request_cd() and mmc_gpio_free_cd() as a pair on their own.
+ *
+ * Returns zero on success, else an error.
+ */
 int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio)
 {
 	struct mmc_gpio *ctx;
@@ -128,7 +157,8 @@ int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio)
 
 	ctx = host->slot.handler_priv;
 
-	ret = gpio_request_one(gpio, GPIOF_DIR_IN, ctx->cd_label);
+	ret = devm_gpio_request_one(&host->class_dev, gpio, GPIOF_DIR_IN,
+				    ctx->cd_label);
 	if (ret < 0)
 		/*
 		 * don't bother freeing memory. It might still get used by other
@@ -146,7 +176,8 @@ int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio)
 		irq = -EINVAL;
 
 	if (irq >= 0) {
-		ret = request_threaded_irq(irq, NULL, mmc_gpio_cd_irqt,
+		ret = devm_request_threaded_irq(&host->class_dev, irq,
+			NULL, mmc_gpio_cd_irqt,
 			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 			ctx->cd_label, host);
 		if (ret < 0)
@@ -164,6 +195,13 @@ int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio)
 }
 EXPORT_SYMBOL(mmc_gpio_request_cd);
 
+/**
+ * mmc_gpio_free_ro - free the write-protection gpio
+ * @host: mmc host
+ *
+ * It's provided only for cases that client drivers need to manually free
+ * up the write-protection gpio requested by mmc_gpio_request_ro().
+ */
 void mmc_gpio_free_ro(struct mmc_host *host)
 {
 	struct mmc_gpio *ctx = host->slot.handler_priv;
@@ -175,10 +213,17 @@ void mmc_gpio_free_ro(struct mmc_host *host)
 	gpio = ctx->ro_gpio;
 	ctx->ro_gpio = -EINVAL;
 
-	gpio_free(gpio);
+	devm_gpio_free(&host->class_dev, gpio);
 }
 EXPORT_SYMBOL(mmc_gpio_free_ro);
 
+/**
+ * mmc_gpio_free_cd - free the card-detection gpio
+ * @host: mmc host
+ *
+ * It's provided only for cases that client drivers need to manually free
+ * up the card-detection gpio requested by mmc_gpio_request_cd().
+ */
 void mmc_gpio_free_cd(struct mmc_host *host)
 {
 	struct mmc_gpio *ctx = host->slot.handler_priv;
@@ -188,13 +233,13 @@ void mmc_gpio_free_cd(struct mmc_host *host)
 		return;
 
 	if (host->slot.cd_irq >= 0) {
-		free_irq(host->slot.cd_irq, host);
+		devm_free_irq(&host->class_dev, host->slot.cd_irq, host);
 		host->slot.cd_irq = -EINVAL;
 	}
 
 	gpio = ctx->cd_gpio;
 	ctx->cd_gpio = -EINVAL;
 
-	gpio_free(gpio);
+	devm_gpio_free(&host->class_dev, gpio);
 }
 EXPORT_SYMBOL(mmc_gpio_free_cd);
-- 
1.7.9.5


