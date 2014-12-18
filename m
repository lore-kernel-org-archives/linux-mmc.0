From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4/7] mmc: slot-gpio: Use the parent device while allocating data
Date: Thu, 18 Dec 2014 15:44:33 +0100
Message-ID: <1418913876-13937-5-git-send-email-ulf.hansson@linaro.org>
References: <1418913876-13937-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:37363 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833AbaLROow (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Dec 2014 09:44:52 -0500
Received: by mail-wg0-f50.google.com with SMTP id a1so1820757wgh.23
        for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2014 06:44:51 -0800 (PST)
In-Reply-To: <1418913876-13937-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>

We had a mix of using the class device and the parent device while
allocating data through the devm_* managed functions.

Let's be more consistent and always use the parent device.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/slot-gpio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index a428f10..f9a0c6e 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -52,7 +52,7 @@ static int mmc_gpio_alloc(struct mmc_host *host)
 		 * before device_add(), i.e., between mmc_alloc_host() and
 		 * mmc_add_host()
 		 */
-		ctx = devm_kzalloc(&host->class_dev, sizeof(*ctx) + 2 * len,
+		ctx = devm_kzalloc(host->parent, sizeof(*ctx) + 2 * len,
 				   GFP_KERNEL);
 		if (ctx) {
 			ctx->ro_label = ctx->cd_label + len;
@@ -121,7 +121,7 @@ int mmc_gpio_request_ro(struct mmc_host *host, unsigned int gpio)
 
 	ctx = host->slot.handler_priv;
 
-	ret = devm_gpio_request_one(&host->class_dev, gpio, GPIOF_DIR_IN,
+	ret = devm_gpio_request_one(host->parent, gpio, GPIOF_DIR_IN,
 				    ctx->ro_label);
 	if (ret < 0)
 		return ret;
@@ -152,7 +152,7 @@ void mmc_gpiod_request_cd_irq(struct mmc_host *host)
 		irq = -EINVAL;
 
 	if (irq >= 0) {
-		ret = devm_request_threaded_irq(&host->class_dev, irq,
+		ret = devm_request_threaded_irq(host->parent, irq,
 			NULL, mmc_gpio_cd_irqt,
 			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 			ctx->cd_label, host);
@@ -194,7 +194,7 @@ int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio,
 
 	ctx = host->slot.handler_priv;
 
-	ret = devm_gpio_request_one(&host->class_dev, gpio, GPIOF_DIR_IN,
+	ret = devm_gpio_request_one(host->parent, gpio, GPIOF_DIR_IN,
 				    ctx->cd_label);
 	if (ret < 0)
 		/*
-- 
1.9.1

