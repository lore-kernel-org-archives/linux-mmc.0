From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 1/6] mmc: slot-gpio: Record GPIO descriptors instead of GPIO numbers
Date: Mon, 10 Mar 2014 15:02:39 +0200
Message-ID: <1394456564-13783-2-git-send-email-adrian.hunter@intel.com>
References: <1394456564-13783-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:13578 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753198AbaCJNEH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 10 Mar 2014 09:04:07 -0400
In-Reply-To: <1394456564-13783-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

In preparation for adding a descriptor-based CD GPIO
API, switch from recording GPIO numbers to recording
GPIO descriptors.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/slot-gpio.c | 45 ++++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index 46596b71..86547a2 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -10,6 +10,7 @@
 
 #include <linux/err.h>
 #include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/jiffies.h>
 #include <linux/mmc/host.h>
@@ -18,8 +19,10 @@
 #include <linux/slab.h>
 
 struct mmc_gpio {
-	int ro_gpio;
-	int cd_gpio;
+	struct gpio_desc *ro_gpio;
+	struct gpio_desc *cd_gpio;
+	bool override_ro_active_level;
+	bool override_cd_active_level;
 	char *ro_label;
 	char cd_label[0];
 };
@@ -57,8 +60,6 @@ static int mmc_gpio_alloc(struct mmc_host *host)
 			ctx->ro_label = ctx->cd_label + len;
 			snprintf(ctx->cd_label, len, "%s cd", dev_name(host->parent));
 			snprintf(ctx->ro_label, len, "%s ro", dev_name(host->parent));
-			ctx->cd_gpio = -EINVAL;
-			ctx->ro_gpio = -EINVAL;
 			host->slot.handler_priv = ctx;
 		}
 	}
@@ -72,11 +73,14 @@ int mmc_gpio_get_ro(struct mmc_host *host)
 {
 	struct mmc_gpio *ctx = host->slot.handler_priv;
 
-	if (!ctx || !gpio_is_valid(ctx->ro_gpio))
+	if (!ctx || !ctx->ro_gpio)
 		return -ENOSYS;
 
-	return !gpio_get_value_cansleep(ctx->ro_gpio) ^
-		!!(host->caps2 & MMC_CAP2_RO_ACTIVE_HIGH);
+	if (ctx->override_ro_active_level)
+		return !gpiod_get_raw_value_cansleep(ctx->ro_gpio) ^
+			!!(host->caps2 & MMC_CAP2_RO_ACTIVE_HIGH);
+
+	return gpiod_get_value_cansleep(ctx->ro_gpio);
 }
 EXPORT_SYMBOL(mmc_gpio_get_ro);
 
@@ -84,11 +88,14 @@ int mmc_gpio_get_cd(struct mmc_host *host)
 {
 	struct mmc_gpio *ctx = host->slot.handler_priv;
 
-	if (!ctx || !gpio_is_valid(ctx->cd_gpio))
+	if (!ctx || !ctx->cd_gpio)
 		return -ENOSYS;
 
-	return !gpio_get_value_cansleep(ctx->cd_gpio) ^
-		!!(host->caps2 & MMC_CAP2_CD_ACTIVE_HIGH);
+	if (ctx->override_cd_active_level)
+		return !gpiod_get_raw_value_cansleep(ctx->cd_gpio) ^
+			!!(host->caps2 & MMC_CAP2_CD_ACTIVE_HIGH);
+
+	return gpiod_get_value_cansleep(ctx->cd_gpio);
 }
 EXPORT_SYMBOL(mmc_gpio_get_cd);
 
@@ -125,7 +132,8 @@ int mmc_gpio_request_ro(struct mmc_host *host, unsigned int gpio)
 	if (ret < 0)
 		return ret;
 
-	ctx->ro_gpio = gpio;
+	ctx->override_ro_active_level = true;
+	ctx->ro_gpio = gpio_to_desc(gpio);
 
 	return 0;
 }
@@ -201,7 +209,8 @@ int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio,
 	if (irq < 0)
 		host->caps |= MMC_CAP_NEEDS_POLL;
 
-	ctx->cd_gpio = gpio;
+	ctx->override_cd_active_level = true;
+	ctx->cd_gpio = gpio_to_desc(gpio);
 
 	return 0;
 }
@@ -219,11 +228,11 @@ void mmc_gpio_free_ro(struct mmc_host *host)
 	struct mmc_gpio *ctx = host->slot.handler_priv;
 	int gpio;
 
-	if (!ctx || !gpio_is_valid(ctx->ro_gpio))
+	if (!ctx || !ctx->ro_gpio)
 		return;
 
-	gpio = ctx->ro_gpio;
-	ctx->ro_gpio = -EINVAL;
+	gpio = desc_to_gpio(ctx->ro_gpio);
+	ctx->ro_gpio = NULL;
 
 	devm_gpio_free(&host->class_dev, gpio);
 }
@@ -241,7 +250,7 @@ void mmc_gpio_free_cd(struct mmc_host *host)
 	struct mmc_gpio *ctx = host->slot.handler_priv;
 	int gpio;
 
-	if (!ctx || !gpio_is_valid(ctx->cd_gpio))
+	if (!ctx || !ctx->cd_gpio)
 		return;
 
 	if (host->slot.cd_irq >= 0) {
@@ -249,8 +258,8 @@ void mmc_gpio_free_cd(struct mmc_host *host)
 		host->slot.cd_irq = -EINVAL;
 	}
 
-	gpio = ctx->cd_gpio;
-	ctx->cd_gpio = -EINVAL;
+	gpio = desc_to_gpio(ctx->cd_gpio);
+	ctx->cd_gpio = NULL;
 
 	devm_gpio_free(&host->class_dev, gpio);
 }
-- 
1.8.3.2

