From: Jeremie Samuel <jeremie.samuel.ext@parrot.com>
Subject: [PATCH 2/8] sdhci: Turn tuning timeout timer into delayed work
Date: Fri, 24 May 2013 18:00:36 +0200
Message-ID: <1369411242-20515-3-git-send-email-jeremie.samuel.ext@parrot.com>
References: <1369411242-20515-1-git-send-email-jeremie.samuel.ext@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:35668 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755337Ab3EXQBc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 24 May 2013 12:01:32 -0400
In-Reply-To: <1369411242-20515-1-git-send-email-jeremie.samuel.ext@parrot.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: matthieu.castet@parrot.com, gregor.boirie@parrot.com, Jeremie Samuel <jeremie.samuel.ext@parrot.com>

Same as previous patch

Signed-off-by: Jeremie Samuel <jeremie.samuel.ext@parrot.com>
---
 drivers/mmc/host/sdhci.c  |   46 ++++++++++++++++++++++-----------------------
 include/linux/mmc/sdhci.h |    2 +-
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9d75338..7d7033b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -53,7 +53,7 @@ static void sdhci_finish_data(struct sdhci_host *);
 static void sdhci_send_command(struct sdhci_host *, struct mmc_command *);
 static void sdhci_finish_command(struct sdhci_host *);
 static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
-static void sdhci_tuning_timer(unsigned long data);
+static void sdhci_tuning_timeout_work(struct work_struct *wk);
 static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
 
 #ifdef CONFIG_PM_RUNTIME
@@ -256,7 +256,7 @@ static void sdhci_reinit(struct sdhci_host *host)
 	if (host->flags & SDHCI_USING_RETUNING_TIMER) {
 		host->flags &= ~SDHCI_USING_RETUNING_TIMER;
 
-		del_timer_sync(&host->tuning_timer);
+		flush_delayed_work(&host->tuning_timeout_work);
 		host->flags &= ~SDHCI_NEEDS_RETUNING;
 		host->mmc->max_blk_count =
 			(host->quirks & SDHCI_QUIRK_NO_MULTIBLOCK) ? 1 : 65535;
@@ -1363,7 +1363,7 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 		present_state = sdhci_readl(host, SDHCI_PRESENT_STATE);
 		/*
-		 * Check if the re-tuning timer has already expired and there
+		 * Check if the re-tuning timeout has already expired and there
 		 * is no on-going data transfer. If so, we need to execute
 		 * tuning procedure before sending command.
 		 */
@@ -1978,32 +1978,33 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 out:
 	/*
 	 * If this is the very first time we are here, we start the retuning
-	 * timer. Since only during the first time, SDHCI_NEEDS_RETUNING
-	 * flag won't be set, we check this condition before actually starting
-	 * the timer.
+	 * timeout workqueue. Since only during the first time,
+	 * SDHCI_NEEDS_RETUNING flag won't be set, we check this condition
+	 * before actually starting the timeout worqueue.
 	 */
 	if (!(host->flags & SDHCI_NEEDS_RETUNING) && host->tuning_count &&
 	    (host->tuning_mode == SDHCI_TUNING_MODE_1)) {
 		host->flags |= SDHCI_USING_RETUNING_TIMER;
-		mod_timer(&host->tuning_timer, jiffies +
+		schedule_delayed_work(&host->tuning_timeout_work,
 			host->tuning_count * HZ);
 		/* Tuning mode 1 limits the maximum data length to 4MB */
 		mmc->max_blk_count = (4 * 1024 * 1024) / mmc->max_blk_size;
 	} else {
 		host->flags &= ~SDHCI_NEEDS_RETUNING;
-		/* Reload the new initial value for timer */
+		/* Reload the new initial value for timeout workqueue */
 		if (host->tuning_mode == SDHCI_TUNING_MODE_1)
-			mod_timer(&host->tuning_timer, jiffies +
+			schedule_delayed_work(&host->tuning_timeout_work,
 				host->tuning_count * HZ);
 	}
 
 	/*
 	 * In case tuning fails, host controllers which support re-tuning can
-	 * try tuning again at a later time, when the re-tuning timer expires.
+	 * try tuning again at a later time, when the re-tuning timeout
+	 * workqueue expires.
 	 * So for these controllers, we return 0. Since there might be other
 	 * controllers who do not have this capability, we return error for
 	 * them. SDHCI_USING_RETUNING_TIMER means the host is currently using
-	 * a retuning timer to do the retuning for the card.
+	 * a retuning timeout workqueue to do the retuning for the card.
 	 */
 	if (err && (host->flags & SDHCI_USING_RETUNING_TIMER))
 		err = 0;
@@ -2185,12 +2186,12 @@ static void sdhci_timeout_work(struct work_struct *wk)
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
-static void sdhci_tuning_timer(unsigned long data)
+static void sdhci_tuning_timeout_work(struct work_struct *wk)
 {
 	struct sdhci_host *host;
 	unsigned long flags;
 
-	host = (struct sdhci_host *)data;
+	host = container_of(wk, struct sdhci_host, tuning_timeout_work.work);
 
 	spin_lock_irqsave(&host->lock, flags);
 
@@ -2537,7 +2538,7 @@ int sdhci_suspend_host(struct sdhci_host *host)
 
 	/* Disable tuning since we are suspending */
 	if (host->flags & SDHCI_USING_RETUNING_TIMER) {
-		del_timer_sync(&host->tuning_timer);
+		flush_delayed_work(&host->tuning_timeout_work);
 		host->flags &= ~SDHCI_NEEDS_RETUNING;
 	}
 
@@ -2545,7 +2546,7 @@ int sdhci_suspend_host(struct sdhci_host *host)
 	if (ret) {
 		if (host->flags & SDHCI_USING_RETUNING_TIMER) {
 			host->flags |= SDHCI_NEEDS_RETUNING;
-			mod_timer(&host->tuning_timer, jiffies +
+			schedule_delayed_work(&host->tuning_timeout_work,
 					host->tuning_count * HZ);
 		}
 
@@ -2633,7 +2634,7 @@ int sdhci_runtime_suspend_host(struct sdhci_host *host)
 
 	/* Disable tuning since we are suspending */
 	if (host->flags & SDHCI_USING_RETUNING_TIMER) {
-		del_timer_sync(&host->tuning_timer);
+		flush_delayed_work(&host->tuning_timeout_work);
 		host->flags &= ~SDHCI_NEEDS_RETUNING;
 	}
 
@@ -2987,13 +2988,13 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (caps[1] & SDHCI_DRIVER_TYPE_D)
 		mmc->caps |= MMC_CAP_DRIVER_TYPE_D;
 
-	/* Initial value for re-tuning timer count */
+	/* Initial value for re-tuning timeout count */
 	host->tuning_count = (caps[1] & SDHCI_RETUNING_TIMER_COUNT_MASK) >>
 			      SDHCI_RETUNING_TIMER_COUNT_SHIFT;
 
 	/*
-	 * In case Re-tuning Timer is not disabled, the actual value of
-	 * re-tuning timer will be 2 ^ (n - 1).
+	 * In case Re-tuning Timeout is not disabled, the actual value of
+	 * re-tuning timeout will be 2 ^ (n - 1).
 	 */
 	if (host->tuning_count)
 		host->tuning_count = 1 << (host->tuning_count - 1);
@@ -3169,10 +3170,9 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (host->version >= SDHCI_SPEC_300) {
 		init_waitqueue_head(&host->buf_ready_int);
 
-		/* Initialize re-tuning timer */
-		init_timer(&host->tuning_timer);
-		host->tuning_timer.data = (unsigned long)host;
-		host->tuning_timer.function = sdhci_tuning_timer;
+		/* Initialize re-tuning timeout work */
+		INIT_DELAYED_WORK(&host->tuning_timeout_work,
+					sdhci_tuning_timeout_work);
 	}
 
 	ret = request_irq(host->irq, sdhci_irq, IRQF_SHARED,
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 0f14546..d0f4845 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -175,7 +175,7 @@ struct sdhci_host {
 	unsigned int		tuning_count;	/* Timer count for re-tuning */
 	unsigned int		tuning_mode;	/* Re-tuning mode supported by host */
 #define SDHCI_TUNING_MODE_1	0
-	struct timer_list	tuning_timer;	/* Timer for tuning */
+	struct delayed_work	tuning_timeout_work;	/* Work for tuning timeouts */
 
 	unsigned long private[0] ____cacheline_aligned;
 };
-- 
1.7.10.4

