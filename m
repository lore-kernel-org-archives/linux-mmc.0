From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 27/29] mmc: mmcif: add OF support
Date: Thu,  3 May 2012 17:05:56 +0200
Message-ID: <1336057558-11031-28-git-send-email-g.liakhovetski@gmx.de>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>
List-Id: linux-mmc@vger.kernel.org

Add generic MMC OF parsing support to the sh-mmcif driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/mmc/host/sh_mmcif.c |   33 +++++++++++++++++++++++++++------
 1 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index f6d0b11..4fdedcf 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -54,6 +54,7 @@
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/sdio.h>
 #include <linux/mmc/sh_mmcif.h>
+#include <linux/of.h>
 #include <linux/pagemap.h>
 #include <linux/platform_device.h>
 #include <linux/pm_qos.h>
@@ -387,6 +388,9 @@ static void sh_mmcif_request_dma(struct sh_mmcif_host *host,
 	struct sh_dmae_slave *tx, *rx;
 	host->dma_active = false;
 
+	if (!pdata)
+		return;
+
 	/* We can only either use DMA for both Tx and Rx or not use it at all */
 	if (pdata->dma) {
 		dev_warn(&host->pd->dev,
@@ -447,13 +451,14 @@ static void sh_mmcif_release_dma(struct sh_mmcif_host *host)
 static void sh_mmcif_clock_control(struct sh_mmcif_host *host, unsigned int clk)
 {
 	struct sh_mmcif_plat_data *p = host->pd->dev.platform_data;
+	bool sup_pclk = p ? p->sup_pclk : false;
 
 	sh_mmcif_bitclr(host, MMCIF_CE_CLK_CTRL, CLK_ENABLE);
 	sh_mmcif_bitclr(host, MMCIF_CE_CLK_CTRL, CLK_CLEAR);
 
 	if (!clk)
 		return;
-	if (p->sup_pclk && clk == host->clk)
+	if (sup_pclk && clk == host->clk)
 		sh_mmcif_bitset(host, MMCIF_CE_CLK_CTRL, CLK_SUP_PCLK);
 	else
 		sh_mmcif_bitset(host, MMCIF_CE_CLK_CTRL, CLK_CLEAR &
@@ -937,7 +942,7 @@ static void sh_mmcif_set_power(struct sh_mmcif_host *host, struct mmc_ios *ios)
 		/* Errors ignored... */
 		mmc_regulator_set_ocr(host->mmc, host->vdd,
 				      ios->power_mode ? ios->vdd : 0);
-	else if (pd->set_pwr)
+	else if (pd && pd->set_pwr)
 		pd->set_pwr(host->pd, ios->power_mode != MMC_POWER_OFF);
 }
 
@@ -1002,7 +1007,7 @@ static int sh_mmcif_get_cd(struct mmc_host *mmc)
 	struct sh_mmcif_host *host = mmc_priv(mmc);
 	struct sh_mmcif_plat_data *p = host->pd->dev.platform_data;
 
-	if (!p->get_cd)
+	if (!p || !p->get_cd)
 		return -ENOSYS;
 	else
 		return p->get_cd(host->pd);
@@ -1275,6 +1280,9 @@ static void sh_mmcif_init_ocr(struct sh_mmcif_host *host)
 
 	host->vdd = mmc_regulator_get_vmmc(mmc);
 
+	if (!pd)
+		return;
+
 	if ((mmc->ocr_avail && pd->ocr) || (host->vdd && pd->set_pwr))
 		dev_warn(mmc_dev(mmc),
 			 "Platform OCR mask / .set_pwr() are ignored\n");
@@ -1288,6 +1296,7 @@ static void sh_mmcif_init_ocr(struct sh_mmcif_host *host)
 
 static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 {
+	struct device_node *node = pdev->dev.of_node;
 	int ret = 0, irq[2];
 	struct mmc_host *mmc;
 	struct sh_mmcif_host *host;
@@ -1295,7 +1304,7 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 	struct resource *res;
 	void __iomem *reg;
 
-	if (!pd) {
+	if (!pd && !of_device_is_available(node)) {
 		dev_err(&pdev->dev, "sh_mmcif plat data error.\n");
 		return -ENXIO;
 	}
@@ -1331,11 +1340,13 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 
 	spin_lock_init(&host->lock);
 
+	mmc_of_get(mmc);
+
 	mmc->ops = &sh_mmcif_ops;
 	sh_mmcif_init_ocr(host);
 
-	mmc->caps = MMC_CAP_MMC_HIGHSPEED;
-	if (pd->caps)
+	mmc->caps |= MMC_CAP_MMC_HIGHSPEED;
+	if (pd && pd->caps)
 		mmc->caps |= pd->caps;
 	mmc->max_segs = 32;
 	mmc->max_blk_size = 512;
@@ -1400,6 +1411,7 @@ eresume:
 	clk_put(host->hclk);
 eclkget:
 	pm_runtime_disable(&pdev->dev);
+	mmc_of_put(mmc);
 	mmc_free_host(mmc);
 ealloch:
 	iounmap(reg);
@@ -1412,6 +1424,7 @@ static int __devexit sh_mmcif_remove(struct platform_device *pdev)
 	int irq[2];
 
 	host->dying = true;
+	mmc_of_put(host->mmc);
 	clk_enable(host->hclk);
 	pm_runtime_get_sync(&pdev->dev);
 
@@ -1469,6 +1482,12 @@ static int sh_mmcif_resume(struct device *dev)
 #define sh_mmcif_resume		NULL
 #endif	/* CONFIG_PM */
 
+static const struct of_device_id mmcif_of_match[] = {
+	{ .compatible = "renesas,sh-mmcif" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mmcif_of_match);
+
 static const struct dev_pm_ops sh_mmcif_dev_pm_ops = {
 	.suspend = sh_mmcif_suspend,
 	.resume = sh_mmcif_resume,
@@ -1480,6 +1499,8 @@ static struct platform_driver sh_mmcif_driver = {
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.pm	= &sh_mmcif_dev_pm_ops,
+		.owner	= THIS_MODULE,
+		.of_match_table = mmcif_of_match,
 	},
 };
 
-- 
1.7.2.5

