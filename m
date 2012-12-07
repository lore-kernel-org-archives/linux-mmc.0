From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 1/2] mmc: slot-gpio: use devm_* managed functions to ease users
Date: Fri,  7 Dec 2012 21:32:47 +0800
Message-ID: <1354887168-3073-1-git-send-email-shawn.guo@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:43498 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030354Ab2LGNdN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Dec 2012 08:33:13 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so213931dak.19
        for <linux-mmc@vger.kernel.org>; Fri, 07 Dec 2012 05:33:13 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>

Use devm_* managed functions, so that slot-gpio users do not have to
call mmc_gpio_free_ro/cd to free up resources requested in
mmc_gpio_request_ro/cd.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mmc/core/slot-gpio.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index 16a1c0b..8b55748 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -106,7 +106,8 @@ int mmc_gpio_request_ro(struct mmc_host *host, unsigned int gpio)
 
 	ctx = host->slot.handler_priv;
 
-	ret = gpio_request_one(gpio, GPIOF_DIR_IN, ctx->ro_label);
+	ret = devm_gpio_request_one(&host->class_dev, gpio, GPIOF_DIR_IN,
+				    ctx->ro_label);
 	if (ret < 0)
 		return ret;
 
@@ -128,7 +129,8 @@ int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio)
 
 	ctx = host->slot.handler_priv;
 
-	ret = gpio_request_one(gpio, GPIOF_DIR_IN, ctx->cd_label);
+	ret = devm_gpio_request_one(&host->class_dev, gpio, GPIOF_DIR_IN,
+				    ctx->cd_label);
 	if (ret < 0)
 		/*
 		 * don't bother freeing memory. It might still get used by other
@@ -146,7 +148,8 @@ int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio)
 		irq = -EINVAL;
 
 	if (irq >= 0) {
-		ret = request_threaded_irq(irq, NULL, mmc_gpio_cd_irqt,
+		ret = devm_request_threaded_irq(&host->class_dev, irq,
+			NULL, mmc_gpio_cd_irqt,
 			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 			ctx->cd_label, host);
 		if (ret < 0)
@@ -175,7 +178,7 @@ void mmc_gpio_free_ro(struct mmc_host *host)
 	gpio = ctx->ro_gpio;
 	ctx->ro_gpio = -EINVAL;
 
-	gpio_free(gpio);
+	devm_gpio_free(&host->class_dev, gpio);
 }
 EXPORT_SYMBOL(mmc_gpio_free_ro);
 
@@ -188,13 +191,13 @@ void mmc_gpio_free_cd(struct mmc_host *host)
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

