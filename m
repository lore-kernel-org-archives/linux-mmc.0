From: Jeremie Samuel <jeremie.samuel.ext@parrot.com>
Subject: [PATCH 6/8] sdhci: Turn host->lock into a mutex
Date: Tue, 9 Jul 2013 17:44:10 +0200
Message-ID: <1373384652-21958-7-git-send-email-jeremie.samuel.ext@parrot.com>
References: <1373384652-21958-1-git-send-email-jeremie.samuel.ext@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:45926 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752039Ab3GIPoq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 9 Jul 2013 11:44:46 -0400
In-Reply-To: <1373384652-21958-1-git-send-email-jeremie.samuel.ext@parrot.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, matthieu.castet@parrot.com, gregor.boirie@parrot.com, Jeremie Samuel <jeremie.samuel.ext@parrot.com>, Anton Vorontsov <avorontsov@mvista.com>

Finally, we can get rid of the host->lock spinlock, and turn it
into a mutex.

This patch does just this.

Patch based on: http://thread.gmane.org/gmane.linux.kernel.mmc/2579.

Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
Signed-off-by: Jeremie Samuel <jeremie.samuel.ext@parrot.com>
---
 drivers/mmc/host/sdhci.c  |   99 ++++++++++++++++++++-------------------------
 include/linux/mmc/sdhci.h |    3 +-
 2 files changed, 46 insertions(+), 56 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9a7471c..9161ae3 100644
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
 
@@ -1872,7 +1869,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	    requires_tuning_nonuhs)
 		ctrl |= SDHCI_CTRL_EXEC_TUNING;
 	else {
-		spin_unlock(&host->lock);
+		mutex_unlock(&host->lock);
 		enable_irq(host->irq);
 		sdhci_runtime_pm_put(host);
 		return 0;
@@ -1945,7 +1942,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		host->cmd = NULL;
 		host->mrq = NULL;
 
-		spin_unlock(&host->lock);
+		mutex_unlock(&host->lock);
 		enable_irq(host->irq);
 
 		/* Wait for Buffer Read Ready interrupt */
@@ -1953,7 +1950,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 					(host->tuning_done == 1),
 					msecs_to_jiffies(50));
 		disable_irq(host->irq);
-		spin_lock(&host->lock);
+		mutex_lock(&host->lock);
 
 		if (!host->tuning_done) {
 			pr_info(DRIVER_NAME ": Timeout waiting for "
@@ -2028,7 +2025,7 @@ out:
 		err = 0;
 
 	sdhci_clear_set_irqs(host, SDHCI_INT_DATA_AVAIL, ier);
-	spin_unlock(&host->lock);
+	mutex_unlock(&host->lock);
 	enable_irq(host->irq);
 	sdhci_runtime_pm_put(host);
 
@@ -2064,13 +2061,12 @@ static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
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
@@ -2086,7 +2082,7 @@ static void sdhci_card_event(struct mmc_host *mmc)
 		schedule_work(&host->finish_work);
 	}
 
-	spin_unlock_irqrestore(&host->lock, flags);
+	mutex_unlock(&host->lock);
 }
 
 static const struct mmc_host_ops sdhci_ops = {
@@ -2121,19 +2117,18 @@ static void sdhci_card_detect_work(struct work_struct *wk)
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
 
@@ -2167,24 +2162,23 @@ static void sdhci_finish_work(struct work_struct *wk)
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
@@ -2205,21 +2199,20 @@ static void sdhci_timeout_work(struct work_struct *wk)
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
@@ -2413,10 +2406,10 @@ static irqreturn_t sdhci_irq_thread(int irq, void *dev_id)
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
@@ -2488,7 +2481,7 @@ again:
 	if (intmask && --max_loops)
 		goto again;
 
-	spin_unlock(&host->lock);
+	mutex_unlock(&host->lock);
 
 	if (unexpected) {
 		pr_err("%s: Unexpected interrupt 0x%08x.\n",
@@ -2677,7 +2670,6 @@ static void sdhci_runtime_pm_bus_off(struct sdhci_host *host)
 
 int sdhci_runtime_suspend_host(struct sdhci_host *host)
 {
-	unsigned long flags;
 	int ret = 0;
 
 	/* Disable tuning since we are suspending */
@@ -2686,15 +2678,15 @@ int sdhci_runtime_suspend_host(struct sdhci_host *host)
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
@@ -2702,7 +2694,6 @@ EXPORT_SYMBOL_GPL(sdhci_runtime_suspend_host);
 
 int sdhci_runtime_resume_host(struct sdhci_host *host)
 {
-	unsigned long flags;
 	int ret = 0, host_flags = host->flags;
 
 	if (host_flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
@@ -2720,16 +2711,16 @@ int sdhci_runtime_resume_host(struct sdhci_host *host)
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
 
@@ -2740,7 +2731,7 @@ int sdhci_runtime_resume_host(struct sdhci_host *host)
 	/* Enable Card Detection */
 	sdhci_enable_card_detection(host);
 
-	spin_unlock_irqrestore(&host->lock, flags);
+	mutex_unlock(&host->lock);
 
 	return ret;
 }
@@ -3153,7 +3144,7 @@ int sdhci_add_host(struct sdhci_host *host)
 		return -ENODEV;
 	}
 
-	spin_lock_init(&host->lock);
+	mutex_init(&host->lock);
 
 	/*
 	 * Maximum number of segments. Depends on if the hardware
@@ -3281,10 +3272,8 @@ EXPORT_SYMBOL_GPL(sdhci_add_host);
 
 void sdhci_remove_host(struct sdhci_host *host, int dead)
 {
-	unsigned long flags;
-
 	if (dead) {
-		spin_lock_irqsave(&host->lock, flags);
+		mutex_lock(&host->lock);
 
 		host->flags |= SDHCI_DEVICE_DEAD;
 
@@ -3296,7 +3285,7 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 			schedule_work(&host->finish_work);
 		}
 
-		spin_unlock_irqrestore(&host->lock, flags);
+		mutex_unlock(&host->lock);
 	}
 
 	sdhci_disable_card_detection(host);
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index adb95c3..0bcf967 100644
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

