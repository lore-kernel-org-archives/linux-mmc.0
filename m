From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH v2] mmc: Add runtime and system-wide PM to the TMIO MMC driver
Date: Thu, 5 May 2011 18:13:12 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1105051802200.29735@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:62043 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753362Ab1EEQNP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 May 2011 12:13:15 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>, Ian Molton <ian@mnementh.co.uk>

Add runtime and system-wide power management to the TMIO MMC driver
in PIO and DMA modes, allowing it to properly save and restore its
state during system suspend. Runtime PM is very crude ATM, because
the controller has to be powered on all the time to detect card
hotplug events.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

This patch supersedes

[PATCH 2/2] MMC: add runtime and system power-management support to the TMIO MMCI driver
[PATCH] MMC: add runtime PM calls to global suspend() / redume() methods on TMIO
[PATCH] mmc: tmio: fix PM in DMA mode

 drivers/mmc/host/sh_mobile_sdhi.c |    6 ++++
 drivers/mmc/host/tmio_mmc.c       |   11 ++----
 drivers/mmc/host/tmio_mmc.h       |   10 ++++++
 drivers/mmc/host/tmio_mmc_dma.c   |   21 ++++++++------
 drivers/mmc/host/tmio_mmc_pio.c   |   57 +++++++++++++++++++++++++++++++++++--
 5 files changed, 86 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index cc70123..f60e954 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -143,10 +143,16 @@ static int sh_mobile_sdhi_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct dev_pm_ops tmio_mmc_dev_pm_ops = {
+	.suspend = tmio_mmc_host_suspend,
+	.resume = tmio_mmc_host_resume,
+};
+
 static struct platform_driver sh_mobile_sdhi_driver = {
 	.driver		= {
 		.name	= "sh_mobile_sdhi",
 		.owner	= THIS_MODULE,
+		.pm	= &tmio_mmc_dev_pm_ops,
 	},
 	.probe		= sh_mobile_sdhi_probe,
 	.remove		= __devexit_p(sh_mobile_sdhi_remove),
diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index 79c5684..be739f7 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -30,7 +30,7 @@ static int tmio_mmc_suspend(struct platform_device *dev, pm_message_t state)
 	struct mmc_host *mmc = platform_get_drvdata(dev);
 	int ret;
 
-	ret = mmc_suspend_host(mmc);
+	ret = tmio_mmc_host_suspend(&dev->dev);
 
 	/* Tell MFD core it can disable us now.*/
 	if (!ret && cell->disable)
@@ -46,15 +46,12 @@ static int tmio_mmc_resume(struct platform_device *dev)
 	int ret = 0;
 
 	/* Tell the MFD core we are ready to be enabled */
-	if (cell->resume) {
+	if (cell->resume)
 		ret = cell->resume(dev);
-		if (ret)
-			goto out;
-	}
 
-	mmc_resume_host(mmc);
+	if (!ret)
+		ret = tmio_mmc_host_resume(&dev->dev);
 
-out:
 	return ret;
 }
 #else
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 099ed49..c1470e6 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -51,6 +51,8 @@ struct tmio_mmc_host {
 	void (*set_pwr)(struct platform_device *host, int state);
 	void (*set_clk_div)(struct platform_device *host, int state);
 
+	int			pm_error;
+
 	/* pio related stuff */
 	struct scatterlist      *sg_ptr;
 	struct scatterlist      *sg_orig;
@@ -120,4 +122,12 @@ static inline void tmio_mmc_release_dma(struct tmio_mmc_host *host)
 }
 #endif
 
+#ifdef CONFIG_PM
+int tmio_mmc_host_suspend(struct device *dev);
+int tmio_mmc_host_resume(struct device *dev);
+#else
+#define tmio_mmc_host_suspend NULL
+#define tmio_mmc_host_resume NULL
+#endif
+
 #endif
diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmio_mmc_dma.c
index d3de74a..25f1ad6 100644
--- a/drivers/mmc/host/tmio_mmc_dma.c
+++ b/drivers/mmc/host/tmio_mmc_dma.c
@@ -256,7 +256,10 @@ static bool tmio_mmc_filter(struct dma_chan *chan, void *arg)
 void tmio_mmc_request_dma(struct tmio_mmc_host *host, struct tmio_mmc_data *pdata)
 {
 	/* We can only either use DMA for both Tx and Rx or not use it at all */
-	if (pdata->dma) {
+	if (!pdata->dma)
+		return;
+
+	if (!host->chan_tx && !host->chan_rx) {
 		dma_cap_mask_t mask;
 
 		dma_cap_zero(mask);
@@ -284,18 +287,18 @@ void tmio_mmc_request_dma(struct tmio_mmc_host *host, struct tmio_mmc_data *pdat
 
 		tasklet_init(&host->dma_complete, tmio_mmc_tasklet_fn, (unsigned long)host);
 		tasklet_init(&host->dma_issue, tmio_mmc_issue_tasklet_fn, (unsigned long)host);
+	}
 
-		tmio_mmc_enable_dma(host, true);
+	tmio_mmc_enable_dma(host, true);
+
+	return;
 
-		return;
 ebouncebuf:
-		dma_release_channel(host->chan_rx);
-		host->chan_rx = NULL;
+	dma_release_channel(host->chan_rx);
+	host->chan_rx = NULL;
 ereqrx:
-		dma_release_channel(host->chan_tx);
-		host->chan_tx = NULL;
-		return;
-	}
+	dma_release_channel(host->chan_tx);
+	host->chan_tx = NULL;
 }
 
 void tmio_mmc_release_dma(struct tmio_mmc_host *host)
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 62d37de..d29d707 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -39,6 +39,7 @@
 #include <linux/module.h>
 #include <linux/pagemap.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/scatterlist.h>
 #include <linux/workqueue.h>
 #include <linux/spinlock.h>
@@ -834,12 +835,17 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	else
 		mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
 
+	pm_runtime_enable(&pdev->dev);
+	ret = pm_runtime_resume(&pdev->dev);
+	if (ret < 0)
+		goto pm_disable;
+
 	tmio_mmc_clk_stop(_host);
 	tmio_mmc_reset(_host);
 
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0)
-		goto unmap_ctl;
+		goto pm_suspend;
 
 	_host->irq = ret;
 
@@ -850,7 +856,7 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	ret = request_irq(_host->irq, tmio_mmc_irq, IRQF_DISABLED |
 		IRQF_TRIGGER_FALLING, dev_name(&pdev->dev), _host);
 	if (ret)
-		goto unmap_ctl;
+		goto pm_suspend;
 
 	spin_lock_init(&_host->lock);
 
@@ -860,6 +866,9 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	/* See if we also get DMA */
 	tmio_mmc_request_dma(_host, pdata);
 
+	/* We have to keep the device powered for its card detection to work */
+	pm_runtime_get_noresume(&pdev->dev);
+
 	mmc_add_host(mmc);
 
 	/* Unmask the IRQs we want to know about */
@@ -874,7 +883,10 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 
 	return 0;
 
-unmap_ctl:
+pm_suspend:
+	pm_runtime_suspend(&pdev->dev);
+pm_disable:
+	pm_runtime_disable(&pdev->dev);
 	iounmap(_host->ctl);
 host_free:
 	mmc_free_host(mmc);
@@ -885,13 +897,52 @@ EXPORT_SYMBOL(tmio_mmc_host_probe);
 
 void tmio_mmc_host_remove(struct tmio_mmc_host *host)
 {
+	struct platform_device *pdev = host->pdev;
+
 	mmc_remove_host(host->mmc);
 	cancel_delayed_work_sync(&host->delayed_reset_work);
 	tmio_mmc_release_dma(host);
 	free_irq(host->irq, host);
 	iounmap(host->ctl);
 	mmc_free_host(host->mmc);
+
+	/* Compensate for pm_runtime_get_sync() in probe() above */
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 }
 EXPORT_SYMBOL(tmio_mmc_host_remove);
 
+#ifdef CONFIG_PM
+int tmio_mmc_host_suspend(struct device *dev)
+{
+	struct mmc_host *mmc = dev_get_drvdata(dev);
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+	int ret = mmc_suspend_host(mmc);
+
+	if (!ret)
+		tmio_mmc_disable_mmc_irqs(host, TMIO_MASK_ALL);
+
+	host->pm_error = pm_runtime_put_sync(dev);
+
+	return ret;
+}
+EXPORT_SYMBOL(tmio_mmc_host_suspend);
+
+int tmio_mmc_host_resume(struct device *dev)
+{
+	struct mmc_host *mmc = dev_get_drvdata(dev);
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+
+	if (!host->pm_error)
+		pm_runtime_get_sync(dev);
+
+	tmio_mmc_reset(mmc_priv(mmc));
+	tmio_mmc_request_dma(host, host->pdata);
+
+	return mmc_resume_host(mmc);
+}
+EXPORT_SYMBOL(tmio_mmc_host_resume);
+
+#endif	/* CONFIG_PM */
+
 MODULE_LICENSE("GPL v2");
-- 
1.7.2.5

