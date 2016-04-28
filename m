From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2] mmc: core: Remove redundant rescan_disable flag
Date: Thu, 28 Apr 2016 20:29:16 +0200
Message-ID: <1461868156-5734-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:35591 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbcD1S3W (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Apr 2016 14:29:22 -0400
Received: by mail-lf0-f46.google.com with SMTP id c126so106178122lfb.2
        for <linux-mmc@vger.kernel.org>; Thu, 28 Apr 2016 11:29:22 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>

For the reasons explained below, it's safe to remove the rescan_disable
flag.

1)
cancel_delayed_work_sync() prevents an executing work from re-scheduling
itself.

2)
We are using the system_freezable_wq for the rescan works. As that queue
becomes frozen when userspace becomes frozen during system PM, we don't
need to disable the rescan works in the PM_SUSPEND_PREPARE phase.

3)
At host registration it's not safe to schedule a detect work until
mmc_start_host() is invoked. Trying to use the rescan_disable flag to
prevent a rescan work from being executed isn't helping.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	Updated changelog to better reflect why rescan_flag is redundant.

---
 drivers/mmc/core/core.c  | 12 ------------
 drivers/mmc/core/host.c  |  3 ---
 include/linux/mmc/host.h |  1 -
 3 files changed, 16 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 99275e4..b8c6a11 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2580,9 +2580,6 @@ void mmc_rescan(struct work_struct *work)
 		container_of(work, struct mmc_host, detect.work);
 	int i;
 
-	if (host->rescan_disable)
-		return;
-
 	/* If there is a non-removable card registered, only scan once */
 	if (!mmc_card_is_removable(host) && host->rescan_entered)
 		return;
@@ -2649,7 +2646,6 @@ void mmc_rescan(struct work_struct *work)
 void mmc_start_host(struct mmc_host *host)
 {
 	host->f_init = max(freqs[0], host->f_min);
-	host->rescan_disable = 0;
 	host->ios.power_mode = MMC_POWER_UNDEFINED;
 
 	mmc_claim_host(host);
@@ -2674,7 +2670,6 @@ void mmc_stop_host(struct mmc_host *host)
 	if (host->slot.cd_irq >= 0)
 		disable_irq(host->slot.cd_irq);
 
-	host->rescan_disable = 1;
 	cancel_delayed_work_sync(&host->detect);
 
 	/* clear pm flags now and let card drivers set them as needed */
@@ -2788,9 +2783,6 @@ static int mmc_pm_notify(struct notifier_block *notify_block,
 	case PM_HIBERNATION_PREPARE:
 	case PM_SUSPEND_PREPARE:
 	case PM_RESTORE_PREPARE:
-		spin_lock_irqsave(&host->lock, flags);
-		host->rescan_disable = 1;
-		spin_unlock_irqrestore(&host->lock, flags);
 		cancel_delayed_work_sync(&host->detect);
 
 		if (!host->bus_ops)
@@ -2814,10 +2806,6 @@ static int mmc_pm_notify(struct notifier_block *notify_block,
 	case PM_POST_SUSPEND:
 	case PM_POST_HIBERNATION:
 	case PM_POST_RESTORE:
-
-		spin_lock_irqsave(&host->lock, flags);
-		host->rescan_disable = 0;
-		spin_unlock_irqrestore(&host->lock, flags);
 		_mmc_detect_change(host, 0, false);
 
 	}
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index e0a3ee1..e972489 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -319,9 +319,6 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 	if (!host)
 		return NULL;
 
-	/* scanning will be enabled when we're ready */
-	host->rescan_disable = 1;
-
 again:
 	if (!ida_pre_get(&mmc_host_ida, GFP_KERNEL)) {
 		kfree(host);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 85800b4..7fbe5c0 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -330,7 +330,6 @@ struct mmc_host {
 	unsigned int		doing_retune:1;	/* re-tuning in progress */
 	unsigned int		retune_now:1;	/* do re-tuning at next req */
 
-	int			rescan_disable;	/* disable card detection */
 	int			rescan_entered;	/* used with nonremovable devices */
 
 	int			need_retune;	/* re-tuning is needed */
-- 
1.9.1

