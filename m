From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 2/3] MMC: add runtime and system power-management support to
 the MMCIF driver
Date: Fri, 15 Apr 2011 20:30:51 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1104152027010.18593@axis700.grange>
References: <Pine.LNX.4.64.1104152021510.18593@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1104152021510.18593@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

Adding support for runtime power-management to the MMCIF driver allows
it to save power as long as no card is present. System-wide power
management has been verified with experimental PM patches on AP4-
based systems.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <damm@opensource.se>
---

To use this patch experimental PM patches from Magnus are needed, but even 
without them this patch can be applied and shouldn't cause any 
regressions.

 drivers/mmc/host/sh_mmcif.c |   59 +++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index d3871b6..519d827 100644
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
@@ -877,11 +879,21 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (ios->power_mode == MMC_POWER_UP) {
 		if (p->set_pwr)
 			p->set_pwr(host->pd, ios->power_mode);
+		if (!host->power) {
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
+				host->power = false;
+			}
+			if (p->down_pwr)
+				p->down_pwr(host->pd);
+		}
 		host->state = STATE_IDLE;
 		return;
 	}
@@ -1053,6 +1065,12 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 	sh_mmcif_sync_reset(host);
 	platform_set_drvdata(pdev, host);
 
+	pm_runtime_enable(&pdev->dev);
+	host->power = false;
+	ret = pm_runtime_resume(&pdev->dev);
+	if (ret < 0)
+		goto clean_up2;
+
 	/* See if we also get DMA */
 	sh_mmcif_request_dma(host, pd);
 
@@ -1080,6 +1098,7 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 	return ret;
 
 clean_up2:
+	pm_runtime_disable(&pdev->dev);
 	clk_disable(host->hclk);
 clean_up1:
 	mmc_free_host(mmc);
@@ -1112,15 +1131,51 @@ static int __devexit sh_mmcif_remove(struct platform_device *pdev)
 
 	clk_disable(host->hclk);
 	mmc_free_host(host->mmc);
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

