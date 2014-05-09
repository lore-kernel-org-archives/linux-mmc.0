From: Balaji T K <balajitk@ti.com>
Subject: [PATCH v2 2/6] mmc: omap_hsmmc: use devm_request_irq
Date: Fri, 9 May 2014 22:16:49 +0530
Message-ID: <1399654013-28262-3-git-send-email-balajitk@ti.com>
References: <1399654013-28262-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33555 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756834AbaEIQq6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 9 May 2014 12:46:58 -0400
In-Reply-To: <1399654013-28262-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org
Cc: linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>

With devm_request_irq conversion free_irq can be removed in clean up path

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index b8ae7ee..ef7e48a 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2017,7 +2017,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	}
 
 	/* Request IRQ for MMC operations */
-	ret = request_irq(host->irq, omap_hsmmc_irq, 0,
+	ret = devm_request_irq(&pdev->dev, host->irq, omap_hsmmc_irq, 0,
 			mmc_hostname(mmc), host);
 	if (ret) {
 		dev_err(mmc_dev(host->mmc), "Unable to grab HSMMC IRQ\n");
@@ -2028,7 +2028,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 		if (pdata->init(&pdev->dev) != 0) {
 			dev_err(mmc_dev(host->mmc),
 				"Unable to configure MMC IRQs\n");
-			goto err_irq_cd_init;
+			goto err_irq;
 		}
 	}
 
@@ -2095,8 +2095,6 @@ err_irq_cd:
 err_reg:
 	if (host->pdata->cleanup)
 		host->pdata->cleanup(&pdev->dev);
-err_irq_cd_init:
-	free_irq(host->irq, host);
 err_irq:
 	if (host->tx_chan)
 		dma_release_channel(host->tx_chan);
@@ -2129,7 +2127,6 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 		omap_hsmmc_reg_put(host);
 	if (host->pdata->cleanup)
 		host->pdata->cleanup(&pdev->dev);
-	free_irq(host->irq, host);
 	if (mmc_slot(host).card_detect_irq)
 		free_irq(mmc_slot(host).card_detect_irq, host);
 
-- 
1.7.5.4

