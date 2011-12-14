From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH V2 2/2] mmc: Minimize resume-time by deferring resume
Date: Wed, 14 Dec 2011 16:06:10 +0100
Message-ID: <1323875170-7103-3-git-send-email-ulf.hansson@stericsson.com>
References: <1323875170-7103-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog116.obsmtp.com ([207.126.144.141]:55152 "EHLO
	eu1sys200aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757295Ab1LNPHE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Dec 2011 10:07:04 -0500
In-Reply-To: <1323875170-7103-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

Typically an sd/mmc card takes around 200 - 1100 ms to
initialize when the power to the card has been cut, which
is what happens during a suspend/resume sequence.

All device's resume time adds up to the total kernel resume
time. Some use cases requires the kernel to be resumed fast,
to be able to meet deadlines. One use case example is WLAN
SOFT_AP, but there are certainly more.

This patch schedules a delayed work to do a deferred resume
of the mmc host, if the bus holds a card of SD or MMC type.
The reason for not supporting SDIO and SDcombo cards at this
stage, is because the SDIO API is synchronus, which complicates
request locking mechanism when waiting for a deferred resume to
be completed.

While waiting for a deferred resume to be completed, detect works
are prevented from doing a new rescan. If a mmcblk request arrives,
the deferred resume will be synced immediately.

The deferred resume is scheduled 3000 ms after the resume request
arrived. The idea behind this timer value is to let the mmc host
being able to accept a new suspend request before it has been
deferred resumed and thus not increase the resume to suspend time
if not really needed.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
---

Changes in v2:
	- Rebased patch on latest version of mmc-next

---
 drivers/mmc/card/block.c |    8 ++++++++
 drivers/mmc/core/core.c  |   36 +++++++++++++++++++++++++++++++++++-
 drivers/mmc/core/core.h  |    1 +
 drivers/mmc/core/host.c  |    1 +
 include/linux/mmc/host.h |   16 ++++++++++++++++
 5 files changed, 61 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 4b62d1f..a4d8ae4 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1364,6 +1364,14 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 	struct mmc_blk_data *md = mq->data;
 	struct mmc_card *card = md->queue.card;
 
+	/*
+	 * We must make sure we have not claimed the host before
+	 * doing a flush to prevent deadlock, thus we check if
+	 * the host needs a resume first.
+	 */
+	if (mmc_host_needs_resume(card->host))
+		mmc_resume_host_sync(card->host);
+
 	if (req && !mq->mqrq_prev->req)
 		/* claim host only for the first request */
 		mmc_claim_host(card->host);
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index a2aa860..4706284 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2099,7 +2099,7 @@ void mmc_rescan(struct work_struct *work)
 		container_of(work, struct mmc_host, detect.work);
 	int i;
 
-	if (host->rescan_disable)
+	if (host->rescan_disable || mmc_host_needs_resume(host))
 		return;
 
 	mmc_bus_get(host);
@@ -2354,7 +2354,13 @@ int mmc_suspend_host(struct mmc_host *host)
 	if (host->caps & MMC_CAP_DISABLE)
 		cancel_delayed_work(&host->disable);
 	cancel_delayed_work(&host->detect);
+	cancel_delayed_work_sync(&host->resume);
 	mmc_flush_scheduled_work();
+
+	/* Skip suspend, if deferred resume were scheduled but not completed. */
+	if (mmc_host_needs_resume(host))
+		return 0;
+
 	err = mmc_cache_ctrl(host, 0);
 	if (err)
 		goto out;
@@ -2393,6 +2399,10 @@ int mmc_suspend_host(struct mmc_host *host)
 				mmc_release_host(host);
 				host->pm_flags = 0;
 				err = 0;
+			} else if (mmc_card_mmc(host->card) ||
+				   mmc_card_sd(host->card)) {
+				host->pm_state |= MMC_HOST_DEFERRED_RESUME |
+						  MMC_HOST_NEEDS_RESUME;
 			}
 		} else {
 			err = -EBUSY;
@@ -2417,6 +2427,12 @@ int mmc_resume_host(struct mmc_host *host)
 {
 	int err = 0;
 
+	if (mmc_host_deferred_resume(host)) {
+		mmc_schedule_delayed_work(&host->resume,
+					  msecs_to_jiffies(3000));
+		return 0;
+	}
+
 	mmc_bus_get(host);
 	if (host->bus_ops && !host->bus_dead) {
 		if (!mmc_card_keep_power(host)) {
@@ -2451,6 +2467,24 @@ int mmc_resume_host(struct mmc_host *host)
 }
 EXPORT_SYMBOL(mmc_resume_host);
 
+void mmc_resume_work(struct work_struct *work)
+{
+	struct mmc_host *host =
+		container_of(work, struct mmc_host, resume.work);
+
+	host->pm_state &= ~MMC_HOST_DEFERRED_RESUME;
+	mmc_resume_host(host);
+	host->pm_state &= ~MMC_HOST_NEEDS_RESUME;
+
+	mmc_detect_change(host, 0);
+}
+
+void mmc_resume_host_sync(struct mmc_host *host)
+{
+	flush_delayed_work_sync(&host->resume);
+}
+EXPORT_SYMBOL(mmc_resume_host_sync);
+
 /* Do the card removal on suspend if card is assumed removeable
  * Do that in pm notifier while userspace isn't yet frozen, so we will be able
    to sync the card.
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 3400924..c894a3f 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -59,6 +59,7 @@ static inline void mmc_delay(unsigned int ms)
 void mmc_rescan(struct work_struct *work);
 void mmc_start_host(struct mmc_host *host);
 void mmc_stop_host(struct mmc_host *host);
+void mmc_resume_work(struct work_struct *work);
 
 int _mmc_detect_card_removed(struct mmc_host *host);
 
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index c152ce0..d6f955a 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -331,6 +331,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 	init_waitqueue_head(&host->wq);
 	INIT_DELAYED_WORK(&host->detect, mmc_rescan);
 	INIT_DELAYED_WORK_DEFERRABLE(&host->disable, mmc_host_deeper_disable);
+	INIT_DELAYED_WORK(&host->resume, mmc_resume_work);
 #ifdef CONFIG_PM
 	host->pm_notify.notifier_call = mmc_pm_notify;
 #endif
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 9a03d03..90dd299 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -301,6 +301,11 @@ struct mmc_host {
 	struct delayed_work	detect;
 	int			detect_change;	/* card detect flag */
 
+	struct delayed_work	resume;		/* deferred resume work */
+	unsigned int		pm_state;	/* used for deferred resume */
+#define MMC_HOST_DEFERRED_RESUME	(1 << 0)
+#define MMC_HOST_NEEDS_RESUME		(1 << 1)
+
 	const struct mmc_bus_ops *bus_ops;	/* current bus driver */
 	unsigned int		bus_refs;	/* reference counter */
 
@@ -349,6 +354,7 @@ static inline void *mmc_priv(struct mmc_host *host)
 
 extern int mmc_suspend_host(struct mmc_host *);
 extern int mmc_resume_host(struct mmc_host *);
+extern void mmc_resume_host_sync(struct mmc_host *);
 
 extern int mmc_power_save_host(struct mmc_host *host);
 extern int mmc_power_restore_host(struct mmc_host *host);
@@ -428,4 +434,14 @@ static inline int mmc_boot_partition_access(struct mmc_host *host)
 	return !(host->caps2 & MMC_CAP2_BOOTPART_NOACC);
 }
 
+static inline int mmc_host_deferred_resume(struct mmc_host *host)
+{
+	return host->pm_state & MMC_HOST_DEFERRED_RESUME;
+}
+
+static inline int mmc_host_needs_resume(struct mmc_host *host)
+{
+	return host->pm_state & MMC_HOST_NEEDS_RESUME;
+}
+
 #endif /* LINUX_MMC_HOST_H */
-- 
1.7.5.4

