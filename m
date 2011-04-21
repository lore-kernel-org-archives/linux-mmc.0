From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 2/2] MMC: add runtime and system power-management support to
 the TMIO MMCI driver
Date: Thu, 21 Apr 2011 09:20:50 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1104210915110.6893@axis700.grange>
References: <Pine.LNX.4.64.1104210911040.6893@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1104210911040.6893@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>, Ian Molton <ian@mnementh.co.uk>
List-Id: linux-mmc@vger.kernel.org

This patch adds a very crude runtime power-management to the TMIO MMC
driver. It only takes care to enable the hardware on probe() and keep
it enabled until remove(), at which time it disables it again. A
finer grained runtime PM would require implementing card detection
support on switched off interface.

System-wide power management has been verified with experimental PM
patches on AP4-based systems.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

This patch slightly changes driver's PM behaviour also on non-SDHI 
systems, namely, it adds a reset call to the resume path. If this is 
undesired, it can be easily moved to the SDHI-specific part. On SDHI it 
helps to faster recover the controller and avoid failing MMC requests due 
to timing out interrupts, and a repeated request retry from the core.

Runtime PM might change, if the core behaviour changes on driver unbind.

 drivers/mmc/host/sh_mobile_sdhi.c |    6 ++++
 drivers/mmc/host/tmio_mmc.c       |   11 ++----
 drivers/mmc/host/tmio_mmc.h       |    8 +++++
 drivers/mmc/host/tmio_mmc_pio.c   |   58 +++++++++++++++++++++++++++++++++++--
 4 files changed, 73 insertions(+), 10 deletions(-)

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
index f353624..249c724 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -121,4 +121,12 @@ static inline void tmio_mmc_release_dma(struct tmio_mmc_host *host)
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
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index f4fac9f..d1791ba 100644
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
@@ -884,12 +885,17 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
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
 
@@ -900,7 +906,7 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	ret = request_irq(_host->irq, tmio_mmc_irq, IRQF_DISABLED |
 		IRQF_TRIGGER_FALLING, dev_name(&pdev->dev), _host);
 	if (ret)
-		goto unmap_ctl;
+		goto pm_suspend;
 
 	spin_lock_init(&_host->lock);
 
@@ -910,6 +916,9 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	/* See if we also get DMA */
 	tmio_mmc_request_dma(_host, pdata);
 
+	/* We have to keep the device powered for its card detection to work */
+	pm_runtime_get_noresume(&pdev->dev);
+
 	mmc_add_host(mmc);
 
 	/* Unmask the IRQs we want to know about */
@@ -924,7 +933,10 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 
 	return 0;
 
-unmap_ctl:
+pm_suspend:
+	pm_runtime_suspend(&pdev->dev);
+pm_disable:
+	pm_runtime_disable(&pdev->dev);
 	iounmap(_host->ctl);
 host_free:
 	mmc_free_host(mmc);
@@ -935,13 +947,53 @@ EXPORT_SYMBOL(tmio_mmc_host_probe);
 
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
+	/*
+	 * Now rtpm usage_count = 2, because we incremented it once in probe()
+	 * above, and dd.c incremented it again, before calling .release(). So.
+	 * to power the device down we have to decrement the counter to 0 and
+	 * suspend it, because after our disable() suspending from dd.c will
+	 * only decrement the counter, but not call any callbacks
+	 */
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_get_noresume(&pdev->dev);
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
+	return ret;
+}
+EXPORT_SYMBOL(tmio_mmc_host_suspend);
+
+int tmio_mmc_host_resume(struct device *dev)
+{
+	struct mmc_host *mmc = dev_get_drvdata(dev);
+
+	tmio_mmc_reset(mmc_priv(mmc));
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

