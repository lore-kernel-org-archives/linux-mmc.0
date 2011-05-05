From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH v4] mmc: add runtime and system power-management support to
 the MMCIF driver
Date: Thu, 5 May 2011 18:20:48 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1105051813270.29735@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:55462 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754883Ab1EEQVB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 May 2011 12:21:01 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>, "Rafael J. Wysocki" <rjw@sisk.pl>

Adding support for runtime power-management to the MMCIF driver allows
it to save power as long as no card is present. To also allow to turn
off the power domain at that time, we release DMA channels during that
time, since on some sh-mobile systems the DMA controller(s) and the
MMCIF block belong to the same power domain. System-wide power
management has been tested with experimental PM patches on AP4-based
systems.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

This patch supersedes:

[PATCH 2/3 v3] MMC: add runtime and system power-management support to the MMCIF driver

and has been tested to work with Rafael's suspend git-tree, power-domains 
branch.

 drivers/mmc/host/sh_mmcif.c |   78 ++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 69 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index d3871b6..14f8edb 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -29,6 +29,7 @@
 #include <linux/mmc/sh_mmcif.h>
 #include <linux/pagemap.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/spinlock.h>
 
 #define DRIVER_NAME	"sh_mmcif"
@@ -173,6 +174,7 @@ struct sh_mmcif_host {
 	struct completion intr_wait;
 	enum mmcif_state state;
 	spinlock_t lock;
+	bool power;
 
 	/* DMA support */
 	struct dma_chan		*chan_rx;
@@ -877,11 +879,24 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (ios->power_mode == MMC_POWER_UP) {
 		if (p->set_pwr)
 			p->set_pwr(host->pd, ios->power_mode);
+		if (!host->power) {
+			/* See if we also get DMA */
+			sh_mmcif_request_dma(host, host->pd->dev.platform_data);
+			pm_runtime_get_sync(&host->pd->dev);
+			host->power = true;
+		}
 	} else if (ios->power_mode == MMC_POWER_OFF || !ios->clock) {
 		/* clock stop */
 		sh_mmcif_clock_control(host, 0);
-		if (ios->power_mode == MMC_POWER_OFF && p->down_pwr)
-			p->down_pwr(host->pd);
+		if (ios->power_mode == MMC_POWER_OFF) {
+			if (host->power) {
+				pm_runtime_put(&host->pd->dev);
+				sh_mmcif_release_dma(host);
+				host->power = false;
+			}
+			if (p->down_pwr)
+				p->down_pwr(host->pd);
+		}
 		host->state = STATE_IDLE;
 		return;
 	}
@@ -957,7 +972,7 @@ static irqreturn_t sh_mmcif_intr(int irq, void *dev_id)
 		sh_mmcif_bitclr(host, MMCIF_CE_INT_MASK, state);
 		err = 1;
 	} else {
-		dev_dbg(&host->pd->dev, "Not support int\n");
+		dev_dbg(&host->pd->dev, "Unsupported interrupt: 0x%x\n", state);
 		sh_mmcif_writel(host->addr, MMCIF_CE_INT, ~state);
 		sh_mmcif_bitclr(host, MMCIF_CE_INT_MASK, state);
 		err = 1;
@@ -1053,8 +1068,12 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 	sh_mmcif_sync_reset(host);
 	platform_set_drvdata(pdev, host);
 
-	/* See if we also get DMA */
-	sh_mmcif_request_dma(host, pd);
+	pm_runtime_enable(&pdev->dev);
+	host->power = false;
+
+	ret = pm_runtime_resume(&pdev->dev);
+	if (ret < 0)
+		goto clean_up2;
 
 	mmc_add_host(mmc);
 
@@ -1063,13 +1082,13 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 	ret = request_irq(irq[0], sh_mmcif_intr, 0, "sh_mmc:error", host);
 	if (ret) {
 		dev_err(&pdev->dev, "request_irq error (sh_mmc:error)\n");
-		goto clean_up2;
+		goto clean_up3;
 	}
 	ret = request_irq(irq[1], sh_mmcif_intr, 0, "sh_mmc:int", host);
 	if (ret) {
 		free_irq(irq[0], host);
 		dev_err(&pdev->dev, "request_irq error (sh_mmc:int)\n");
-		goto clean_up2;
+		goto clean_up3;
 	}
 
 	sh_mmcif_detect(host->mmc);
@@ -1079,7 +1098,11 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 		sh_mmcif_readl(host->addr, MMCIF_CE_VERSION) & 0x0000ffff);
 	return ret;
 
+clean_up3:
+	mmc_remove_host(mmc);
+	pm_runtime_suspend(&pdev->dev);
 clean_up2:
+	pm_runtime_disable(&pdev->dev);
 	clk_disable(host->hclk);
 clean_up1:
 	mmc_free_host(mmc);
@@ -1094,9 +1117,9 @@ static int __devexit sh_mmcif_remove(struct platform_device *pdev)
 	struct sh_mmcif_host *host = platform_get_drvdata(pdev);
 	int irq[2];
 
-	mmc_remove_host(host->mmc);
-	sh_mmcif_release_dma(host);
+	pm_runtime_get_sync(&pdev->dev);
 
+	mmc_remove_host(host->mmc);
 	sh_mmcif_writel(host->addr, MMCIF_CE_INT_MASK, MASK_ALL);
 
 	if (host->addr)
@@ -1112,15 +1135,52 @@ static int __devexit sh_mmcif_remove(struct platform_device *pdev)
 
 	clk_disable(host->hclk);
 	mmc_free_host(host->mmc);
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int sh_mmcif_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct sh_mmcif_host *host = platform_get_drvdata(pdev);
+	int ret = mmc_suspend_host(host->mmc);
+
+	if (!ret) {
+		sh_mmcif_writel(host->addr, MMCIF_CE_INT_MASK, MASK_ALL);
+		clk_disable(host->hclk);
+	}
+
+	return ret;
+}
+
+static int sh_mmcif_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct sh_mmcif_host *host = platform_get_drvdata(pdev);
+
+	clk_enable(host->hclk);
+
+	return mmc_resume_host(host->mmc);
+}
+#else
+#define sh_mmcif_suspend	NULL
+#define sh_mmcif_resume		NULL
+#endif	/* CONFIG_PM */
+
+static const struct dev_pm_ops sh_mmcif_dev_pm_ops = {
+	.suspend = sh_mmcif_suspend,
+	.resume = sh_mmcif_resume,
+};
+
 static struct platform_driver sh_mmcif_driver = {
 	.probe		= sh_mmcif_probe,
 	.remove		= sh_mmcif_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
+		.pm	= &sh_mmcif_dev_pm_ops,
 	},
 };
 
-- 
1.7.2.5

