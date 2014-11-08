From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v4 04/10] omap_hsmmc: remove un-initialized callbacks from platform data
Date: Sat,  8 Nov 2014 15:33:11 +0100
Message-ID: <1415457197-14294-5-git-send-email-afenkart@gmail.com>
References: <1415457197-14294-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:54895 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753716AbaKHOdf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 8 Nov 2014 09:33:35 -0500
In-Reply-To: <1415457197-14294-1-git-send-email-afenkart@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, pascal.huerst@gmail.com, Andreas Fenkart <afenkart@gmail.com>

these callbacks are not set, probably legacy omap 1/2 features

Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
---
 drivers/mmc/host/omap_hsmmc.c            | 15 +--------------
 include/linux/platform_data/hsmmc-omap.h |  9 ---------
 2 files changed, 1 insertion(+), 23 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 4957c5f..03e8e9a 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2204,18 +2204,10 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
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
 
@@ -2278,9 +2270,6 @@ err_slot_name:
 err_irq_cd:
 	if (host->use_reg)
 		omap_hsmmc_reg_put(host);
-err_reg:
-	if (host->pdata->cleanup)
-		host->pdata->cleanup(&pdev->dev);
 err_irq:
 	if (host->tx_chan)
 		dma_release_channel(host->tx_chan);
@@ -2306,8 +2295,6 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 	mmc_remove_host(host->mmc);
 	if (host->use_reg)
 		omap_hsmmc_reg_put(host);
-	if (host->pdata->cleanup)
-		host->pdata->cleanup(&pdev->dev);
 
 	if (host->tx_chan)
 		dma_release_channel(host->tx_chan);
diff --git a/include/linux/platform_data/hsmmc-omap.h b/include/linux/platform_data/hsmmc-omap.h
index 11d7ed9..7e70e15 100644
--- a/include/linux/platform_data/hsmmc-omap.h
+++ b/include/linux/platform_data/hsmmc-omap.h
@@ -47,14 +47,6 @@ struct omap_hsmmc_platform_data {
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
@@ -97,7 +89,6 @@ struct omap_hsmmc_platform_data {
 		int switch_pin;			/* gpio (card detect) */
 		int gpio_wp;			/* gpio (write protect) */
 
-		int (*set_bus_mode)(struct device *dev, int slot, int bus_mode);
 		int (*set_power)(struct device *dev, int slot,
 				 int power_on, int vdd);
 		int (*get_ro)(struct device *dev, int slot);
-- 
2.1.1

