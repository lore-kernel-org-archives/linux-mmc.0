From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH V2 2/6] mmc: sh_mobile_sdhi: remove obsolete irq_by_name registration
Date: Tue, 26 Apr 2016 17:55:23 +0200
Message-ID: <1461686127-3217-3-git-send-email-wsa@the-dreams.de>
References: <1461686127-3217-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:51181 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752205AbcDZPzo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 26 Apr 2016 11:55:44 -0400
In-Reply-To: <1461686127-3217-1-git-send-email-wsa@the-dreams.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Ulf Hansson <ulf.hansson@linaro.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

There is no user left in the kernel, so this code can be removed.
(Legacy, non-DT sh_mobile boards have been removed a while ago.) The
diff looks more complicated than it is: The if-block for multiplexed isr
is now the main code path, the rest is removed.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c | 57 ++++++---------------------------------
 1 file changed, 8 insertions(+), 49 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 9beee48d2e280d..51d8dbd5b06a3e 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -28,7 +28,6 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/mmc/host.h>
-#include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/mfd/tmio.h>
 #include <linux/sh_dma.h>
 #include <linux/delay.h>
@@ -315,7 +314,6 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 	struct tmio_mmc_host *host;
 	struct resource *res;
 	int irq, ret, i = 0;
-	bool multiplexed_isr = true;
 	struct tmio_mmc_dma *dma_priv;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -405,62 +403,23 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto efree;
 
-	/*
-	 * Allow one or more specific (named) ISRs or
-	 * one or more multiplexed (un-named) ISRs.
-	 */
-
-	irq = platform_get_irq_byname(pdev, SH_MOBILE_SDHI_IRQ_CARD_DETECT);
-	if (irq >= 0) {
-		multiplexed_isr = false;
-		ret = devm_request_irq(&pdev->dev, irq, tmio_mmc_card_detect_irq, 0,
+	while (1) {
+		irq = platform_get_irq(pdev, i);
+		if (irq < 0)
+			break;
+		i++;
+		ret = devm_request_irq(&pdev->dev, irq, tmio_mmc_irq, 0,
 				  dev_name(&pdev->dev), host);
 		if (ret)
 			goto eirq;
 	}
 
-	irq = platform_get_irq_byname(pdev, SH_MOBILE_SDHI_IRQ_SDIO);
-	if (irq >= 0) {
-		multiplexed_isr = false;
-		ret = devm_request_irq(&pdev->dev, irq, tmio_mmc_sdio_irq, 0,
-				  dev_name(&pdev->dev), host);
-		if (ret)
-			goto eirq;
-	}
-
-	irq = platform_get_irq_byname(pdev, SH_MOBILE_SDHI_IRQ_SDCARD);
-	if (irq >= 0) {
-		multiplexed_isr = false;
-		ret = devm_request_irq(&pdev->dev, irq, tmio_mmc_sdcard_irq, 0,
-				  dev_name(&pdev->dev), host);
-		if (ret)
-			goto eirq;
-	} else if (!multiplexed_isr) {
-		dev_err(&pdev->dev,
-			"Principal SD-card IRQ is missing among named interrupts\n");
+	/* There must be at least one IRQ source */
+	if (!i) {
 		ret = irq;
 		goto eirq;
 	}
 
-	if (multiplexed_isr) {
-		while (1) {
-			irq = platform_get_irq(pdev, i);
-			if (irq < 0)
-				break;
-			i++;
-			ret = devm_request_irq(&pdev->dev, irq, tmio_mmc_irq, 0,
-					  dev_name(&pdev->dev), host);
-			if (ret)
-				goto eirq;
-		}
-
-		/* There must be at least one IRQ source */
-		if (!i) {
-			ret = irq;
-			goto eirq;
-		}
-	}
-
 	dev_info(&pdev->dev, "%s base at 0x%08lx max clock rate %u MHz\n",
 		 mmc_hostname(host->mmc), (unsigned long)
 		 (platform_get_resource(pdev, IORESOURCE_MEM, 0)->start),
-- 
2.7.0

