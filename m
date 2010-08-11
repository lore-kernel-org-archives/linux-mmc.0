From: akpm@linux-foundation.org
Subject: [patch 19/24] mmc_block: add support for secure discard
Date: Wed, 11 Aug 2010 14:17:50 -0700
Message-ID: <201008112117.o7BLHoOK015028@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60965 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753668Ab0HKVSO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Aug 2010 17:18:14 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, adrian.hunter@nokia.com, axboe@kernel.dk, bengardiner@nanometrics.ca, hch@lst.de, kmpark@infradead.org, linux-mmc@vger.kernel.org, madhu.cr@ti.com

From: Adrian Hunter <adrian.hunter@nokia.com>

Secure discard is implemented by Secure Trim if the discard is unaligned
or Secure Erase otherwise.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
Acked-by: Jens Axboe <axboe@kernel.dk>
Cc: Kyungmin Park <kmpark@infradead.org>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ben Gardiner <bengardiner@nanometrics.ca>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/card/block.c |   46 ++++++++++++++++++++++++++++++++++---
 drivers/mmc/card/queue.c |    3 ++
 2 files changed, 46 insertions(+), 3 deletions(-)

diff -puN drivers/mmc/card/block.c~mmc_block-add-support-for-secure-discard drivers/mmc/card/block.c
--- a/drivers/mmc/card/block.c~mmc_block-add-support-for-secure-discard
+++ a/drivers/mmc/card/block.c
@@ -280,6 +280,42 @@ out:
 	return err ? 0 : 1;
 }
 
+static int mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
+				       struct request *req)
+{
+	struct mmc_blk_data *md = mq->data;
+	struct mmc_card *card = md->queue.card;
+	unsigned int from, nr, arg;
+	int err = 0;
+
+	mmc_claim_host(card->host);
+
+	if (!mmc_can_secure_erase_trim(card)) {
+		err = -EOPNOTSUPP;
+		goto out;
+	}
+
+	from = blk_rq_pos(req);
+	nr = blk_rq_sectors(req);
+
+	if (mmc_can_trim(card) && !mmc_erase_group_aligned(card, from, nr))
+		arg = MMC_SECURE_TRIM1_ARG;
+	else
+		arg = MMC_SECURE_ERASE_ARG;
+
+	err = mmc_erase(card, from, nr, arg);
+	if (!err && arg == MMC_SECURE_TRIM1_ARG)
+		err = mmc_erase(card, from, nr, MMC_SECURE_TRIM2_ARG);
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
 static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 {
 	struct mmc_blk_data *md = mq->data;
@@ -510,10 +546,14 @@ static int mmc_blk_issue_rw_rq(struct mm
 
 static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 {
-	if (req->cmd_flags & REQ_DISCARD)
-		return mmc_blk_issue_discard_rq(mq, req);
-	else
+	if (req->cmd_flags & REQ_DISCARD) {
+		if (req->cmd_flags & REQ_SECURE)
+			return mmc_blk_issue_secdiscard_rq(mq, req);
+		else
+			return mmc_blk_issue_discard_rq(mq, req);
+	} else {
 		return mmc_blk_issue_rw_rq(mq, req);
+	}
 }
 
 static inline int mmc_blk_readonly(struct mmc_card *card)
diff -puN drivers/mmc/card/queue.c~mmc_block-add-support-for-secure-discard drivers/mmc/card/queue.c
--- a/drivers/mmc/card/queue.c~mmc_block-add-support-for-secure-discard
+++ a/drivers/mmc/card/queue.c
@@ -141,6 +141,9 @@ int mmc_init_queue(struct mmc_queue *mq,
 			mq->queue->limits.discard_alignment =
 							card->erase_size << 9;
 		}
+		if (mmc_can_secure_erase_trim(card))
+			queue_flag_set_unlocked(QUEUE_FLAG_SECDISCARD,
+						mq->queue);
 	}
 
 #ifdef CONFIG_MMC_BLOCK_BOUNCE
_
