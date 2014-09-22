From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH 5/6] omap_hsmmc: remove un-initialized callbacks from platform data
Date: Mon, 22 Sep 2014 13:55:10 +0200
Message-ID: <1411386911-8158-6-git-send-email-afenkart@gmail.com>
References: <1411386911-8158-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:60513 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753674AbaIVLzh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Sep 2014 07:55:37 -0400
In-Reply-To: <1411386911-8158-1-git-send-email-afenkart@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Balaji T K <balajitk@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, pascal.huerst@gmail.com, Andreas Fenkart <afenkart@gmail.com>

Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
---
 drivers/mmc/host/omap_hsmmc.c            | 15 +--------------
 include/linux/platform_data/hsmmc-omap.h |  8 --------
 2 files changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 02f3438..465c34e 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2195,18 +2195,10 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 		goto err_irq;
 	}
 
-	if (pdata->init != NULL) {
-		if (pdata->init(&pdev->dev) != 0) {
-			dev_err(mmc_dev(host->mmc),
-				"Unable to configure MMC IRQs\n");
-			goto err_irq;
-		}
-	}
-
 	if (omap_hsmmc_have_reg() && !mmc_slot(host).set_power) {
 		ret = omap_hsmmc_reg_get(host);
 		if (ret)
-			goto err_reg;
+			goto err_irq;
 		host->use_reg = 1;
 	}
 
@@ -2269,9 +2261,6 @@ err_slot_name:
 err_irq_cd:
 	if (host->use_reg)
 		omap_hsmmc_reg_put(host);
-err_reg:
-	if (host->pdata->cleanup)
-		host->pdata->cleanup(&pdev->dev);
 err_irq:
 	if (host->tx_chan)
 		dma_release_channel(host->tx_chan);
@@ -2297,8 +2286,6 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 	mmc_remove_host(host->mmc);
 	if (host->use_reg)
 		omap_hsmmc_reg_put(host);
-	if (host->pdata->cleanup)
-		host->pdata->cleanup(&pdev->dev);
 
 	if (host->tx_chan)
 		dma_release_channel(host->tx_chan);
diff --git a/include/linux/platform_data/hsmmc-omap.h b/include/linux/platform_data/hsmmc-omap.h
index 28b8cff..066075c 100644
--- a/include/linux/platform_data/hsmmc-omap.h
+++ b/include/linux/platform_data/hsmmc-omap.h
@@ -45,14 +45,6 @@ struct omap_hsmmc_platform_data {
 	 * maximum frequency on the MMC bus */
 	unsigned int max_freq;
 
-	/* switch the bus to a new slot */
-	int (*switch_slot)(struct device *dev, int slot);
-	/* initialize board-specific MMC functionality, can be NULL if
-	 * not supported */
-	int (*init)(struct device *dev);
-	void (*cleanup)(struct device *dev);
-	void (*shutdown)(struct device *dev);
-
 	/* To handle board related suspend/resume functionality for MMC */
 	int (*suspend)(struct device *dev, int slot);
 	int (*resume)(struct device *dev, int slot);
-- 
2.1.0

