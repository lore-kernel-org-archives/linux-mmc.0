From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 2/9] mmc: omap_hsmmc: use devm_request_irq
Date: Fri, 21 Mar 2014 21:47:31 +0530
Message-ID: <1395418658-2375-3-git-send-email-balajitk@ti.com>
References: <1395404448-30030-2-git-send-email-afenkart@gmail.com>
 <1395418658-2375-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1395418658-2375-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, chris@printf.net
Cc: linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

With devm_request_irq conversion free_irq can be removed in clean up path

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 578e983..4a3bb4b 100644
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

