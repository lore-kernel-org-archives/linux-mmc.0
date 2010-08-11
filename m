From: akpm@linux-foundation.org
Subject: [patch 16/24] mmc_block: add discard support
Date: Wed, 11 Aug 2010 14:17:47 -0700
Message-ID: <201008112117.o7BLHmxf015019@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33533 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751392Ab0HKVSP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Aug 2010 17:18:15 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, adrian.hunter@nokia.com, axboe@kernel.dk, bengardiner@nanometrics.ca, hch@lst.de, kmpark@infradead.org, linux-mmc@vger.kernel.org, madhu.cr@ti.com

From: Adrian Hunter <adrian.hunter@nokia.com>

Enable MMC to service discard requests.  In the case of SD and MMC cards
that do not support trim, discards become erases.  In the case of cards
(MMC) that only allow erases in multiples of erase group size, round to
the nearest completely discarded erase group.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
Acked-by: Jens Axboe <axboe@kernel.dk>
Cc: Kyungmin Park <kmpark@infradead.org>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ben Gardiner <bengardiner@nanometrics.ca>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/card/block.c |   42 ++++++++++++++++++++++++++++++++++++-
 drivers/mmc/card/queue.c |   16 ++++++++++++--
 2 files changed, 55 insertions(+), 3 deletions(-)

diff -puN drivers/mmc/card/block.c~mmc_block-add-discard-support drivers/mmc/card/block.c
--- a/drivers/mmc/card/block.c~mmc_block-add-discard-support
+++ a/drivers/mmc/card/block.c
@@ -247,7 +247,40 @@ static u32 get_card_status(struct mmc_ca
 	return cmd.resp[0];
 }
 
-static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
+static int mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
+{
+	struct mmc_blk_data *md = mq->data;
+	struct mmc_card *card = md->queue.card;
+	unsigned int from, nr, arg;
+	int err = 0;
+
+	mmc_claim_host(card->host);
+
+	if (!mmc_can_erase(card)) {
+		err = -EOPNOTSUPP;
+		goto out;
+	}
+
+	from = blk_rq_pos(req);
+	nr = blk_rq_sectors(req);
+
+	if (mmc_can_trim(card))
+		arg = MMC_TRIM_ARG;
+	else
+		arg = MMC_ERASE_ARG;
+
+	err = mmc_erase(card, from, nr, arg);
+out:
+	spin_lock_irq(&md->lock);
+	__blk_end_request(req, err, blk_rq_bytes(req));
+	spin_unlock_irq(&md->lock);
+
+	mmc_release_host(card->host);
+
+	return err ? 0 : 1;
+}
+
+static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 {
 	struct mmc_blk_data *md = mq->data;
 	struct mmc_card *card = md->queue.card;
@@ -475,6 +508,13 @@ static int mmc_blk_issue_rq(struct mmc_q
 	return 0;
 }
 
+static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
+{
+	if (req->cmd_flags & REQ_DISCARD)
+		return mmc_blk_issue_discard_rq(mq, req);
+	else
+		return mmc_blk_issue_rw_rq(mq, req);
+}
 
 static inline int mmc_blk_readonly(struct mmc_card *card)
 {
diff -puN drivers/mmc/card/queue.c~mmc_block-add-discard-support drivers/mmc/card/queue.c
--- a/drivers/mmc/card/queue.c~mmc_block-add-discard-support
+++ a/drivers/mmc/card/queue.c
@@ -30,9 +30,9 @@
 static int mmc_prep_request(struct request_queue *q, struct request *req)
 {
 	/*
-	 * We only like normal block requests.
+	 * We only like normal block requests and discards.
 	 */
-	if (req->cmd_type != REQ_TYPE_FS) {
+	if (req->cmd_type != REQ_TYPE_FS && !(req->cmd_flags & REQ_DISCARD)) {
 		blk_dump_rq_flags(req, "MMC bad request");
 		return BLKPREP_KILL;
 	}
@@ -130,6 +130,18 @@ int mmc_init_queue(struct mmc_queue *mq,
 	blk_queue_prep_rq(mq->queue, mmc_prep_request);
 	blk_queue_ordered(mq->queue, QUEUE_ORDERED_DRAIN);
 	queue_flag_set_unlocked(QUEUE_FLAG_NONROT, mq->queue);
+	if (mmc_can_erase(card)) {
+		queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, mq->queue);
+		mq->queue->limits.max_discard_sectors = UINT_MAX;
+		if (card->erased_byte == 0)
+			mq->queue->limits.discard_zeroes_data = 1;
+		if (!mmc_can_trim(card) && is_power_of_2(card->erase_size)) {
+			mq->queue->limits.discard_granularity =
+							card->erase_size << 9;
+			mq->queue->limits.discard_alignment =
+							card->erase_size << 9;
+		}
+	}
 
 #ifdef CONFIG_MMC_BLOCK_BOUNCE
 	if (host->max_hw_segs == 1) {
_
