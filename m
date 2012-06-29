From: Aaron Lu <aaron.lu@amd.com>
Subject: [PATCH v2 2/2] mmc: sdhci: A new flag SDHCI_NEEDS_RETUNING_TIMER
Date: Fri, 29 Jun 2012 16:17:32 +0800
Message-ID: <1340957852-28936-3-git-send-email-aaron.lu@amd.com>
References: <1340957852-28936-1-git-send-email-aaron.lu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from [216.32.180.14] ([216.32.180.14]:4581 "EHLO
	va3outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751258Ab2F2ISf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Jun 2012 04:18:35 -0400
In-Reply-To: <1340957852-28936-1-git-send-email-aaron.lu@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>, Aaron Lu <aaron.lu@amd.com>

Add a new flag of SDHCI_NEEDS_RETUNING_TIMER to represent if the host
currently needs retuning timer when driving the card inserted.

This flag is set when the host does tuning the first time for the card
and is used afterwards whenever needs to decide if the host is currently
using a retuning timer.

This flag is cleared when the card is removed in sdhci_reinit.

The set/clear of the flag and the start/stop of the retuning timer is
associated with the card's init/remove time, so there is no need to
touch it when the host is to be removed as at that time the card should
have already been removed.

Signed-off-by: Aaron Lu <aaron.lu@amd.com>
---
 drivers/mmc/host/sdhci.c  | 29 +++++++++++------------------
 include/linux/mmc/sdhci.h |  1 +
 2 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7e182ad..a02077a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -250,8 +250,9 @@ static void sdhci_reinit(struct sdhci_host *host)
 	 * applicable to UHS-I cards. So reset these fields to their initial
 	 * value when card is removed.
 	 */
-	if (host->version >= SDHCI_SPEC_300 && host->tuning_count &&
-			host->tuning_mode == SDHCI_TUNING_MODE_1) {
+	if (host->flags & SDHCI_NEEDS_RETUNING_TIMER) {
+		host->flags &= ~SDHCI_NEEDS_RETUNING_TIMER;
+
 		del_timer_sync(&host->tuning_timer);
 		host->flags &= ~SDHCI_NEEDS_RETUNING;
 		host->mmc->max_blk_count =
@@ -1872,6 +1873,7 @@ out:
 	 */
 	if (!(host->flags & SDHCI_NEEDS_RETUNING) && host->tuning_count &&
 	    (host->tuning_mode == SDHCI_TUNING_MODE_1)) {
+		host->flags |= SDHCI_NEEDS_RETUNING_TIMER;
 		mod_timer(&host->tuning_timer, jiffies +
 			host->tuning_count * HZ);
 		/* Tuning mode 1 limits the maximum data length to 4MB */
@@ -1889,10 +1891,9 @@ out:
 	 * try tuning again at a later time, when the re-tuning timer expires.
 	 * So for these controllers, we return 0. Since there might be other
 	 * controllers who do not have this capability, we return error for
-	 * them.
+	 * them. SDHCI_NEEDS_RETUNING_TIMER means the host supports re-tuning.
 	 */
-	if (err && host->tuning_count &&
-	    host->tuning_mode == SDHCI_TUNING_MODE_1)
+	if (err && (host->flags & SDHCI_NEEDS_RETUNING_TIMER))
 		err = 0;
 
 	sdhci_clear_set_irqs(host, SDHCI_INT_DATA_AVAIL, ier);
@@ -2399,7 +2400,6 @@ out:
 int sdhci_suspend_host(struct sdhci_host *host)
 {
 	int ret;
-	bool has_tuning_timer;
 
 	if (host->ops->platform_suspend)
 		host->ops->platform_suspend(host);
@@ -2407,16 +2407,14 @@ int sdhci_suspend_host(struct sdhci_host *host)
 	sdhci_disable_card_detection(host);
 
 	/* Disable tuning since we are suspending */
-	has_tuning_timer = host->version >= SDHCI_SPEC_300 &&
-		host->tuning_count && host->tuning_mode == SDHCI_TUNING_MODE_1;
-	if (has_tuning_timer) {
+	if (host->flags & SDHCI_NEEDS_RETUNING_TIMER) {
 		del_timer_sync(&host->tuning_timer);
 		host->flags &= ~SDHCI_NEEDS_RETUNING;
 	}
 
 	ret = mmc_suspend_host(host->mmc);
 	if (ret) {
-		if (has_tuning_timer) {
+		if (host->flags & SDHCI_NEEDS_RETUNING_TIMER) {
 			host->flags |= SDHCI_NEEDS_RETUNING;
 			mod_timer(&host->tuning_timer, jiffies +
 					host->tuning_count * HZ);
@@ -2467,8 +2465,7 @@ int sdhci_resume_host(struct sdhci_host *host)
 		host->ops->platform_resume(host);
 
 	/* Set the re-tuning expiration flag */
-	if ((host->version >= SDHCI_SPEC_300) && host->tuning_count &&
-	    (host->tuning_mode == SDHCI_TUNING_MODE_1))
+	if (host->flags & SDHCI_NEEDS_RETUNING_TIMER)
 		host->flags |= SDHCI_NEEDS_RETUNING;
 
 	return ret;
@@ -2507,8 +2504,7 @@ int sdhci_runtime_suspend_host(struct sdhci_host *host)
 	int ret = 0;
 
 	/* Disable tuning since we are suspending */
-	if (host->version >= SDHCI_SPEC_300 &&
-	    host->tuning_mode == SDHCI_TUNING_MODE_1) {
+	if (host->flags & SDHCI_NEEDS_RETUNING_TIMER) {
 		del_timer_sync(&host->tuning_timer);
 		host->flags &= ~SDHCI_NEEDS_RETUNING;
 	}
@@ -2549,8 +2545,7 @@ int sdhci_runtime_resume_host(struct sdhci_host *host)
 		sdhci_do_enable_preset_value(host, true);
 
 	/* Set the re-tuning expiration flag */
-	if ((host->version >= SDHCI_SPEC_300) && host->tuning_count &&
-	    (host->tuning_mode == SDHCI_TUNING_MODE_1))
+	if (host->flags & SDHCI_NEEDS_RETUNING_TIMER)
 		host->flags |= SDHCI_NEEDS_RETUNING;
 
 	spin_lock_irqsave(&host->lock, flags);
@@ -3098,8 +3093,6 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 	free_irq(host->irq, host);
 
 	del_timer_sync(&host->timer);
-	if (host->version >= SDHCI_SPEC_300)
-		del_timer_sync(&host->tuning_timer);
 
 	tasklet_kill(&host->card_tasklet);
 	tasklet_kill(&host->finish_tasklet);
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index e9051e1..1493bf3 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -122,6 +122,7 @@ struct sdhci_host {
 #define SDHCI_PV_ENABLED	(1<<8)	/* Preset value enabled */
 #define SDHCI_SDIO_IRQ_ENABLED	(1<<9)	/* SDIO irq enabled */
 #define SDHCI_HS200_NEEDS_TUNING (1<<10)	/* HS200 needs tuning */
+#define SDHCI_NEEDS_RETUNING_TIMER (1<<11)	/* Host needs retuning timer */
 
 	unsigned int version;	/* SDHCI spec. version */
 
-- 
1.7.11.1


