From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v2 3/9] omap_hsmmc: remove un-initialized callbacks from platform data
Date: Mon, 29 Sep 2014 11:32:53 +0200
Message-ID: <1411983179-28677-4-git-send-email-afenkart@gmail.com>
References: <1411983179-28677-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1411983179-28677-1-git-send-email-afenkart@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulf.hansson@linaro.org>, pascal.huerst@gmail.com, Andreas Fenkart <afenkart@gmail.com>
List-Id: linux-mmc@vger.kernel.org

these callbacks are not set, probably legacy omap 1/2 features

Signed-off-by: Andreas Fenkart <afenkart@gmail.com>

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 5f2b5b7..f68ac1a 100644
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
index 026efb6..2807786 100644
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
@@ -95,7 +87,6 @@ struct omap_hsmmc_platform_data {
 		int switch_pin;			/* gpio (card detect) */
 		int gpio_wp;			/* gpio (write protect) */
 
-		int (*set_bus_mode)(struct device *dev, int slot, int bus_mode);
 		int (*set_power)(struct device *dev, int slot,
 				 int power_on, int vdd);
 		int (*get_ro)(struct device *dev, int slot);
-- 
2.1.0

