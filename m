From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH v2] mmc: sdio: add wakeup event for suspend/resume
Date: Mon, 28 Jan 2013 21:01:13 +0800
Message-ID: <1359378073-3554-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:50203 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751407Ab3A1NA7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Jan 2013 08:00:59 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Nicolas Pitre <nico@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Aaron Lu <aaron.lu@intel.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Daniel Drake <dsd@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Alexander Stein <alexander.stein@systec-electronic.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Viresh Kumar <viresh.kumar@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Thomas Abraham <thomas.abraham@linaro.org>, Chander Kashyap <chander.kashyap@linaro.com>, Jaehoon Chung <jh80.chung@samsung.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin

If sdio can wakeup host, the card interrupts received after suspend
while before resume back should be regard as wakeup event. So set
a wakeup event at that point. All sdio functions should set the
wakeup event individually according to its suspending status.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/core/sdio.c       |    4 ++++
 drivers/mmc/core/sdio_irq.c   |   10 ++++++++++
 include/linux/mmc/sdio_func.h |    6 ++++++
 3 files changed, 20 insertions(+)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 3a64933..06675cb 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -904,6 +904,8 @@ static int mmc_sdio_suspend(struct mmc_host *host)
 				err = pmops->suspend(&func->dev);
 			if (err)
 				break;
+			else
+				func->func_status = FUNC_SUSPENDED;
 		}
 	}
 	while (err && --i >= 0) {
@@ -911,6 +913,7 @@ static int mmc_sdio_suspend(struct mmc_host *host)
 		if (func && sdio_func_present(func) && func->dev.driver) {
 			const struct dev_pm_ops *pmops = func->dev.driver->pm;
 			pmops->resume(&func->dev);
+			func->func_status = FUNC_RESUMED;
 		}
 	}
 
@@ -967,6 +970,7 @@ static int mmc_sdio_resume(struct mmc_host *host)
 		if (func && sdio_func_present(func) && func->dev.driver) {
 			const struct dev_pm_ops *pmops = func->dev.driver->pm;
 			err = pmops->resume(&func->dev);
+			func->func_status = FUNC_RESUMED;
 		}
 	}
 
diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index 3d8ceb4..b1f3a3b 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -42,6 +42,11 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
 	 */
 	func = card->sdio_single_irq;
 	if (func && host->sdio_irq_pending) {
+		if (mmc_card_keep_power(host) &&
+			mmc_card_wake_sdio_irq(host) &&
+			(func->func_status == FUNC_SUSPENDED)) {
+			pm_wakeup_event(mmc_dev(host), 0);
+		}
 		func->irq_handler(func);
 		return 1;
 	}
@@ -63,6 +68,11 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
 					mmc_card_id(card));
 				ret = -EINVAL;
 			} else if (func->irq_handler) {
+				if (mmc_card_keep_power(host) &&
+					mmc_card_wake_sdio_irq(host) &&
+					(func->func_status == FUNC_SUSPENDED)) {
+					pm_wakeup_event(mmc_dev(host), 0);
+				}
 				func->irq_handler(func);
 				count++;
 			} else {
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

