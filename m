From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 2/3] mmc: remove unncessary mmc_gpio_free_cd() call from slot-gpio users
Date: Tue, 11 Dec 2012 22:32:19 +0800
Message-ID: <1355236340-21304-3-git-send-email-shawn.guo@linaro.org>
References: <1355236340-21304-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:55108
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753114Ab2LKOcd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Dec 2012 09:32:33 -0500
In-Reply-To: <1355236340-21304-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>

Since slot-gpio uses devm_* managed functions in mmc_gpio_request_cd()
now, we can remove those mmc_gpio_free_cd() call from host drivers'
.probe() error path and .remove().

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mmc/host/sdhci-pxav3.c  |    5 -----
 drivers/mmc/host/sh_mmcif.c     |    6 ------
 drivers/mmc/host/tmio_mmc_pio.c |    8 --------
 3 files changed, 19 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index fad0966..b7ee776 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -316,7 +316,6 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 err_add_host:
 	clk_disable_unprepare(clk);
 	clk_put(clk);
-	mmc_gpio_free_cd(host->mmc);
 err_cd_req:
 err_clk_get:
 	sdhci_pltfm_free(pdev);
@@ -329,16 +328,12 @@ static int sdhci_pxav3_remove(struct platform_device *pdev)
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_pxa *pxa = pltfm_host->priv;
-	struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
 
 	sdhci_remove_host(host, 1);
 
 	clk_disable_unprepare(pltfm_host->clk);
 	clk_put(pltfm_host->clk);
 
-	if (gpio_is_valid(pdata->ext_cd_gpio))
-		mmc_gpio_free_cd(host->mmc);
-
 	sdhci_pltfm_free(pdev);
 	kfree(pxa);
 
diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 9b8efac..2f229e0 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1410,8 +1410,6 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 	return ret;
 
 emmcaddh:
-	if (pd && pd->use_cd_gpio)
-		mmc_gpio_free_cd(mmc);
 erqcd:
 	free_irq(irq[1], host);
 ereqirq1:
@@ -1433,7 +1431,6 @@ ealloch:
 static int sh_mmcif_remove(struct platform_device *pdev)
 {
 	struct sh_mmcif_host *host = platform_get_drvdata(pdev);
-	struct sh_mmcif_plat_data *pd = pdev->dev.platform_data;
 	int irq[2];
 
 	host->dying = true;
@@ -1442,9 +1439,6 @@ static int sh_mmcif_remove(struct platform_device *pdev)
 
 	dev_pm_qos_hide_latency_limit(&pdev->dev);
 
-	if (pd && pd->use_cd_gpio)
-		mmc_gpio_free_cd(host->mmc);
-
 	mmc_remove_host(host->mmc);
 	sh_mmcif_writel(host->addr, MMCIF_CE_INT_MASK, MASK_ALL);
 
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 50bf495..0f992e9 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -1060,16 +1060,8 @@ EXPORT_SYMBOL(tmio_mmc_host_probe);
 void tmio_mmc_host_remove(struct tmio_mmc_host *host)
 {
 	struct platform_device *pdev = host->pdev;
-	struct tmio_mmc_data *pdata = host->pdata;
 	struct mmc_host *mmc = host->mmc;
 
-	if (pdata->flags & TMIO_MMC_USE_GPIO_CD)
-		/*
-		 * This means we can miss a card-eject, but this is anyway
-		 * possible, because of delayed processing of hotplug events.
-		 */
-		mmc_gpio_free_cd(mmc);
-
 	if (!host->native_hotplug)
 		pm_runtime_get_sync(&pdev->dev);
 
-- 
1.7.9.5


