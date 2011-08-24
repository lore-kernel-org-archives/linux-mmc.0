From: Aaron Lu <aaron.lu@amd.com>
Subject: [PATCH] mmc: sdhci: add support for re-tuning mode 2
Date: Wed, 24 Aug 2011 13:54:04 +0800
Message-ID: <1314165244-3648-1-git-send-email-aaron.lu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe001.messaging.microsoft.com ([213.199.154.204]:56102
	"EHLO AM1EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750795Ab1HXF6J (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Aug 2011 01:58:09 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, prakity@marvell.com, zhangfei.gao@gmail.com
Cc: linux-mmc@vger.kernel.org, arindam.nath@amd.com, Aaron Lu <aaron.lu@amd.com>

Hosts which support re-tuning mode 2 has the capability to indicate
the re-tuning timing by issuing re-tuning request during data transfers.
During non-data transfers, re-tuning timing is determined by either
re-tuning timer or re-tuning request.

Since there is no way to determine the host's capability to generate
re-tuning request during non-data transfers, we will start the re-tuning
timer by default for re-tuning mode 2. If we ever received a re-tuning
request during non-data transfers, that means the host is also capable
of generating re-tuning request for non-data transfers, we will then
deactivate the re-tuning timer altogether.

The SDHCI_RETUNING_TIMER flag is added to indicate the fact that the
host requires re-tuning timer to trigger the re-tuning timing.

The SDHCI_NEEDS_RETUNING, SDHCI_RETUNING_TIMER flags and the max block
count of the host will be restored to their default values since they
are affected by different cards inserted too.

Signed-off-by: Aaron Lu <aaron.lu@amd.com>
---
 drivers/mmc/host/sdhci.c  |  128 +++++++++++++++++++++++++++++++++------------
 drivers/mmc/host/sdhci.h  |    3 +
 include/linux/mmc/sdhci.h |    4 ++
 3 files changed, 102 insertions(+), 33 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 0e02cc1..f620c72 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -222,6 +222,22 @@ static void sdhci_reinit(struct sdhci_host *host)
 {
 	sdhci_init(host, 0);
 	sdhci_enable_card_detection(host);
+
+	if (host->version >= SDHCI_SPEC_300) {
+		/*
+		 * Clear re-tuning related flags, since these flags
+		 * are also affected by different cards inserted
+		 */
+		host->flags &= ~(SDHCI_NEEDS_RETUNING |
+				SDHCI_RETUNING_TIMER);
+
+		/*
+		 * restore max block count, since it might be
+		 * reduced due to re-tuning mode 1 and 2
+		 */
+		host->mmc->max_blk_count =
+			(host->quirks & SDHCI_QUIRK_NO_MULTIBLOCK) ? 1 : 65535;
+	}
 }
 
 static void sdhci_activate_led(struct sdhci_host *host)
@@ -1245,7 +1261,7 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 		present_state = sdhci_readl(host, SDHCI_PRESENT_STATE);
 		/*
-		 * Check if the re-tuning timer has already expired and there
+		 * Check if the re-tuning timing has already arrived and there
 		 * is no on-going data transfer. If so, we need to execute
 		 * tuning procedure before sending command.
 		 */
@@ -1733,34 +1749,41 @@ static int sdhci_execute_tuning(struct mmc_host *mmc)
 
 out:
 	/*
-	 * If this is the very first time we are here, we start the retuning
-	 * timer. Since only during the first time, SDHCI_NEEDS_RETUNING
-	 * flag won't be set, we check this condition before actually starting
-	 * the timer.
+	 * If this is the very first time we are here, we setup the
+	 * corresponding re-tuning condition. Since only during the
+	 * first time, SDHCI_NEEDS_RETUNING flag won't be set.
 	 */
-	if (!(host->flags & SDHCI_NEEDS_RETUNING) && host->tuning_count &&
-	    (host->tuning_mode == SDHCI_TUNING_MODE_1)) {
-		mod_timer(&host->tuning_timer, jiffies +
-			host->tuning_count * HZ);
-		/* Tuning mode 1 limits the maximum data length to 4MB */
-		mmc->max_blk_count = (4 * 1024 * 1024) / mmc->max_blk_size;
+	if (!(host->flags & SDHCI_NEEDS_RETUNING)) {
+		if (host->tuning_count &&
+			host->tuning_mode != SDHCI_TUNING_MODE_RSV) {
+			host->flags |= SDHCI_RETUNING_TIMER;
+			mod_timer(&host->tuning_timer, jiffies +
+					host->tuning_count * HZ);
+		}
+		/* Enable re-tuning event for tuning mode 2 */
+		if (host->tuning_mode == SDHCI_TUNING_MODE_2)
+			ier |= SDHCI_INT_RETUNING;
+		/* Tuning mode 1 and 2 limits the maximum data length to 4MB */
+		if (host->tuning_mode == SDHCI_TUNING_MODE_1 ||
+			host->tuning_mode == SDHCI_TUNING_MODE_2)
+			mmc->max_blk_count = (4 * 1024 * 1024) /
+				mmc->max_blk_size;
 	} else {
 		host->flags &= ~SDHCI_NEEDS_RETUNING;
-		/* Reload the new initial value for timer */
-		if (host->tuning_mode == SDHCI_TUNING_MODE_1)
+		/* Reload the new initial value for re-tuning timer */
+		if (host->flags & SDHCI_RETUNING_TIMER)
 			mod_timer(&host->tuning_timer, jiffies +
 				host->tuning_count * HZ);
 	}
 
 	/*
 	 * In case tuning fails, host controllers which support re-tuning can
-	 * try tuning again at a later time, when the re-tuning timer expires.
+	 * try tuning again at a later time, when the re-tuning timing arrives.
 	 * So for these controllers, we return 0. Since there might be other
 	 * controllers who do not have this capability, we return error for
 	 * them.
 	 */
-	if (err && host->tuning_count &&
-	    host->tuning_mode == SDHCI_TUNING_MODE_1)
+	if (err && (host->tuning_mode != SDHCI_TUNING_MODE_RSV))
 		err = 0;
 
 	sdhci_clear_set_irqs(host, SDHCI_INT_DATA_AVAIL, ier);
@@ -2050,6 +2073,18 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 		}
 	}
 
+	/*
+	 * Reload re-tuning timer if transfer complete
+	 * occured for re-tuning mode 2
+	 */
+	if ((host->flags & SDHCI_RETUNING_TIMER) &&
+		(host->tuning_mode == SDHCI_TUNING_MODE_2) &&
+		(intmask & SDHCI_INT_DATA_END)) {
+		mod_timer(&host->tuning_timer, jiffies +
+				host->tuning_count * HZ);
+		host->flags &= ~SDHCI_NEEDS_RETUNING;
+	}
+
 	if (!host->data) {
 		/*
 		 * The "data complete" interrupt is also used to
@@ -2206,6 +2241,23 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 
 	intmask &= ~SDHCI_INT_CARD_INT;
 
+	if (intmask & SDHCI_INT_RETUNING) {
+		host->flags |= SDHCI_NEEDS_RETUNING;
+		if ((host->flags & SDHCI_RETUNING_TIMER) &&
+			(host->tuning_mode == SDHCI_TUNING_MODE_2)) {
+			u32 state = sdhci_readl(host, SDHCI_PRESENT_STATE);
+			/*
+			 * If host is capable of generating re-tuning
+			 * request during non-data transfers, there is
+			 * no need to use re-tuning timer
+			 */
+			if (!(state & SDHCI_DATA_ACTIVE))
+				host->flags &= ~SDHCI_RETUNING_TIMER;
+		}
+	}
+
+	intmask &= ~SDHCI_INT_RETUNING;
+
 	if (intmask) {
 		printk(KERN_ERR "%s: Unexpected interrupt 0x%08x.\n",
 			mmc_hostname(host->mmc), intmask);
@@ -2243,12 +2295,14 @@ int sdhci_suspend_host(struct sdhci_host *host, pm_message_t state)
 
 	sdhci_disable_card_detection(host);
 
-	/* Disable tuning since we are suspending */
-	if (host->version >= SDHCI_SPEC_300 && host->tuning_count &&
-	    host->tuning_mode == SDHCI_TUNING_MODE_1) {
+	/* Disable re-tuning since we are suspending */
+	if ((host->version >= SDHCI_SPEC_300) &&
+		(host->tuning_mode != SDHCI_TUNING_MODE_RSV)) {
 		host->flags &= ~SDHCI_NEEDS_RETUNING;
-		mod_timer(&host->tuning_timer, jiffies +
-			host->tuning_count * HZ);
+		if (host->flags & SDHCI_RETUNING_TIMER)
+			del_timer_sync(&host->tuning_timer);
+		if (host->tuning_mode == SDHCI_TUNING_MODE_2)
+			sdhci_mask_irqs(host, SDHCI_INT_RETUNING);
 	}
 
 	ret = mmc_suspend_host(host->mmc);
@@ -2292,11 +2346,6 @@ int sdhci_resume_host(struct sdhci_host *host)
 	ret = mmc_resume_host(host->mmc);
 	sdhci_enable_card_detection(host);
 
-	/* Set the re-tuning expiration flag */
-	if ((host->version >= SDHCI_SPEC_300) && host->tuning_count &&
-	    (host->tuning_mode == SDHCI_TUNING_MODE_1))
-		host->flags |= SDHCI_NEEDS_RETUNING;
-
 	return ret;
 }
 
@@ -2570,12 +2619,22 @@ int sdhci_add_host(struct sdhci_host *host)
 	host->tuning_count = (caps[1] & SDHCI_RETUNING_TIMER_COUNT_MASK) >>
 			      SDHCI_RETUNING_TIMER_COUNT_SHIFT;
 
-	/*
-	 * In case Re-tuning Timer is not disabled, the actual value of
-	 * re-tuning timer will be 2 ^ (n - 1).
-	 */
-	if (host->tuning_count)
-		host->tuning_count = 1 << (host->tuning_count - 1);
+	if (host->tuning_count) {
+		/*
+		 * In case re-tuning timer is not disabled,
+		 * the actual value of re-tuning timer will be:
+		 * 0x1 - 0xb: 2 ^ (n - 1)
+		 * 0xc - 0xe: reserved
+		 * 0xf: get the value from other source
+		 */
+		if (host->tuning_count <= 0xb)
+			host->tuning_count = 1 << (host->tuning_count - 1);
+		else if (host->tuning_count == 0xf)
+			host->tuning_count = host->ops->get_tuning_count ?
+				host->ops->get_tuning_count(host) : 0;
+		else
+			host->tuning_count = 0;
+	}
 
 	/* Re-tuning mode supported by the Host Controller */
 	host->tuning_mode = (caps[1] & SDHCI_RETUNING_MODE_MASK) >>
@@ -2816,6 +2875,9 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 
 	sdhci_disable_card_detection(host);
 
+	if (host->tuning_mode == SDHCI_TUNING_MODE_2)
+		sdhci_mask_irqs(host, SDHCI_INT_RETUNING);
+
 	mmc_remove_host(host->mmc);
 
 #ifdef SDHCI_USE_LEDS_CLASS
@@ -2828,7 +2890,7 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 	free_irq(host->irq, host);
 
 	del_timer_sync(&host->timer);
-	if (host->version >= SDHCI_SPEC_300)
+	if (host->flags & SDHCI_RETUNING_TIMER)
 		del_timer_sync(&host->tuning_timer);
 
 	tasklet_kill(&host->card_tasklet);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 745c42f..ef4a0a3 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -64,6 +64,7 @@
 #define SDHCI_PRESENT_STATE	0x24
 #define  SDHCI_CMD_INHIBIT	0x00000001
 #define  SDHCI_DATA_INHIBIT	0x00000002
+#define  SDHCI_DATA_ACTIVE	0x00000004
 #define  SDHCI_DOING_WRITE	0x00000100
 #define  SDHCI_DOING_READ	0x00000200
 #define  SDHCI_SPACE_AVAILABLE	0x00000400
@@ -126,6 +127,7 @@
 #define  SDHCI_INT_CARD_INSERT	0x00000040
 #define  SDHCI_INT_CARD_REMOVE	0x00000080
 #define  SDHCI_INT_CARD_INT	0x00000100
+#define  SDHCI_INT_RETUNING	0x00001000
 #define  SDHCI_INT_ERROR	0x00008000
 #define  SDHCI_INT_TIMEOUT	0x00010000
 #define  SDHCI_INT_CRC		0x00020000
@@ -273,6 +275,7 @@ struct sdhci_ops {
 	void	(*platform_reset_enter)(struct sdhci_host *host, u8 mask);
 	void	(*platform_reset_exit)(struct sdhci_host *host, u8 mask);
 	int	(*set_uhs_signaling)(struct sdhci_host *host, unsigned int uhs);
+	int	(*get_tuning_count)(struct sdhci_host *host);
 
 };
 
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 5666f3a..938a4f5 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -115,6 +115,7 @@ struct sdhci_host {
 #define SDHCI_NEEDS_RETUNING	(1<<5)	/* Host needs retuning */
 #define SDHCI_AUTO_CMD12	(1<<6)	/* Auto CMD12 support */
 #define SDHCI_AUTO_CMD23	(1<<7)	/* Auto CMD23 support */
+#define SDHCI_RETUNING_TIMER	(1<<8)	/* Host uses re-tuning timer */
 
 	unsigned int version;	/* SDHCI spec. version */
 
@@ -158,6 +159,9 @@ struct sdhci_host {
 	unsigned int		tuning_count;	/* Timer count for re-tuning */
 	unsigned int		tuning_mode;	/* Re-tuning mode supported by host */
 #define SDHCI_TUNING_MODE_1	0
+#define SDHCI_TUNING_MODE_2	1
+#define SDHCI_TUNING_MODE_3	2
+#define SDHCI_TUNING_MODE_RSV	3
 	struct timer_list	tuning_timer;	/* Timer for tuning */
 
 	unsigned long private[0] ____cacheline_aligned;
-- 
1.7.1


