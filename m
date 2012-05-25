From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 2/2 v3] mmc: sh-mmcif: add OF support, make platform data optional
Date: Fri, 25 May 2012 17:45:48 +0200
Message-ID: <1337960752-4944-34-git-send-email-g.liakhovetski@gmx.de>
References: <Pine.LNX.4.64.1205251727260.13353@axis700.grange>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1205251727260.13353@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>, Olof Johansson <olof@lixom.net>
List-Id: linux-mmc@vger.kernel.org

Add primitive OF support to the sh-mmcif driver, which also makes it
necessary to be able to run without platform data.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mmcif.c |   29 ++++++++++++++++++++---------
 1 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index f952978..53a3ff3 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -54,6 +54,7 @@
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/sdio.h>
 #include <linux/mmc/sh_mmcif.h>
+#include <linux/mod_devicetable.h>
 #include <linux/pagemap.h>
 #include <linux/platform_device.h>
 #include <linux/pm_qos.h>
@@ -388,6 +389,9 @@ static void sh_mmcif_request_dma(struct sh_mmcif_host *host,
 	struct sh_dmae_slave *tx, *rx;
 	host->dma_active = false;
 
+	if (!pdata)
+		return;
+
 	/* We can only either use DMA for both Tx and Rx or not use it at all */
 	if (pdata->dma) {
 		dev_warn(&host->pd->dev,
@@ -448,13 +452,14 @@ static void sh_mmcif_release_dma(struct sh_mmcif_host *host)
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
 {
 	struct sh_mmcif_plat_data *pd = host->pd->dev.platform_data;
 
-	if (pd->set_pwr)
+	if (pd && pd->set_pwr)
 		pd->set_pwr(host->pd, ios->power_mode != MMC_POWER_OFF);
 	if (host->vdd)
 		/* Errors ignored... */
@@ -1005,7 +1010,7 @@ static int sh_mmcif_get_cd(struct mmc_host *mmc)
 	struct sh_mmcif_host *host = mmc_priv(mmc);
 	struct sh_mmcif_plat_data *p = host->pd->dev.platform_data;
 
-	if (!p->get_cd)
+	if (!p || !p->get_cd)
 		return -ENOSYS;
 	else
 		return p->get_cd(host->pd);
@@ -1278,6 +1283,9 @@ static void sh_mmcif_init_ocr(struct sh_mmcif_host *host)
 
 	host->vdd = mmc_regulator_get_vmmc(mmc);
 
+	if (!pd)
+		return;
+
 	if (!mmc->ocr_avail)
 		mmc->ocr_avail = pd->ocr;
 	else if (pd->ocr)
@@ -1294,11 +1302,6 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 	void __iomem *reg;
 	char clk_name[8];
 
-	if (!pd) {
-		dev_err(&pdev->dev, "sh_mmcif plat data error.\n");
-		return -ENXIO;
-	}
-
 	irq[0] = platform_get_irq(pdev, 0);
 	irq[1] = platform_get_irq(pdev, 1);
 	if (irq[0] < 0 || irq[1] < 0) {
@@ -1334,7 +1337,7 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 	sh_mmcif_init_ocr(host);
 
 	mmc->caps = MMC_CAP_MMC_HIGHSPEED;
-	if (pd->caps)
+	if (pd && pd->caps)
 		mmc->caps |= pd->caps;
 	mmc->max_segs = 32;
 	mmc->max_blk_size = 512;
@@ -1471,6 +1474,12 @@ static int sh_mmcif_resume(struct device *dev)
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
@@ -1482,6 +1491,8 @@ static struct platform_driver sh_mmcif_driver = {
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.pm	= &sh_mmcif_dev_pm_ops,
+		.owner	= THIS_MODULE,
+		.of_match_table = mmcif_of_match,
 	},
 };
 
-- 
1.7.2.5

--
To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
