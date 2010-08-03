From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] MMC: jz4740: Fixed card change detection.
Date: Tue,  3 Aug 2010 18:32:44 +0200
Message-ID: <1280853164-19900-1-git-send-email-lars@metafoo.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp-out-105.synserver.de ([212.40.180.105]:1250 "EHLO
	smtp-out-103.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755880Ab0HCQdJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Aug 2010 12:33:09 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, linux-mmc@vger.kernel.org, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>

From: Maarten ter Huurne <maarten@treewalker.org>

The GPIO validity check was reversed.
Also removed some dead code.

Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/mmc/host/jz4740_mmc.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 12efd9c..ad4f987 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -761,24 +761,20 @@ err:
 static int __devinit jz4740_mmc_request_cd_irq(struct platform_device *pdev,
 	struct jz4740_mmc_host *host)
 {
-	int ret;
 	struct jz4740_mmc_platform_data *pdata = pdev->dev.platform_data;
 
-	if (gpio_is_valid(pdata->gpio_card_detect))
+	if (!gpio_is_valid(pdata->gpio_card_detect))
 		return 0;
 
 	host->card_detect_irq = gpio_to_irq(pdata->gpio_card_detect);
-
 	if (host->card_detect_irq < 0) {
 		dev_warn(&pdev->dev, "Failed to get card detect irq\n");
 		return 0;
 	}
+
 	return request_irq(host->card_detect_irq, jz4740_mmc_card_detect_irq,
 			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 			"MMC card detect", host);
-
-
-	return ret;
 }
 
 static void jz4740_mmc_free_gpios(struct platform_device *pdev)
-- 
1.5.6.5

