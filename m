From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 2/3 v3] MMC: add runtime and system power-management support
 to the MMCIF driver
Date: Thu, 21 Apr 2011 08:55:45 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1104210841060.6893@axis700.grange>
References: <Pine.LNX.4.64.1104152021510.18593@axis700.grange>
 <Pine.LNX.4.64.1104152027010.18593@axis700.grange>
 <Pine.LNX.4.64.1104191248190.16641@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1104191248190.16641@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-mmc@vger.kernel.org

Adding support for runtime power-management to the MMCIF driver allows
it to save power as long as no card is present. System-wide power
management has been verified with experimental PM patches on AP4-
based systems.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
v3: A further improvement over v2, but in any case waiting for a result of 
the runtime PM vs. driver unbinding discussion:

http://thread.gmane.org/gmane.linux.kernel.mmc/7433/focus=7476

specific changes are:

(1) the patch to bus.c is dropped as wrong, instead, platform specific 
runtime PM prototype code has been fixed

(2) consolidated calls to

	pm_runtime_put_noidle();
	pm_runtime_suspend();

to one call to

	pm_runtime_put_sync()

(3) fixed probe() error path.

v2: With this patch and with the patch to mmc/core/bus.c, that I've sent a 
couple of minutes ago

http://article.gmane.org/gmane.linux.kernel.mmc/7433

PM works correctly with all possible modprobe / rmmod, card-insert / 
eject, and STR scenarios, that I could come up with. The part in 
sh_mmcif_remove() is a bit rough though...

 drivers/mmc/host/sh_mmcif.c |   69 ++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index d3871b6..1889d64 100644
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
 
@@ -1063,13 +1081,13 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
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
@@ -1079,7 +1097,12 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 		sh_mmcif_readl(host->addr, MMCIF_CE_VERSION) & 0x0000ffff);
 	return ret;
 
+clean_up3:
+	mmc_remove_host(mmc);
+	sh_mmcif_release_dma(host);
+	pm_runtime_suspend(&pdev->dev);
 clean_up2:
+	pm_runtime_disable(&pdev->dev);
 	clk_disable(host->hclk);
 clean_up1:
 	mmc_free_host(mmc);
@@ -1112,15 +1135,53 @@ static int __devexit sh_mmcif_remove(struct platform_device *pdev)
 
 	clk_disable(host->hclk);
 	mmc_free_host(host->mmc);
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_get_noresume(&pdev->dev);
 
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

