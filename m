From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH PoC 5/7] mmc-mq: remove some debug printks
Date: Thu, 22 Sep 2016 15:57:08 +0200
Message-ID: <1474552630-28314-6-git-send-email-b.zolnierkie@samsung.com>
References: <1474552630-28314-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:48973 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934187AbcIVN6B (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Sep 2016 09:58:01 -0400
In-reply-to: <1474552630-28314-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.com>, Tejun Heo <tj@kernel.org>, Omar Sandoval <osandov@osandov.com>, Christoph Hellwig <hch@lst.de>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/mmc/card/block.c | 16 ++++++++--------
 drivers/mmc/card/queue.c | 12 ++++++------
 drivers/mmc/core/core.c  | 45 +++++++++++++++++++++++----------------------
 3 files changed, 37 insertions(+), 36 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 3c2bdc2..ef230e8 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -2008,7 +2008,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct mmc_queue_req *mqrq)
 	const u8 packed_nr = 2;
 	u8 reqs = 0;
 
-	pr_info("%s: enter\n", __func__);
+//	pr_info("%s: enter\n", __func__);
 	mqrq_cur = mqrq;
 	rqc = mqrq_cur->req;
 
@@ -2166,7 +2166,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct mmc_queue_req *mqrq)
 #endif
 	} while (ret);
 
-	pr_info("%s: exit (1==ok)\n", __func__);
+//	pr_info("%s: exit (1==ok)\n", __func__);
 	return 1;
 
  cmd_abort:
@@ -2212,14 +2212,14 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req, struct mm
 	struct mmc_card *card = md->queue.card;
 	unsigned int cmd_flags = req ? req->cmd_flags : 0;
 
-	pr_info("%s: enter (mq=%p md=%p)\n", __func__, mq, md);
+//	pr_info("%s: enter (mq=%p md=%p)\n", __func__, mq, md);
 
 	BUG_ON(!req);
 
 	/* claim host only for the first request */
 	mmc_get_card(card);
 
-	pr_info("%s: mmc_blk_part_switch (mq=%p md=%p)\n", __func__, mq, md);
+//	pr_info("%s: mmc_blk_part_switch (mq=%p md=%p)\n", __func__, mq, md);
 	ret = mmc_blk_part_switch(card, md);
 	if (ret) {
 		if (req) {
@@ -2231,23 +2231,23 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req, struct mm
 	}
 
 	if (cmd_flags & REQ_DISCARD) {
-		pr_info("%s: DISCARD rq (mq=%p md=%p)\n", __func__, mq, md);
+//		pr_info("%s: DISCARD rq (mq=%p md=%p)\n", __func__, mq, md);
 		if (req->cmd_flags & REQ_SECURE)
 			ret = mmc_blk_issue_secdiscard_rq(mq, req, mqrq);
 		else
 			ret = mmc_blk_issue_discard_rq(mq, req, mqrq);
 	} else if (cmd_flags & REQ_FLUSH) {
-		pr_info("%s: FLUSH rq (mq=%p md=%p)\n", __func__, mq, md);
+//		pr_info("%s: FLUSH rq (mq=%p md=%p)\n", __func__, mq, md);
 		ret = mmc_blk_issue_flush(mq, req, mqrq);
 	} else {
-		pr_info("%s: RW rq (mq=%p md=%p)\n", __func__, mq, md);
+//		pr_info("%s: RW rq (mq=%p md=%p)\n", __func__, mq, md);
 		ret = mmc_blk_issue_rw_rq(mq, mqrq);
 	}
 
 out:
 	/* Release host when there are no more requests */
 /////	mmc_put_card(card);
-	pr_info("%s: exit (mq=%p md=%p)\n", __func__, mq, md);
+//	pr_info("%s: exit (mq=%p md=%p)\n", __func__, mq, md);
 	return ret;
 }
 
diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 3ed4477..d4f4859 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -67,7 +67,7 @@ struct mmc_queue_req *mmc_queue_req_find(struct mmc_queue *mq,
 	struct mmc_queue_req *mqrq;
 	int i = ffz(mq->qslots);
 
-	pr_info("%s: enter (%d) (testtag=%d qdepth=%d 0.testtag=%d\n", __func__, i, mq->testtag, mq->qdepth, mq->mqrq[0].testtag);
+//	pr_info("%s: enter (%d) (testtag=%d qdepth=%d 0.testtag=%d\n", __func__, i, mq->testtag, mq->qdepth, mq->mqrq[0].testtag);
 
 	WARN_ON(mq->testtag == 0);
 //////	WARN_ON(i >= mq->qdepth);
@@ -85,7 +85,7 @@ struct mmc_queue_req *mmc_queue_req_find(struct mmc_queue *mq,
 	__set_bit(mqrq->task_id, &mq->qslots);
 ////	spin_unlock_irq(req->q->queue_lock);
 
-	pr_info("%s: exit\n", __func__);
+//	pr_info("%s: exit\n", __func__);
 
 	return mqrq;
 }
@@ -94,7 +94,7 @@ void mmc_queue_req_free(struct mmc_queue *mq,
 			struct mmc_queue_req *mqrq)
 {
 	struct request *req;
-	pr_info("%s: enter\n", __func__);
+//	pr_info("%s: enter\n", __func__);
 	req = mqrq->req;
 ////	spin_lock_irq(req->q->queue_lock);
 	WARN_ON(!mqrq->req || mq->qcnt < 1 ||
@@ -104,7 +104,7 @@ void mmc_queue_req_free(struct mmc_queue *mq,
 	__clear_bit(mqrq->task_id, &mq->qslots);
 ////	spin_unlock_irq(req->q->queue_lock);
 	atomic_dec(&mq->device_busy);
-	pr_info("%s: exit\n", __func__);
+//	pr_info("%s: exit\n", __func__);
 }
 
 /*
@@ -132,7 +132,7 @@ repeat:
 	if (req && req->cmd_type == REQ_TYPE_FS) {
 		if (mmc_queue_ready(q, mq)) {
 		} else {
-			pr_info("%s: command already queued\n", __func__);
+//			pr_info("%s: command already queued\n", __func__);
 //			WARN_ON(1);
 //			spin_unlock_irq(q->queue_lock);
 			blk_requeue_request(mq->queue, req);
@@ -141,7 +141,7 @@ repeat:
 		}
 	}
 	if (!req) {
-		pr_info("%s: no request\n", __func__);
+//		pr_info("%s: no request\n", __func__);
 		return;
 	}
 	spin_unlock_irq(q->queue_lock);
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 22052f0..549e65e 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -221,7 +221,7 @@ static void __mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 {
 	int err;
 
-	pr_info("%s: enter\n", __func__);
+//	pr_info("%s: enter\n", __func__);
 
 	/* Assumes host controller has been runtime resumed by mmc_claim_host */
 	err = mmc_retune(host);
@@ -264,7 +264,7 @@ static void __mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 
 	host->ops->request(host, mrq);
 
-	pr_info("%s: exit\n", __func__);
+//	pr_info("%s: exit\n", __func__);
 }
 
 static int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
@@ -273,7 +273,7 @@ static int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 	unsigned int i, sz;
 	struct scatterlist *sg;
 #endif
-	pr_info("%s: enter\n", __func__);
+//	pr_info("%s: enter\n", __func__);
 	mmc_retune_hold(host);
 
 	if (mmc_card_removed(host->card))
@@ -337,7 +337,7 @@ static int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 	led_trigger_event(host->led, LED_FULL);
 	__mmc_start_request(host, mrq);
 
-	pr_info("%s: exit\n", __func__);
+//	pr_info("%s: exit\n", __func__);
 	return 0;
 }
 
@@ -431,10 +431,10 @@ static void mmc_wait_done(struct mmc_request *mrq)
 	struct mmc_command *cmd;
 	int err = 0, ret = 0;
 
-	pr_info("%s: enter\n", __func__);
+//	pr_info("%s: enter\n", __func__);
 
 	cmd = mrq->cmd;
-	pr_info("%s: cmd->opcode=%d mq_rq=%p\n", __func__, cmd->opcode, mq_rq);
+//	pr_info("%s: cmd->opcode=%d mq_rq=%p\n", __func__, cmd->opcode, mq_rq);
 
 	if (mq_rq)
 		areq = &mq_rq->mmc_active;
@@ -457,7 +457,8 @@ static void mmc_wait_done(struct mmc_request *mrq)
 		cmd->retries--;
 		cmd->error = 0;
 		__mmc_start_request(host, mrq);
-		goto out;
+//		goto out;
+		return;
 	}
 
 	mmc_retune_release(host);
@@ -486,13 +487,13 @@ BUG_ON(mq_rq && (mq_rq->req->cmd_type == REQ_TYPE_FS) && (mq_rq->req->cmd_flags
 
 		bytes = brq->data.bytes_xfered;
 		mmc_put_card(host->card);
-		pr_info("%s: freeing mqrq\n", __func__); //
+//		pr_info("%s: freeing mqrq\n", __func__); //
 		mmc_queue_req_free(req->q->queuedata, mq_rq); //
 		ret = blk_end_request(req, 0, bytes);
 
 	}
-out:
-	pr_info("%s: exit (err=%d, ret=%d)\n", __func__, err, ret);
+//out:
+//	pr_info("%s: exit (err=%d, ret=%d)\n", __func__, err, ret);
 }
 
 static inline void mmc_wait_ongoing_tfr_cmd(struct mmc_host *host)
@@ -521,7 +522,7 @@ static int __mmc_start_req(struct mmc_host *host, struct mmc_request *mrq, struc
 {
 	int err;
 
-	pr_info("%s: enter\n", __func__);
+//	pr_info("%s: enter\n", __func__);
 
 	mmc_wait_ongoing_tfr_cmd(host);
 
@@ -539,7 +540,7 @@ static int __mmc_start_req(struct mmc_host *host, struct mmc_request *mrq, struc
 		mmc_wait_done(mrq);
 	}
 
-	pr_info("%s: exit\n", __func__);
+//	pr_info("%s: exit\n", __func__);
 
 	return err;
 }
@@ -717,9 +718,9 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
 	int start_err = 0;
 	struct mmc_async_req *data = host->areq;
 
-	pr_info("%s: enter\n", __func__);
+//	pr_info("%s: enter\n", __func__);
 
-	pr_info("%s: areq=%p host->areq=%p\n", __func__, areq, host->areq);
+//	pr_info("%s: areq=%p host->areq=%p\n", __func__, areq, host->areq);
 
 	/* Prepare a new request */
 //	if (areq && !areq->pre_req_done) {
@@ -767,7 +768,7 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
 	if (error)
 		*error = err;
 #endif
-	pr_info("%s: exit (data=%p)\n", __func__, data);
+//	pr_info("%s: exit (data=%p)\n", __func__, data);
 	return data;
 }
 EXPORT_SYMBOL(mmc_start_req);
@@ -786,19 +787,19 @@ EXPORT_SYMBOL(mmc_start_req);
  */
 void mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq)
 {
-	pr_info("%s: enter\n", __func__);
+//	pr_info("%s: enter\n", __func__);
 
 	__mmc_start_req(host, mrq, NULL);
 
 	if (!mrq->cap_cmd_during_tfr) {
 //		mmc_wait_for_req_done(host, mrq);
 //		BUG(); //
-		pr_info("%s: wait start\n", __func__);
+//		pr_info("%s: wait start\n", __func__);
 		wait_for_completion(&mrq->completion);
-		pr_info("%s: wait done\n", __func__);
+//		pr_info("%s: wait done\n", __func__);
 	}
 
-	pr_info("%s: exit\n", __func__);
+//	pr_info("%s: exit\n", __func__);
 }
 EXPORT_SYMBOL(mmc_wait_for_req);
 
@@ -883,7 +884,7 @@ int mmc_wait_for_cmd(struct mmc_host *host, struct mmc_command *cmd, int retries
 {
 	struct mmc_request mrq = {NULL};
 
-	pr_info("%s: enter (cmd->opcode=%d retries=%d)\n", __func__, cmd->opcode, cmd->retries);
+//	pr_info("%s: enter (cmd->opcode=%d retries=%d)\n", __func__, cmd->opcode, cmd->retries);
 
 	WARN_ON(!host->claimed);
 
@@ -892,10 +893,10 @@ int mmc_wait_for_cmd(struct mmc_host *host, struct mmc_command *cmd, int retries
 
 	mrq.cmd = cmd;
 	cmd->data = NULL;
-	pr_info("%s: cmd->opcode=%d retries=%d\n", __func__, cmd->opcode, cmd->retries);
+//	pr_info("%s: cmd->opcode=%d retries=%d\n", __func__, cmd->opcode, cmd->retries);
 
 	mmc_wait_for_req(host, &mrq);
-	pr_info("%s: exit (cmd->opcode=%d retries=%d cmd->error=%d)\n", __func__, cmd->opcode, cmd->retries, cmd->error);
+//	pr_info("%s: exit (cmd->opcode=%d retries=%d cmd->error=%d)\n", __func__, cmd->opcode, cmd->retries, cmd->error);
 
 	return cmd->error;
 }
-- 
1.9.1

