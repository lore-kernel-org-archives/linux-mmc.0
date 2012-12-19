From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH 2/2] mmc: sdio: handle interrupt corner case during suspend
Date: Wed, 19 Dec 2012 20:12:10 +0800
Message-ID: <1355919130-28702-3-git-send-email-kliu5@marvell.com>
References: <1355919130-28702-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:55739 "EHLO
	na3sys009aog134.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750859Ab2LSMMl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Dec 2012 07:12:41 -0500
In-Reply-To: <1355919130-28702-1-git-send-email-kliu5@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Philip Rakity <prakity@nvidia.com>, Aaron Lu <aaron.lu@amd.com>, Shawn Guo <shawn.guo@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Daniel Drake <dsd@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Adrian Hunter <adrian.hunter@intel.com>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Alexander Stein <alexander.stein@systec-electronic.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Viresh Kumar <viresh.kumar@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Thomas Abraham <thomas.abraham@linaro.org>, Chander Kashyap <chander.kashyap@linaro.com>, Jaehoon Chung <jh80.chung@samsung.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Al Cooper <acooper@gmail.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>Cha

Sdio device may trigger interrupt after its function suspended
while system not suspended yet.

This patch handle above cases by below two methods:
1. For multiple sdio_funcs, abort suspend if interrupt happen after
its func suspended while some other funcs not suspended yet.
2. If interrupt happens after all sdio_funcs suspended, wakeup the
system.

Signed-off-by: Jialing Fu <jlfu@marvell.com>
Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/core/sdio.c       |   57 ++++++++++++++++++++++++++++++++++------
 drivers/mmc/core/sdio_irq.c   |    5 +++
 include/linux/mmc/host.h      |    5 +++
 include/linux/mmc/sdio_func.h |    6 ++++
 4 files changed, 64 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 81140b9..d9b4a11 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -888,6 +888,14 @@ out:
 	}
 }
 
+void mmc_sdio_irq_wakeup(struct mmc_host *host)
+{
+	pr_warning("%s: submit a wakeup event\n",
+		       mmc_hostname(host));
+	/* set the process time to 3 seconds */
+	pm_wakeup_event(mmc_dev(host), 3000);
+}
+
 /*
  * SDIO suspend.  We need to suspend all functions separately.
  * Therefore all registered functions must have drivers with suspend
@@ -897,8 +905,17 @@ static int mmc_sdio_suspend(struct mmc_host *host)
 {
 	int i, err = 0;
 
+	atomic_set(&host->sdio_suspend_abort, 0);
 	for (i = 0; i < host->card->sdio_funcs; i++) {
 		struct sdio_func *func = host->card->sdio_func[i];
+
+		/* Abort suspend if irq come after its sdio_func suspended */
+		if (i && atomic_cmpxchg(&host->sdio_suspend_abort, 1, 0)) {
+			atomic_set(&host->sdio_suspend_abort, 0);
+			err = -EBUSY;
+			break;
+		}
+
 		if (func && sdio_func_present(func) && func->dev.driver) {
 			const struct dev_pm_ops *pmops = func->dev.driver->pm;
 			if (!pmops || !pmops->suspend || !pmops->resume) {
@@ -906,15 +923,20 @@ static int mmc_sdio_suspend(struct mmc_host *host)
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
 
@@ -924,17 +946,30 @@ static int mmc_sdio_suspend(struct mmc_host *host)
 		mmc_release_host(host);
 	}
 
-	/*
-	* If sdio host can wakeup system, its interrupt will _NOT_ be disabled
-	* during suspending. So the card interrupt may occur after host has
-	* suspended. Claim the host here to avoid sdio irq thread handling the
-	* pending interrupt while sdio host suspended. The pending interrupt
-	* will be handled after the host released in resume when sdio host has
-	* been resumed.
-	*/
-	if (!err && device_may_wakeup(mmc_dev(host)))
+	if (!err && device_may_wakeup(mmc_dev(host))) {
+		/*
+		 * All interrupts after this will wakeup system
+		 */
+		atomic_set(&host->sdio_suspended, 1);
+
+		/*
+		 * If sdio host can wakeup system, its interrupt will _NOT_ be disabled
+		 * during suspending. So the card interrupt may occur after host has
+		 * suspended. Claim the host here to avoid sdio irq thread handling the
+		 * pending interrupt while sdio host suspended. The pending interrupt
+		 * will be handled after the host released in resume when sdio host has
+		 * been resumed.
+		 */
 		mmc_claim_host(host);
 
+		/*
+		 * Double check whether sdio IRQ happens after all func
+		 * suspended. If this case occur, wakeup system.
+		 */
+		if (atomic_cmpxchg(&host->sdio_suspend_abort, 1, 0))
+			mmc_sdio_irq_wakeup(host);
+	}
+
 	return err;
 }
 
@@ -967,6 +1002,8 @@ static int mmc_sdio_resume(struct mmc_host *host)
 
 	if (!err && host->sdio_irqs)
 		wake_up_process(host->sdio_irq_thread);
+
+	atomic_set(&host->sdio_suspended, 0);
 	mmc_release_host(host);
 
 	/*
@@ -982,8 +1019,10 @@ static int mmc_sdio_resume(struct mmc_host *host)
 	for (i = 0; !err && i < host->card->sdio_funcs; i++) {
 		struct sdio_func *func = host->card->sdio_func[i];
 		if (func && sdio_func_present(func) && func->dev.driver) {
+
 			const struct dev_pm_ops *pmops = func->dev.driver->pm;
 			err = pmops->resume(&func->dev);
+			func->func_status = FUNC_RESUMED;
 		}
 	}
 
diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index 3d8ceb4..cf03463 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -43,6 +43,9 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
 	func = card->sdio_single_irq;
 	if (func && host->sdio_irq_pending) {
 		func->irq_handler(func);
+		if (func->func_status == FUNC_SUSPENDED)
+			atomic_set(&host->sdio_suspend_abort, 1);
+
 		return 1;
 	}
 
@@ -64,6 +67,8 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
 				ret = -EINVAL;
 			} else if (func->irq_handler) {
 				func->irq_handler(func);
+				if (func->func_status == FUNC_SUSPENDED)
+					atomic_set(&host->sdio_suspend_abort, 1);
 				count++;
 			} else {
 				pr_warning("%s: pending IRQ with no handler\n",
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 61a10c1..72984ce 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -316,6 +316,8 @@ struct mmc_host {
 	struct task_struct	*sdio_irq_thread;
 	bool			sdio_irq_pending;
 	atomic_t		sdio_irq_thread_abort;
+	atomic_t		sdio_suspend_abort;
+	atomic_t		sdio_suspended;
 
 	mmc_pm_flag_t		pm_flags;	/* requested pm features */
 
@@ -367,11 +369,14 @@ extern void mmc_detect_change(struct mmc_host *, unsigned long delay);
 extern void mmc_request_done(struct mmc_host *, struct mmc_request *);
 
 extern int mmc_cache_ctrl(struct mmc_host *, u8);
+extern void mmc_sdio_irq_wakeup(struct mmc_host *host);
 
 static inline void mmc_signal_sdio_irq(struct mmc_host *host)
 {
 	host->ops->enable_sdio_irq(host, 0);
 	host->sdio_irq_pending = true;
+	if (atomic_read(&host->sdio_suspended))
+		mmc_sdio_irq_wakeup(host);
 	wake_up_process(host->sdio_irq_thread);
 }
 
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
1.7.0.4

