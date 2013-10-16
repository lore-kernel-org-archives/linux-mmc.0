From: Jeremie Samuel <jeremie.samuel.ext@parrot.com>
Subject: [PATCH 6/8] sdhci: Turn host->lock into a mutex
Date: Wed, 16 Oct 2013 18:20:56 +0200
Message-ID: <1381940458-12628-7-git-send-email-jeremie.samuel.ext@parrot.com>
References: <1381940458-12628-1-git-send-email-jeremie.samuel.ext@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:33770 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932488Ab3JPQWf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 16 Oct 2013 12:22:35 -0400
In-Reply-To: <1381940458-12628-1-git-send-email-jeremie.samuel.ext@parrot.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, =?UTF-8?q?Gr=C3=A9gor=20Boirie?= <gregor.boirie@parrot.com>, Matthieu Castet <matthieu.castet@parrot.com>, Jeremie Samuel <jeremie.samuel.ext@parrot.com>, Anton Vorontsov <avorontsov@mvista.com>

Finally, we can get rid of the host->lock spinlock, and turn it
into a mutex.

This patch does just this.

Patch based on: http://thread.gmane.org/gmane.linux.kernel.mmc/2579.

Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
Signed-off-by: Jeremie Samuel <jeremie.samuel.ext@parrot.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    4 +-
 drivers/mmc/host/sdhci-pxav3.c     |   10 ++--
 drivers/mmc/host/sdhci-s3c.c       |    5 +-
 drivers/mmc/host/sdhci.c           |  101 ++++++++++++++++--------------------
 include/linux/mmc/sdhci.h          |    3 +-
 5 files changed, 55 insertions(+), 68 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index b9899e9..1b3b444 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -641,12 +641,12 @@ static int esdhc_send_tuning_cmd(struct sdhci_host *host, u32 opcode)
 	init_completion(&(mrq.completion));
 
 	disable_irq(host->irq);
-	spin_lock(&host->lock);
+	mutex_lock(&host->lock);
 	host->mrq = &mrq;
 
 	sdhci_send_command(host, mrq.cmd);
 
-	spin_unlock(&host->lock);
+	mutex_unlock(&host->lock);
 	enable_irq(host->irq);
 
 	wait_for_completion(&mrq.completion);
diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 793dacd..fb761a9 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -378,12 +378,11 @@ static int sdhci_pxav3_runtime_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	unsigned long flags;
 
 	if (pltfm_host->clk) {
-		spin_lock_irqsave(&host->lock, flags);
+		mutex_lock(&host->lock);
 		host->runtime_suspended = true;
-		spin_unlock_irqrestore(&host->lock, flags);
+		mutex_unlock(&host->lock);
 
 		clk_disable_unprepare(pltfm_host->clk);
 	}
@@ -395,14 +394,13 @@ static int sdhci_pxav3_runtime_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	unsigned long flags;
 
 	if (pltfm_host->clk) {
 		clk_prepare_enable(pltfm_host->clk);
 
-		spin_lock_irqsave(&host->lock, flags);
+		mutex_lock(&host->lock);
 		host->runtime_suspended = false;
-		spin_unlock_irqrestore(&host->lock, flags);
+		mutex_unlock(&host->lock);
 	}
 
 	return 0;
diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 6debda9..d114c29 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -376,10 +376,9 @@ static void sdhci_s3c_notify_change(struct platform_device *dev, int state)
 #ifdef CONFIG_PM_RUNTIME
 	struct sdhci_s3c *sc = sdhci_priv(host);
 #endif
-	unsigned long flags;
 
 	if (host) {
-		spin_lock_irqsave(&host->lock, flags);
+		mutex_lock(&host->lock);
 		if (state) {
 			dev_dbg(&dev->dev, "card inserted.\n");
 #ifdef CONFIG_PM_RUNTIME
@@ -396,7 +395,7 @@ static void sdhci_s3c_notify_change(struct platform_device *dev, int state)
 #endif
 		}
 		tasklet_schedule(&host->card_tasklet);
-		spin_unlock_irqrestore(&host->lock, flags);
+		mutex_unlock(&host->lock);
 	}
 }
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index be91ca1..ce7c99b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
+#include <linux/mutex.h>
 #include <linux/scatterlist.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
@@ -1331,14 +1332,13 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct sdhci_host *host;
 	int present;
-	unsigned long flags;
 	u32 tuning_opcode;
 
 	host = mmc_priv(mmc);
 
 	sdhci_runtime_pm_get(host);
 
-	spin_lock_irqsave(&host->lock, flags);
+	mutex_lock(&host->lock);
 
 	WARN_ON(host->mrq != NULL);
 
@@ -1394,9 +1394,9 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 					mmc->card->type == MMC_TYPE_MMC ?
 					MMC_SEND_TUNING_BLOCK_HS200 :
 					MMC_SEND_TUNING_BLOCK;
-				spin_unlock_irqrestore(&host->lock, flags);
+				mutex_unlock(&host->lock);
 				sdhci_execute_tuning(mmc, tuning_opcode);
-				spin_lock_irqsave(&host->lock, flags);
+				mutex_lock(&host->lock);
 
 				/* Restore original mmc_request structure */
 				host->mrq = mrq;
@@ -1410,19 +1410,18 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	}
 
 	mmiowb();
-	spin_unlock_irqrestore(&host->lock, flags);
+	mutex_unlock(&host->lock);
 }
 
 static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 {
-	unsigned long flags;
 	int vdd_bit = -1;
 	u8 ctrl;
 
-	spin_lock_irqsave(&host->lock, flags);
+	mutex_lock(&host->lock);
 
 	if (host->flags & SDHCI_DEVICE_DEAD) {
-		spin_unlock_irqrestore(&host->lock, flags);
+		mutex_unlock(&host->lock);
 		if (host->vmmc && ios->power_mode == MMC_POWER_OFF)
 			mmc_regulator_set_ocr(host->mmc, host->vmmc, 0);
 		return;
@@ -1449,9 +1448,9 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 		vdd_bit = sdhci_set_power(host, ios->vdd);
 
 	if (host->vmmc && vdd_bit != -1) {
-		spin_unlock_irqrestore(&host->lock, flags);
+		mutex_unlock(&host->lock);
 		mmc_regulator_set_ocr(host->mmc, host->vmmc, vdd_bit);
-		spin_lock_irqsave(&host->lock, flags);
+		mutex_lock(&host->lock);
 	}
 
 	if (host->ops->platform_send_init_74_clocks)
@@ -1588,7 +1587,7 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 		sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
 
 	mmiowb();
-	spin_unlock_irqrestore(&host->lock, flags);
+	mutex_unlock(&host->lock);
 }
 
 static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
@@ -1633,10 +1632,9 @@ static int sdhci_get_cd(struct mmc_host *mmc)
 
 static int sdhci_check_ro(struct sdhci_host *host)
 {
-	unsigned long flags;
 	int is_readonly;
 
-	spin_lock_irqsave(&host->lock, flags);
+	mutex_lock(&host->lock);
 
 	if (host->flags & SDHCI_DEVICE_DEAD)
 		is_readonly = 0;
@@ -1646,7 +1644,7 @@ static int sdhci_check_ro(struct sdhci_host *host)
 		is_readonly = !(sdhci_readl(host, SDHCI_PRESENT_STATE)
 				& SDHCI_WRITE_PROTECT);
 
-	spin_unlock_irqrestore(&host->lock, flags);
+	mutex_unlock(&host->lock);
 
 	/* This quirk needs to be replaced by a callback-function later */
 	return host->quirks & SDHCI_QUIRK_INVERTED_WRITE_PROTECT ?
@@ -1717,11 +1715,10 @@ out:
 static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
-	unsigned long flags;
 
-	spin_lock_irqsave(&host->lock, flags);
+	mutex_lock(&host->lock);
 	sdhci_enable_sdio_irq_nolock(host, enable);
-	spin_unlock_irqrestore(&host->lock, flags);
+	mutex_unlock(&host->lock);
 }
 
 static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
@@ -1852,7 +1849,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 
 	sdhci_runtime_pm_get(host);
 	disable_irq(host->irq);
-	spin_lock(&host->lock);
+	mutex_lock(&host->lock);
 
 	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 
@@ -1872,14 +1869,14 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	    requires_tuning_nonuhs)
 		ctrl |= SDHCI_CTRL_EXEC_TUNING;
 	else {
-		spin_unlock(&host->lock);
+		mutex_unlock(&host->lock);
 		enable_irq(host->irq);
 		sdhci_runtime_pm_put(host);
 		return 0;
 	}
 
 	if (host->ops->platform_execute_tuning) {
-		spin_unlock(&host->lock);
+		mutex_unlock(&host->lock);
 		enable_irq(host->irq);
 		err = host->ops->platform_execute_tuning(host, opcode);
 		sdhci_runtime_pm_put(host);
@@ -1953,7 +1950,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		host->cmd = NULL;
 		host->mrq = NULL;
 
-		spin_unlock(&host->lock);
+		mutex_unlock(&host->lock);
 		enable_irq(host->irq);
 
 		/* Wait for Buffer Read Ready interrupt */
@@ -1961,7 +1958,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 					(host->tuning_done == 1),
 					msecs_to_jiffies(50));
 		disable_irq(host->irq);
-		spin_lock(&host->lock);
+		mutex_lock(&host->lock);
 
 		if (!host->tuning_done) {
 			pr_info(DRIVER_NAME ": Timeout waiting for "
@@ -2036,7 +2033,7 @@ out:
 		err = 0;
 
 	sdhci_clear_set_irqs(host, SDHCI_INT_DATA_AVAIL, ier);
-	spin_unlock(&host->lock);
+	mutex_unlock(&host->lock);
 	enable_irq(host->irq);
 	sdhci_runtime_pm_put(host);
 
@@ -2072,13 +2069,12 @@ static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
 static void sdhci_card_event(struct mmc_host *mmc)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
-	unsigned long flags;
 
 	/* First check if client has provided their own card event */
 	if (host->ops->card_event)
 		host->ops->card_event(host);
 
-	spin_lock_irqsave(&host->lock, flags);
+	mutex_lock(&host->lock);
 
 	/* Check host->mrq first in case we are runtime suspended */
 	if (host->mrq && !sdhci_do_get_cd(host)) {
@@ -2094,7 +2090,7 @@ static void sdhci_card_event(struct mmc_host *mmc)
 		schedule_work(&host->finish_work);
 	}
 
-	spin_unlock_irqrestore(&host->lock, flags);
+	mutex_unlock(&host->lock);
 }
 
 static const struct mmc_host_ops sdhci_ops = {
@@ -2129,19 +2125,18 @@ static void sdhci_card_detect_work(struct work_struct *wk)
 static void sdhci_finish_work(struct work_struct *wk)
 {
 	struct sdhci_host *host;
-	unsigned long flags;
 	struct mmc_request *mrq;
 
 	host = container_of(wk, struct sdhci_host, finish_work);
 
-	spin_lock_irqsave(&host->lock, flags);
+	mutex_lock(&host->lock);
 
 	/*
 	 * If this work gets rescheduled while running, it will
 	 * be run again afterwards but without any active request.
 	 */
 	if (!host->mrq) {
-		spin_unlock_irqrestore(&host->lock, flags);
+		mutex_unlock(&host->lock);
 		return;
 	}
 
@@ -2175,24 +2170,23 @@ static void sdhci_finish_work(struct work_struct *wk)
 	host->data = NULL;
 
 	mmiowb();
-	spin_unlock_irqrestore(&host->lock, flags);
+	mutex_unlock(&host->lock);
 
 	mmc_request_done(host->mmc, mrq);
 	sdhci_runtime_pm_put(host);
 
-	spin_lock_irqsave(&host->lock, flags);
+	mutex_lock(&host->lock);
 	sdhci_deactivate_led(host);
-	spin_unlock_irqrestore(&host->lock, flags);
+	mutex_unlock(&host->lock);
 }
 
 static void sdhci_timeout_work(struct work_struct *wk)
 {
 	struct sdhci_host *host;
-	unsigned long flags;
 
 	host = container_of(wk, struct sdhci_host, timeout_work.work);
 
-	spin_lock_irqsave(&host->lock, flags);
+	mutex_lock(&host->lock);
 
 	if (host->mrq) {
 		pr_err("%s: Timeout waiting for hardware "
@@ -2213,21 +2207,20 @@ static void sdhci_timeout_work(struct work_struct *wk)
 	}
 
 	mmiowb();
-	spin_unlock_irqrestore(&host->lock, flags);
+	mutex_unlock(&host->lock);
 }
 
 static void sdhci_tuning_timeout_work(struct work_struct *wk)
 {
 	struct sdhci_host *host;
-	unsigned long flags;
 
 	host = container_of(wk, struct sdhci_host, tuning_timeout_work.work);
 
-	spin_lock_irqsave(&host->lock, flags);
+	mutex_lock(&host->lock);
 
 	host->flags |= SDHCI_NEEDS_RETUNING;
 
-	spin_unlock_irqrestore(&host->lock, flags);
+	mutex_unlock(&host->lock);
 }
 
 /*****************************************************************************\
@@ -2421,10 +2414,10 @@ static irqreturn_t sdhci_irq_thread(int irq, void *dev_id)
 	u32 intmask, unexpected = 0;
 	int cardint = 0, max_loops = 16;
 
-	spin_lock(&host->lock);
+	mutex_lock(&host->lock);
 
 	if (host->runtime_suspended) {
-		spin_unlock(&host->lock);
+		mutex_unlock(&host->lock);
 		pr_warning("%s: got irq while runtime suspended\n",
 		       mmc_hostname(host->mmc));
 		return IRQ_HANDLED;
@@ -2496,7 +2489,7 @@ again:
 	if (intmask && --max_loops)
 		goto again;
 
-	spin_unlock(&host->lock);
+	mutex_unlock(&host->lock);
 
 	if (unexpected) {
 		pr_err("%s: Unexpected interrupt 0x%08x.\n",
@@ -2685,7 +2678,6 @@ static void sdhci_runtime_pm_bus_off(struct sdhci_host *host)
 
 int sdhci_runtime_suspend_host(struct sdhci_host *host)
 {
-	unsigned long flags;
 	int ret = 0;
 
 	/* Disable tuning since we are suspending */
@@ -2694,15 +2686,15 @@ int sdhci_runtime_suspend_host(struct sdhci_host *host)
 		host->flags &= ~SDHCI_NEEDS_RETUNING;
 	}
 
-	spin_lock_irqsave(&host->lock, flags);
+	mutex_lock(&host->lock);
 	sdhci_mask_irqs(host, SDHCI_INT_ALL_MASK);
-	spin_unlock_irqrestore(&host->lock, flags);
+	mutex_unlock(&host->lock);
 
 	synchronize_irq(host->irq);
 
-	spin_lock_irqsave(&host->lock, flags);
+	mutex_lock(&host->lock);
 	host->runtime_suspended = true;
-	spin_unlock_irqrestore(&host->lock, flags);
+	mutex_unlock(&host->lock);
 
 	return ret;
 }
@@ -2710,7 +2702,6 @@ EXPORT_SYMBOL_GPL(sdhci_runtime_suspend_host);
 
 int sdhci_runtime_resume_host(struct sdhci_host *host)
 {
-	unsigned long flags;
 	int ret = 0, host_flags = host->flags;
 
 	if (host_flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
@@ -2728,16 +2719,16 @@ int sdhci_runtime_resume_host(struct sdhci_host *host)
 	sdhci_do_start_signal_voltage_switch(host, &host->mmc->ios);
 	if ((host_flags & SDHCI_PV_ENABLED) &&
 		!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN)) {
-		spin_lock_irqsave(&host->lock, flags);
+		mutex_lock(&host->lock);
 		sdhci_enable_preset_value(host, true);
-		spin_unlock_irqrestore(&host->lock, flags);
+		mutex_unlock(&host->lock);
 	}
 
 	/* Set the re-tuning expiration flag */
 	if (host->flags & SDHCI_USING_RETUNING_TIMER)
 		host->flags |= SDHCI_NEEDS_RETUNING;
 
-	spin_lock_irqsave(&host->lock, flags);
+	mutex_lock(&host->lock);
 
 	host->runtime_suspended = false;
 
@@ -2748,7 +2739,7 @@ int sdhci_runtime_resume_host(struct sdhci_host *host)
 	/* Enable Card Detection */
 	sdhci_enable_card_detection(host);
 
-	spin_unlock_irqrestore(&host->lock, flags);
+	mutex_unlock(&host->lock);
 
 	return ret;
 }
@@ -3164,7 +3155,7 @@ int sdhci_add_host(struct sdhci_host *host)
 		return -ENODEV;
 	}
 
-	spin_lock_init(&host->lock);
+	mutex_init(&host->lock);
 
 	/*
 	 * Maximum number of segments. Depends on if the hardware
@@ -3292,10 +3283,8 @@ EXPORT_SYMBOL_GPL(sdhci_add_host);
 
 void sdhci_remove_host(struct sdhci_host *host, int dead)
 {
-	unsigned long flags;
-
 	if (dead) {
-		spin_lock_irqsave(&host->lock, flags);
+		mutex_lock(&host->lock);
 
 		host->flags |= SDHCI_DEVICE_DEAD;
 
@@ -3307,7 +3296,7 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 			schedule_work(&host->finish_work);
 		}
 
-		spin_unlock_irqrestore(&host->lock, flags);
+		mutex_unlock(&host->lock);
 	}
 
 	sdhci_disable_card_detection(host);
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 3bb6ad6..2f6a97a 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -15,6 +15,7 @@
 #include <linux/workqueue.h>
 #include <linux/compiler.h>
 #include <linux/types.h>
+#include <linux/mutex.h>
 #include <linux/io.h>
 #include <linux/mmc/host.h>
 
@@ -118,7 +119,7 @@ struct sdhci_host {
 	enum led_brightness brightness;
 #endif
 
-	spinlock_t lock;	/* Mutex */
+	struct mutex lock;	/* Mutex */
 
 	int flags;		/* Host attributes */
 #define SDHCI_USE_SDMA		(1<<0)	/* Host is SDMA capable */
-- 
1.7.10.4

