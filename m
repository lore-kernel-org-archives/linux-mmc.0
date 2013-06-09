From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/6] mmc: jz4740: Use slot-gpio helpers
Date: Sun,  9 Jun 2013 21:10:04 +0200
Message-ID: <1370805005-8104-5-git-send-email-lars@metafoo.de>
References: <1370805005-8104-1-git-send-email-lars@metafoo.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp-out-250.synserver.de ([212.40.185.250]:1027 "EHLO
	smtp-out-250.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511Ab3FITG5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 9 Jun 2013 15:06:57 -0400
In-Reply-To: <1370805005-8104-1-git-send-email-lars@metafoo.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Paul Cercueil <paul@crapouillou.net>, Maarten ter Huurne <maarten@treewalker.org>, linux-mmc@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>

Use the slot-gpio helpers to handle the write protect and card detect GPIO pins
instead of re-implementing the same functionality in the driver.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/mmc/host/jz4740_mmc.c | 113 +++++++++---------------------------------
 1 file changed, 23 insertions(+), 90 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index c97ef6d..e904e6e 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -14,6 +14,7 @@
  */
 
 #include <linux/mmc/host.h>
+#include <linux/mmc/slot-gpio.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/irq.h>
@@ -653,35 +654,6 @@ static void jz4740_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	}
 }
 
-static int jz4740_mmc_get_ro(struct mmc_host *mmc)
-{
-	struct jz4740_mmc_host *host = mmc_priv(mmc);
-	if (!gpio_is_valid(host->pdata->gpio_read_only))
-		return -ENOSYS;
-
-	return gpio_get_value(host->pdata->gpio_read_only) ^
-		host->pdata->read_only_active_low;
-}
-
-static int jz4740_mmc_get_cd(struct mmc_host *mmc)
-{
-	struct jz4740_mmc_host *host = mmc_priv(mmc);
-	if (!gpio_is_valid(host->pdata->gpio_card_detect))
-		return -ENOSYS;
-
-	return gpio_get_value(host->pdata->gpio_card_detect) ^
-			host->pdata->card_detect_active_low;
-}
-
-static irqreturn_t jz4740_mmc_card_detect_irq(int irq, void *devid)
-{
-	struct jz4740_mmc_host *host = devid;
-
-	mmc_detect_change(host->mmc, HZ / 2);
-
-	return IRQ_HANDLED;
-}
-
 static void jz4740_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
 {
 	struct jz4740_mmc_host *host = mmc_priv(mmc);
@@ -691,8 +663,8 @@ static void jz4740_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
 static const struct mmc_host_ops jz4740_mmc_ops = {
 	.request	= jz4740_mmc_request,
 	.set_ios	= jz4740_mmc_set_ios,
-	.get_ro		= jz4740_mmc_get_ro,
-	.get_cd		= jz4740_mmc_get_cd,
+	.get_ro		= mmc_gpio_get_ro,
+	.get_cd		= mmc_gpio_get_cd,
 	.enable_sdio_irq = jz4740_mmc_enable_sdio_irq,
 };
 
@@ -727,58 +699,34 @@ static int jz4740_mmc_request_gpio(struct device *dev, int gpio,
 	return 0;
 }
 
-static int jz4740_mmc_request_gpios(struct platform_device *pdev)
+static int jz4740_mmc_request_gpios(struct mmc_host *mmc,
+	struct platform_device *pdev)
 {
-	int ret;
 	struct jz4740_mmc_platform_data *pdata = pdev->dev.platform_data;
+	int ret = 0;
 
 	if (!pdata)
 		return 0;
 
-	ret = jz4740_mmc_request_gpio(&pdev->dev, pdata->gpio_card_detect,
-			"MMC detect change", false, 0);
-	if (ret)
-		goto err;
-
-	ret = jz4740_mmc_request_gpio(&pdev->dev, pdata->gpio_read_only,
-			"MMC read only", false, 0);
-	if (ret)
-		goto err_free_gpio_card_detect;
+	if (!pdata->card_detect_active_low)
+		mmc->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
+	if (!pdata->read_only_active_low)
+		mmc->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
 
-	ret = jz4740_mmc_request_gpio(&pdev->dev, pdata->gpio_power,
-			"MMC read only", true, pdata->power_active_low);
-	if (ret)
-		goto err_free_gpio_read_only;
-
-	return 0;
-
-err_free_gpio_read_only:
-	if (gpio_is_valid(pdata->gpio_read_only))
-		gpio_free(pdata->gpio_read_only);
-err_free_gpio_card_detect:
-	if (gpio_is_valid(pdata->gpio_card_detect))
-		gpio_free(pdata->gpio_card_detect);
-err:
-	return ret;
-}
-
-static int jz4740_mmc_request_cd_irq(struct platform_device *pdev,
-	struct jz4740_mmc_host *host)
-{
-	struct jz4740_mmc_platform_data *pdata = pdev->dev.platform_data;
-
-	if (!gpio_is_valid(pdata->gpio_card_detect))
-		return 0;
+	if (gpio_is_valid(pdata->gpio_card_detect)) {
+		ret = mmc_gpio_request_cd(mmc, pdata->gpio_card_detect);
+		if (ret)
+			return ret;
+	}
 
-	host->card_detect_irq = gpio_to_irq(pdata->gpio_card_detect);
-	if (host->card_detect_irq < 0) {
-		dev_warn(&pdev->dev, "Failed to get card detect irq\n");
-		return 0;
+	if (gpio_is_valid(pdata->gpio_read_only)) {
+		ret = mmc_gpio_request_ro(mmc, pdata->gpio_read_only);
+		if (ret)
+			return ret;
 	}
 
-	return request_irq(host->card_detect_irq, jz4740_mmc_card_detect_irq,
-			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-			"MMC card detect", host);
+	return jz4740_mmc_request_gpio(&pdev->dev, pdata->gpio_power,
+			"MMC read only", true, pdata->power_active_low);
 }
 
 static void jz4740_mmc_free_gpios(struct platform_device *pdev)
@@ -790,10 +738,6 @@ static void jz4740_mmc_free_gpios(struct platform_device *pdev)
 
 	if (gpio_is_valid(pdata->gpio_power))
 		gpio_free(pdata->gpio_power);
-	if (gpio_is_valid(pdata->gpio_read_only))
-		gpio_free(pdata->gpio_read_only);
-	if (gpio_is_valid(pdata->gpio_card_detect))
-		gpio_free(pdata->gpio_card_detect);
 }
 
 static inline size_t jz4740_mmc_num_pins(struct jz4740_mmc_host *host)
@@ -865,7 +809,7 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 		goto err_iounmap;
 	}
 
-	ret = jz4740_mmc_request_gpios(pdev);
+	ret = jz4740_mmc_request_gpios(mmc, pdev);
 	if (ret)
 		goto err_gpio_bulk_free;
 
@@ -888,17 +832,11 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 	spin_lock_init(&host->lock);
 	host->irq_mask = 0xffff;
 
-	ret = jz4740_mmc_request_cd_irq(pdev, host);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to request card detect irq\n");
-		goto err_free_gpios;
-	}
-
 	ret = request_threaded_irq(host->irq, jz_mmc_irq, jz_mmc_irq_worker, 0,
 			dev_name(&pdev->dev), host);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to request irq: %d\n", ret);
-		goto err_free_card_detect_irq;
+		goto err_free_gpios;
 	}
 
 	jz4740_mmc_reset(host);
@@ -921,9 +859,6 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 
 err_free_irq:
 	free_irq(host->irq, host);
-err_free_card_detect_irq:
-	if (host->card_detect_irq >= 0)
-		free_irq(host->card_detect_irq, host);
 err_free_gpios:
 	jz4740_mmc_free_gpios(pdev);
 err_gpio_bulk_free:
@@ -951,8 +886,6 @@ static int jz4740_mmc_remove(struct platform_device *pdev)
 	mmc_remove_host(host->mmc);
 
 	free_irq(host->irq, host);
-	if (host->card_detect_irq >= 0)
-		free_irq(host->card_detect_irq, host);
 
 	jz4740_mmc_free_gpios(pdev);
 	jz_gpio_bulk_free(jz4740_mmc_pins, jz4740_mmc_num_pins(host));
-- 
1.8.2.1

