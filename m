From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 1/2] mmc: queue: let host controllers specify maximum discard timeout
Date: Tue, 28 Jun 2011 17:16:02 +0300
Message-ID: <1309270563-28817-2-git-send-email-adrian.hunter@intel.com>
References: <1309270563-28817-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:56772 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758124Ab1F1OQW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 28 Jun 2011 10:16:22 -0400
In-Reply-To: <1309270563-28817-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Philip Rakity <prakity@marvell.com>, Adrian Hunter <adrian.hunter@intel.com>

Some host controllers will not operate without a hardware
timeout that is limited in value.  However large discards
require large timeouts, so there needs to be a way to
specify the maximum discard size.

A host controller driver may now specify the maximum discard
timeout possible so that max_discard_sectors can be calculated.

However, for eMMC when the High Capacity Erase Group Size
is not in use, the timeout calculation depends on clock
rate which may change.  For that case Preferred Erase Size
is used instead.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/card/queue.c |   33 ++++++++++++++------
 drivers/mmc/core/core.c  |   76 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/core.h |    1 +
 include/linux/mmc/host.h |    1 +
 4 files changed, 101 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 6413afa..defc11b 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -101,6 +101,27 @@ static void mmc_request(struct request_queue *q)
 		wake_up_process(mq->thread);
 }
 
+static void mmc_queue_setup_discard(struct request_queue *q,
+				    struct mmc_card *card)
+{
+	unsigned max_discard;
+
+	max_discard = mmc_calc_max_discard(card);
+	if (!max_discard)
+		return;
+
+	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, q);
+	q->limits.max_discard_sectors = max_discard;
+	if (card->erased_byte == 0)
+		q->limits.discard_zeroes_data = 1;
+	q->limits.discard_granularity = card->pref_erase << 9;
+	/* granularity must not be greater than max. discard */
+	if (card->pref_erase > max_discard)
+		q->limits.discard_granularity = 0;
+	if (mmc_can_secure_erase_trim(card))
+		queue_flag_set_unlocked(QUEUE_FLAG_SECDISCARD, q);
+}
+
 /**
  * mmc_init_queue - initialise a queue structure.
  * @mq: mmc queue
@@ -130,16 +151,8 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 
 	blk_queue_prep_rq(mq->queue, mmc_prep_request);
 	queue_flag_set_unlocked(QUEUE_FLAG_NONROT, mq->queue);
-	if (mmc_can_erase(card)) {
-		queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, mq->queue);
-		mq->queue->limits.max_discard_sectors = UINT_MAX;
-		if (card->erased_byte == 0)
-			mq->queue->limits.discard_zeroes_data = 1;
-		mq->queue->limits.discard_granularity = card->pref_erase << 9;
-		if (mmc_can_secure_erase_trim(card))
-			queue_flag_set_unlocked(QUEUE_FLAG_SECDISCARD,
-						mq->queue);
-	}
+	if (mmc_can_erase(card))
+		mmc_queue_setup_discard(mq->queue, card);
 
 #ifdef CONFIG_MMC_BLOCK_BOUNCE
 	if (host->max_segs == 1) {
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 7843efe..ac82865 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1516,6 +1516,82 @@ int mmc_erase_group_aligned(struct mmc_card *card, unsigned int from,
 }
 EXPORT_SYMBOL(mmc_erase_group_aligned);
 
+static unsigned int mmc_do_calc_max_discard(struct mmc_card *card,
+					    unsigned int arg)
+{
+	struct mmc_host *host = card->host;
+	unsigned int max_discard, x, y, qty = 0, max_qty, timeout;
+	unsigned int last_timeout = 0;
+
+	if (card->erase_shift)
+		max_qty = UINT_MAX >> card->erase_shift;
+	else if (mmc_card_sd(card))
+		max_qty = UINT_MAX;
+	else
+		max_qty = UINT_MAX / card->erase_size;
+
+	/* Find the largest qty with an OK timeout */
+	do {
+		y = 0;
+		for (x = 1; x && x <= max_qty && max_qty - x >= qty; x <<= 1) {
+			timeout = mmc_erase_timeout(card, arg, qty + x);
+			if (timeout > host->max_discard_to)
+				break;
+			if (timeout < last_timeout)
+				break;
+			last_timeout = timeout;
+			y = x;
+		}
+		qty += y;
+	} while (y);
+
+	if (!qty)
+		return 0;
+
+	if (qty == 1)
+		return 1;
+
+	/* Convert qty to sectors */
+	if (card->erase_shift)
+		max_discard = --qty << card->erase_shift;
+	else if (mmc_card_sd(card))
+		max_discard = qty;
+	else
+		max_discard = --qty * card->erase_size;
+
+	return max_discard;
+}
+
+unsigned int mmc_calc_max_discard(struct mmc_card *card)
+{
+	struct mmc_host *host = card->host;
+	unsigned int max_discard, max_trim;
+
+	if (!host->max_discard_to)
+		return UINT_MAX;
+
+	/*
+	 * Without erase_group_def set, MMC erase timeout depends on clock
+	 * frequence which can change.  In that case, the best choice is
+	 * just the preferred erase size.
+	 */
+	if (mmc_card_mmc(card) && !(card->ext_csd.erase_group_def & 1))
+		return card->pref_erase;
+
+	max_discard = mmc_do_calc_max_discard(card, MMC_ERASE_ARG);
+	if (mmc_can_trim(card)) {
+		max_trim = mmc_do_calc_max_discard(card, MMC_TRIM_ARG);
+		if (max_trim < max_discard)
+			max_discard = max_trim;
+	} else if (max_discard < card->erase_size) {
+		max_discard = 0;
+	}
+	pr_debug("%s: calculated max. discard sectors %u for timeout %u ms\n",
+		 mmc_hostname(host), max_discard, host->max_discard_to);
+	return max_discard;
+}
+EXPORT_SYMBOL(mmc_calc_max_discard);
+
 int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen)
 {
 	struct mmc_command cmd = {0};
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 791f060..86d81cf 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -155,6 +155,7 @@ extern int mmc_can_trim(struct mmc_card *card);
 extern int mmc_can_secure_erase_trim(struct mmc_card *card);
 extern int mmc_erase_group_aligned(struct mmc_card *card, unsigned int from,
 				   unsigned int nr);
+extern unsigned int mmc_calc_max_discard(struct mmc_card *card);
 
 extern int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen);
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index ac3fbac..0adecb1 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -230,6 +230,7 @@ struct mmc_host {
 	unsigned int		max_req_size;	/* maximum number of bytes in one req */
 	unsigned int		max_blk_size;	/* maximum size of one mmc block */
 	unsigned int		max_blk_count;	/* maximum number of blocks in one req */
+	unsigned int		max_discard_to;	/* max. discard timeout in ms */
 
 	/* private data */
 	spinlock_t		lock;		/* lock for claim and bus ops */
-- 
1.7.4.4

