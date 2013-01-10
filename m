From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH v2] mmc: sdio: defer card int handling when the function suspended
Date: Thu, 10 Jan 2013 17:29:30 +0800
Message-ID: <1357810170-24981-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:33920 "EHLO
	na3sys009aog127.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751751Ab3AJJbA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Jan 2013 04:31:00 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Nicolas Pitre <nico@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Aaron Lu <aaron.lu@intel.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Daniel Drake <dsd@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Alexander Stein <alexander.stein@systec-electronic.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Viresh Kumar <viresh.kumar@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Thomas Abraham <thomas.abraham@linaro.org>, Chander Kashyap <chander.kashyap@linaro.com>, Jaehoon Chung <jh80.chung@samsung.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>Kevin

The sdio card interrupt happened after the function suspended should be
regarded as wakeup event. The interrupt should not be handled until the
function resume back.
If sdio host can wakeup system, interrupts will _NOT_ be disabled
and sdio card interrupt may happen during whole suspend/resume process.
Defer the interrupt handling will make system resume back.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
Signed-off-by: Jialing Fu <jlfu@marvell.com>
---
 drivers/mmc/core/sdio.c       |   21 +++++++++++++++++++--
 drivers/mmc/core/sdio_irq.c   |   16 ++++++++++++----
 include/linux/mmc/host.h      |    1 +
 include/linux/mmc/sdio_func.h |    6 ++++++
 4 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 2273ce6..bd0e589 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -896,8 +896,10 @@ static int mmc_sdio_suspend(struct mmc_host *host)
 {
 	int i, err = 0;
 
+	atomic_set(&host->sdio_suspend_abort, 0);
 	for (i = 0; i < host->card->sdio_funcs; i++) {
 		struct sdio_func *func = host->card->sdio_func[i];
+
 		if (func && sdio_func_present(func) && func->dev.driver) {
 			const struct dev_pm_ops *pmops = func->dev.driver->pm;
 			if (!pmops || !pmops->suspend || !pmops->resume) {
@@ -905,18 +907,26 @@ static int mmc_sdio_suspend(struct mmc_host *host)
 				err = -ENOSYS;
 			} else
 				err = pmops->suspend(&func->dev);
+
 			if (err)
 				break;
+			else
+				func->func_status = FUNC_SUSPENDED;
 		}
 	}
+
 	while (err && --i >= 0) {
 		struct sdio_func *func = host->card->sdio_func[i];
 		if (func && sdio_func_present(func) && func->dev.driver) {
 			const struct dev_pm_ops *pmops = func->dev.driver->pm;
 			pmops->resume(&func->dev);
+			func->func_status = FUNC_RESUMED;
 		}
 	}
 
+	if (err && atomic_cmpxchg(&host->sdio_suspend_abort, 1, 0))
+		wake_up_process(host->sdio_irq_thread);
+
 	if (!err && mmc_card_keep_power(host) && mmc_card_wake_sdio_irq(host)) {
 		mmc_claim_host(host);
 		sdio_disable_wide(host->card);
@@ -928,7 +938,7 @@ static int mmc_sdio_suspend(struct mmc_host *host)
 
 static int mmc_sdio_resume(struct mmc_host *host)
 {
-	int i, err = 0;
+	int i, err = 0, need_wake = 0;
 
 	BUG_ON(!host);
 	BUG_ON(!host->card);
@@ -950,7 +960,8 @@ static int mmc_sdio_resume(struct mmc_host *host)
 	}
 
 	if (!err && host->sdio_irqs)
-		wake_up_process(host->sdio_irq_thread);
+		need_wake = 1;
+
 	mmc_release_host(host);
 
 	/*
@@ -966,11 +977,17 @@ static int mmc_sdio_resume(struct mmc_host *host)
 	for (i = 0; !err && i < host->card->sdio_funcs; i++) {
 		struct sdio_func *func = host->card->sdio_func[i];
 		if (func && sdio_func_present(func) && func->dev.driver) {
+
 			const struct dev_pm_ops *pmops = func->dev.driver->pm;
 			err = pmops->resume(&func->dev);
+			func->func_status = FUNC_RESUMED;
 		}
 	}
 
+	atomic_set(&host->sdio_suspend_abort, 0);
+	if (need_wake)
+		wake_up_process(host->sdio_irq_thread);
+
 	return err;
 }
 
diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index 3d8ceb4..390f08c 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -42,7 +42,10 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
 	 */
 	func = card->sdio_single_irq;
 	if (func && host->sdio_irq_pending) {
-		func->irq_handler(func);
+		if (func->func_status == FUNC_SUSPENDED)
+			atomic_set(&host->sdio_suspend_abort, 1);
+		else
+			func->irq_handler(func);
 		return 1;
 	}
 
@@ -63,7 +66,10 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
 					mmc_card_id(card));
 				ret = -EINVAL;
 			} else if (func->irq_handler) {
-				func->irq_handler(func);
+				if (func->func_status == FUNC_SUSPENDED)
+					atomic_set(&host->sdio_suspend_abort, 1);
+				else
+					func->irq_handler(func);
 				count++;
 			} else {
 				pr_warning("%s: pending IRQ with no handler\n",
@@ -119,7 +125,8 @@ static int sdio_irq_thread(void *_host)
 		if (ret)
 			break;
 		ret = process_sdio_pending_irqs(host);
-		host->sdio_irq_pending = false;
+		if (!atomic_read(&host->sdio_suspend_abort))
+			host->sdio_irq_pending = false;
 		mmc_release_host(host);
 
 		/*
@@ -149,7 +156,8 @@ static int sdio_irq_thread(void *_host)
 		}
 
 		set_current_state(TASK_INTERRUPTIBLE);
-		if (host->caps & MMC_CAP_SDIO_IRQ) {
+		if ((host->caps & MMC_CAP_SDIO_IRQ) &&
+			!atomic_read(&host->sdio_suspend_abort)) {
 			mmc_host_clk_hold(host);
 			host->ops->enable_sdio_irq(host, 1);
 			mmc_host_clk_release(host);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 61a10c1..b98364d 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -316,6 +316,7 @@ struct mmc_host {
 	struct task_struct	*sdio_irq_thread;
 	bool			sdio_irq_pending;
 	atomic_t		sdio_irq_thread_abort;
+	atomic_t		sdio_suspend_abort;
 
 	mmc_pm_flag_t		pm_flags;	/* requested pm features */
 
diff --git a/include/linux/mmc/sdio_func.h b/include/linux/mmc/sdio_func.h
index 50f0bc9..59f4c23 100644
--- a/include/linux/mmc/sdio_func.h
+++ b/include/linux/mmc/sdio_func.h
@@ -32,6 +32,11 @@ struct sdio_func_tuple {
 	unsigned char data[0];
 };
 
+enum sdio_func_status {
+	FUNC_RESUMED = 0,	/* default value */
+	FUNC_SUSPENDED,
+};
+
 /*
  * SDIO function devices
  */
@@ -59,6 +64,7 @@ struct sdio_func {
 	const char		**info;		/* info strings */
 
 	struct sdio_func_tuple *tuples;
+	enum sdio_func_status	func_status;	/* SDIO function driver state */
 };
 
 #define sdio_func_present(f)	((f)->state & SDIO_STATE_PRESENT)
-- 
1.7.9.5

