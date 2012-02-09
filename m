From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 03/10 v3] mmc: tmio_mmc: support the generic MMC GPIO card hotplug helper
Date: Thu,  9 Feb 2012 22:57:09 +0100
Message-ID: <1328824636-10553-4-git-send-email-g.liakhovetski@gmx.de>
References: <1328824636-10553-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:54759 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932214Ab2BIV5V (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Feb 2012 16:57:21 -0500
In-Reply-To: <1328824636-10553-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

If the platform specifies the TMIO_MMC_HAS_COLD_CD flag, use the generic
MMC GPIO card hotplug helper.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/tmio_mmc.h     |    4 --
 drivers/mmc/host/tmio_mmc_pio.c |   69 +++++++++++++++++---------------------
 include/linux/mfd/tmio.h        |   25 +++++++++++---
 3 files changed, 50 insertions(+), 48 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 8531d8d..ede2f4e5 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -53,10 +53,6 @@ struct tmio_mmc_host {
 	void (*set_pwr)(struct platform_device *host, int state);
 	void (*set_clk_div)(struct platform_device *host, int state);
 
-	int			pm_error;
-	/* recognise system-wide suspend in runtime PM methods */
-	bool			pm_global;
-
 	/* pio related stuff */
 	struct scatterlist      *sg_ptr;
 	struct scatterlist      *sg_orig;
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index a5d1052..3a28c62 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -34,6 +34,7 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/mfd/tmio.h>
+#include <linux/mmc/cd-gpio.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/tmio.h>
 #include <linux/module.h>
@@ -787,8 +788,10 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	spin_unlock_irqrestore(&host->lock, flags);
 
 	/*
-	 * pdata->power == false only if COLD_CD is available, otherwise only
-	 * in short time intervals during probing or resuming
+	 * pdata->power toggles between false and true in both cases - either
+	 * or not the controller can be runtime-suspended during inactivity. But
+	 * if the controller has to be kept on, the runtime-pm usage_count is
+	 * kept positive, so no suspending actually takes place.
 	 */
 	if (ios->power_mode == MMC_POWER_ON && ios->clock) {
 		if (!pdata->power) {
@@ -913,6 +916,7 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 		mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
 
 	_host->native_hotplug = !(pdata->flags & TMIO_MMC_HAS_COLD_CD ||
+				  pdata->flags & TMIO_MMC_USE_GPIO_CD ||
 				  mmc->caps & MMC_CAP_NEEDS_POLL ||
 				  mmc->caps & MMC_CAP_NONREMOVABLE);
 	pdata->power = false;
@@ -928,9 +932,9 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	 *  3) a worker thread polls the sdhi - indicated by MMC_CAP_NEEDS_POLL
 	 *  4) the medium is non-removable - indicated by MMC_CAP_NONREMOVABLE
 	 *
-	 *  While we increment the rtpm counter for all scenarios when the mmc
-	 *  core activates us by calling an appropriate set_ios(), we must
-	 *  additionally ensure that in case 2) the tmio mmc hardware stays
+	 *  While we increment the runtime PM counter for all scenarios when
+	 *  the mmc core activates us by calling an appropriate set_ios(), we
+	 *  must additionally ensure that in case 2) the tmio mmc hardware stays
 	 *  powered on during runtime for the card detection to work.
 	 */
 	if (_host->native_hotplug)
@@ -964,6 +968,14 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 
 	tmio_mmc_enable_mmc_irqs(_host, irq_mask);
 
+	if (pdata->flags & TMIO_MMC_USE_GPIO_CD) {
+		ret = mmc_cd_gpio_request(mmc, pdata->cd_gpio);
+		if (ret < 0) {
+			tmio_mmc_host_remove(_host);
+			return ret;
+		}
+	}
+
 	*host = _host;
 
 	return 0;
@@ -981,18 +993,20 @@ EXPORT_SYMBOL(tmio_mmc_host_probe);
 void tmio_mmc_host_remove(struct tmio_mmc_host *host)
 {
 	struct platform_device *pdev = host->pdev;
+	struct tmio_mmc_data *pdata = host->pdata;
+	struct mmc_host *mmc = host->mmc;
+
+	if (pdata->flags & TMIO_MMC_USE_GPIO_CD)
+		/*
+		 * This means we can miss a card-eject, but this is anyway
+		 * possible, because of delayed processing of hotplug events.
+		 */
+		mmc_cd_gpio_free(mmc);
 
-	/*
-	 * We don't have to manipulate pdata->power here: if there is a card in
-	 * the slot, the runtime PM is active and our .runtime_resume() will not
-	 * be run. If there is no card in the slot and the platform can suspend
-	 * the controller, the runtime PM is suspended and pdata->power == false,
-	 * so, our .runtime_resume() will not try to detect a card in the slot.
-	 */
 	if (!host->native_hotplug)
 		pm_runtime_get_sync(&pdev->dev);
 
-	mmc_remove_host(host->mmc);
+	mmc_remove_host(mmc);
 	cancel_work_sync(&host->done);
 	cancel_delayed_work_sync(&host->delayed_reset_work);
 	tmio_mmc_release_dma(host);
@@ -1001,7 +1015,7 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
 	pm_runtime_disable(&pdev->dev);
 
 	iounmap(host->ctl);
-	mmc_free_host(host->mmc);
+	mmc_free_host(mmc);
 }
 EXPORT_SYMBOL(tmio_mmc_host_remove);
 
@@ -1015,8 +1029,6 @@ int tmio_mmc_host_suspend(struct device *dev)
 	if (!ret)
 		tmio_mmc_disable_mmc_irqs(host, TMIO_MASK_ALL);
 
-	host->pm_error = pm_runtime_put_sync(dev);
-
 	return ret;
 }
 EXPORT_SYMBOL(tmio_mmc_host_suspend);
@@ -1026,20 +1038,10 @@ int tmio_mmc_host_resume(struct device *dev)
 	struct mmc_host *mmc = dev_get_drvdata(dev);
 	struct tmio_mmc_host *host = mmc_priv(mmc);
 
-	/* The MMC core will perform the complete set up */
-	host->pdata->power = false;
-
-	host->pm_global = true;
-	if (!host->pm_error)
-		pm_runtime_get_sync(dev);
-
-	if (host->pm_global) {
-		/* Runtime PM resume callback didn't run */
-		tmio_mmc_reset(host);
-		tmio_mmc_enable_dma(host, true);
-		host->pm_global = false;
-	}
+	tmio_mmc_reset(host);
+	tmio_mmc_enable_dma(host, true);
 
+	/* The MMC core will perform the complete set up */
 	return mmc_resume_host(mmc);
 }
 EXPORT_SYMBOL(tmio_mmc_host_resume);
@@ -1056,19 +1058,10 @@ int tmio_mmc_host_runtime_resume(struct device *dev)
 {
 	struct mmc_host *mmc = dev_get_drvdata(dev);
 	struct tmio_mmc_host *host = mmc_priv(mmc);
-	struct tmio_mmc_data *pdata = host->pdata;
 
 	tmio_mmc_reset(host);
 	tmio_mmc_enable_dma(host, true);
 
-	if (pdata->power) {
-		/* Only entered after a card-insert interrupt */
-		if (!mmc->card)
-			tmio_mmc_set_ios(mmc, &mmc->ios);
-		mmc_detect_change(mmc, msecs_to_jiffies(100));
-	}
-	host->pm_global = false;
-
 	return 0;
 }
 EXPORT_SYMBOL(tmio_mmc_host_runtime_resume);
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index 0dc9804..5a197de 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -1,8 +1,10 @@
 #ifndef MFD_TMIO_H
 #define MFD_TMIO_H
 
+#include <linux/device.h>
 #include <linux/fb.h>
 #include <linux/io.h>
+#include <linux/jiffies.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
@@ -64,8 +66,8 @@
 #define TMIO_MMC_SDIO_IRQ		(1 << 2)
 /*
  * Some platforms can detect card insertion events with controller powered
- * down, in which case they have to call tmio_mmc_cd_wakeup() to power up the
- * controller and report the event to the driver.
+ * down, using a GPIO IRQ, in which case they have to fill in cd_irq, cd_gpio,
+ * and cd_flags fields of struct tmio_mmc_data.
  */
 #define TMIO_MMC_HAS_COLD_CD		(1 << 3)
 /*
@@ -73,6 +75,12 @@
  * idle before writing to some registers.
  */
 #define TMIO_MMC_HAS_IDLE_WAIT		(1 << 4)
+/*
+ * A GPIO is used for card hotplug detection. We need an extra flag for this,
+ * because 0 is a valid GPIO number too, and requiring users to specify
+ * cd_gpio < 0 to disable GPIO hotplug would break backwards compatibility.
+ */
+#define TMIO_MMC_USE_GPIO_CD		(1 << 5)
 
 int tmio_core_mmc_enable(void __iomem *cnf, int shift, unsigned long base);
 int tmio_core_mmc_resume(void __iomem *cnf, int shift, unsigned long base);
@@ -98,18 +106,23 @@ struct tmio_mmc_data {
 	struct tmio_mmc_dma		*dma;
 	struct device			*dev;
 	bool				power;
+	unsigned int			cd_gpio;
 	void (*set_pwr)(struct platform_device *host, int state);
 	void (*set_clk_div)(struct platform_device *host, int state);
 	int (*get_cd)(struct platform_device *host);
 	int (*write16_hook)(struct tmio_mmc_host *host, int addr);
 };
 
+/*
+ * This function is deprecated and will be removed soon. Please, convert your
+ * platform to use drivers/mmc/core/cd-gpio.c
+ */
+#include <linux/mmc/host.h>
 static inline void tmio_mmc_cd_wakeup(struct tmio_mmc_data *pdata)
 {
-	if (pdata && !pdata->power) {
-		pdata->power = true;
-		pm_runtime_get(pdata->dev);
-	}
+	if (pdata)
+		mmc_detect_change(dev_get_drvdata(pdata->dev),
+				  msecs_to_jiffies(100));
 }
 
 /*
-- 
1.7.2.5

