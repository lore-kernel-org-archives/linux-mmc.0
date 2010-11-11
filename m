From: "Chuanxiao.Dong" <chuanxiao.dong@intel.com>
Subject: [PATCH v1 2/3]set a suitable max_discard_sectors value for mmc
	queue
Date: Thu, 11 Nov 2010 17:05:35 +0800
Message-ID: <20101111090535.GC18170@intel.com>
Reply-To: "Chuanxiao.Dong" <chuanxiao.dong@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:8448 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751042Ab0KKJHY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Nov 2010 04:07:24 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: adrian.hunter@nokia.com, linux-mmc@vger.kernel.org

>From 40c55714de6b4c9eb2c7105c8b01e70d645c1089 Mon Sep 17 00:00:00 2001
From: Chuanxiao Dong <chuanxiao.dong@intel.com>
Date: Thu, 11 Nov 2010 15:42:18 +0800
Subject: [PATCH 2/3] mmc: set a suitable max_discard_sectors value for mmc queue

For some SDHCI host controller, eraseing unlimited sectors one
time may caused a data timeout interrupt since the erasing time
is larger than the host timeout time.

If host driver implemented get_tmclk callback for mmc_host_ops,
mmc_set_discard_limit() will calculated a suitable max_discard_sectors
value for mmc queue. Otherwise, use the unlimited value.

Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
---
 drivers/mmc/card/queue.c |    8 ++-
 drivers/mmc/core/core.c  |  145 ++++++++++++++++++++++++++++++++++++---------
 include/linux/mmc/core.h |    1 +
 include/linux/mmc/host.h |    3 +
 4 files changed, 127 insertions(+), 30 deletions(-)

diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 4e42d03..f665c62 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -131,7 +131,13 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card, spinlock_t *lock
 	queue_flag_set_unlocked(QUEUE_FLAG_NONROT, mq->queue);
 	if (mmc_can_erase(card)) {
 		queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, mq->queue);
-		mq->queue->limits.max_discard_sectors = UINT_MAX;
+		/* get a suitable max_discard_sectors limitation */
+		ret = mmc_set_discard_limit(card);
+		if (ret > 0)
+			mq->queue->limits.max_discard_sectors = ret;
+		else
+			mq->queue->limits.max_discard_sectors = UINT_MAX;
+
 		if (card->erased_byte == 0)
 			mq->queue->limits.discard_zeroes_data = 1;
 		if (!mmc_can_trim(card) && is_power_of_2(card->erase_size)) {
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index d48bb26..46b66f8 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1160,6 +1160,41 @@ void mmc_init_erase(struct mmc_card *card)
 	}
 }
 
+static unsigned int mmc_calc_mmc_erase_timeout(struct mmc_card *card)
+{
+	unsigned int erase_timeout = 0;
+
+	/* CSD Erase Group Size uses write timeout */
+	unsigned int mult = (10 << card->csd.r2w_factor);
+	unsigned int timeout_clks = card->csd.tacc_clks * mult;
+	unsigned int timeout_us;
+
+	/* Avoid overflow: e.g. tacc_ns=80000000 mult=1280 */
+	if (card->csd.tacc_ns < 1000000)
+		timeout_us = (card->csd.tacc_ns * mult) / 1000;
+	else
+		timeout_us = (card->csd.tacc_ns / 1000) * mult;
+
+	/*
+	 * ios.clock is only a target.  The real clock rate might be
+	 * less but not that much less, so fudge it by multiplying by 2.
+	 */
+	timeout_clks <<= 1;
+	timeout_us += (timeout_clks * 1000) /
+			  (card->host->ios.clock / 1000);
+
+	erase_timeout = timeout_us / 1000;
+
+	/*
+	 * Theoretically, the calculation could underflow so round up
+	 * to 1ms in that case.
+	 */
+	if (!erase_timeout)
+		erase_timeout = 1;
+
+	return erase_timeout;
+}
+
 static void mmc_set_mmc_erase_timeout(struct mmc_card *card,
 				      struct mmc_command *cmd,
 				      unsigned int arg, unsigned int qty)
@@ -1172,35 +1207,8 @@ static void mmc_set_mmc_erase_timeout(struct mmc_card *card,
 			erase_timeout = card->ext_csd.trim_timeout;
 		else
 			erase_timeout = card->ext_csd.hc_erase_timeout;
-	} else {
-		/* CSD Erase Group Size uses write timeout */
-		unsigned int mult = (10 << card->csd.r2w_factor);
-		unsigned int timeout_clks = card->csd.tacc_clks * mult;
-		unsigned int timeout_us;
-
-		/* Avoid overflow: e.g. tacc_ns=80000000 mult=1280 */
-		if (card->csd.tacc_ns < 1000000)
-			timeout_us = (card->csd.tacc_ns * mult) / 1000;
-		else
-			timeout_us = (card->csd.tacc_ns / 1000) * mult;
-
-		/*
-		 * ios.clock is only a target.  The real clock rate might be
-		 * less but not that much less, so fudge it by multiplying by 2.
-		 */
-		timeout_clks <<= 1;
-		timeout_us += (timeout_clks * 1000) /
-			      (card->host->ios.clock / 1000);
-
-		erase_timeout = timeout_us / 1000;
-
-		/*
-		 * Theoretically, the calculation could underflow so round up
-		 * to 1ms in that case.
-		 */
-		if (!erase_timeout)
-			erase_timeout = 1;
-	}
+	} else
+		erase_timeout = mmc_calc_mmc_erase_timeout(card);
 
 	/* Multiplier for secure operations */
 	if (arg & MMC_SECURE_ARGS) {
@@ -1458,6 +1466,85 @@ int mmc_erase_group_aligned(struct mmc_card *card, unsigned int from,
 }
 EXPORT_SYMBOL(mmc_erase_group_aligned);
 
+/*
+ * mmc_set_discard_limit: set the max_discard_sectors according
+ * to host controller timeout capability.
+ * */
+int mmc_set_discard_limit(struct mmc_card *card)
+{
+	struct mmc_host *host;
+	unsigned int max, nr = 0;
+	unsigned int host_timeout;
+	host = card->host;
+	/* get host controller timeout clks to caculate
+	 * the suitable erase timeout value.
+	 * */
+	if (host->ops && host->ops->get_tmclk)
+		host_timeout = host->ops->get_tmclk(host);
+	else
+		return nr;
+	/* max timeout in ms */
+	max = (1 << 27) / host_timeout;
+	if (max == 0)
+		goto out;
+
+	if (mmc_card_sd(card)) {
+		/* time in ms */
+		max -= card->ssr.erase_offset;
+		if (card->ssr.erase_timeout && max > 0) {
+			nr = (max / card->ssr.erase_timeout);
+			if (card->erase_shift)
+				nr <<= card->erase_shift;
+		}
+	}
+
+	if (mmc_card_mmc(card)) {
+		unsigned int erase_timeout, mult;
+		if (card->ext_csd.erase_group_def & 1) {
+			/* Use High Capacity erase timeout
+			 * so here to choose the maximum timeout value
+			 * */
+			erase_timeout = (card->ext_csd.trim_timeout >
+				card->ext_csd.hc_erase_timeout) ?
+				card->ext_csd.trim_timeout :
+				card->ext_csd.hc_erase_timeout;
+		} else
+			erase_timeout = mmc_calc_mmc_erase_timeout(card);
+
+		/* If driver send sec trim/erase command, timeout value
+		 * should be more larger
+		 * */
+		mult = (card->ext_csd.sec_trim_mult >
+			card->ext_csd.sec_erase_mult) ?
+			card->ext_csd.sec_trim_mult :
+			card->ext_csd.sec_erase_mult;
+		erase_timeout *= mult;
+		if (erase_timeout) {
+				nr = (max / erase_timeout);
+			if (card->erase_shift)
+				nr <<= card->erase_shift;
+			else
+				nr *= card->erase_size;
+		}
+	}
+out:
+	if (nr == 0) {
+		/* Have to set a small limitation for request queue
+		 * to ensure that host controller won't generate a
+		 * timeout interrupt during waiting, here let limitation
+		 * to be 1 erase block. And this will let TRIM/ERASE
+		 * performance much lower.
+		 * */
+		nr = 1;
+		if (card->erase_shift)
+			nr <<= card->erase_shift;
+		else
+			nr *= card->erase_size;
+	}
+	return nr;
+}
+EXPORT_SYMBOL(mmc_set_discard_limit);
+
 int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen)
 {
 	struct mmc_command cmd;
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 64e013f..ffddd1f 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -152,6 +152,7 @@ extern int mmc_can_trim(struct mmc_card *card);
 extern int mmc_can_secure_erase_trim(struct mmc_card *card);
 extern int mmc_erase_group_aligned(struct mmc_card *card, unsigned int from,
 				   unsigned int nr);
+extern int mmc_set_discard_limit(struct mmc_card *card);
 
 extern int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen);
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index f108cee..63f1c9e 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -117,6 +117,9 @@ struct mmc_host_ops {
 
 	/* optional callback for HC quirks */
 	void	(*init_card)(struct mmc_host *host, struct mmc_card *card);
+
+	/* Get host controller timeout clk */
+	unsigned int (*get_tmclk)(struct mmc_host *host);
 };
 
 struct mmc_card;
-- 
1.6.6.1

