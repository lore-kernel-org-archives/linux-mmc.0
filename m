From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH PoC 1/7] mmc-mq: add debug printks
Date: Thu, 22 Sep 2016 15:57:04 +0200
Message-ID: <1474552630-28314-2-git-send-email-b.zolnierkie@samsung.com>
References: <1474552630-28314-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1474552630-28314-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.com>, Tejun Heo <tj@kernel.org>, Omar Sandoval <osandov@osandov.com>, Christoph Hellwig <hch@lst.de>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/mmc/card/block.c | 18 ++++++++++++++++--
 drivers/mmc/core/core.c  | 32 ++++++++++++++++++++++++++++++--
 2 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 7d733d0..ce56930 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1995,6 +1995,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 	const u8 packed_nr = 2;
 	u8 reqs = 0;
 
+	pr_info("%s: enter\n", __func__);
 	if (rqc) {
 		mqrq_cur = mmc_queue_req_find(mq, rqc);
 		if (!mqrq_cur) {
@@ -2004,8 +2005,10 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 		}
 	}
 
-	if (!mq->qcnt)
+	if (!mq->qcnt) {
+		pr_info("%s: exit (0) (!mq->qcnt)\n", __func__);
 		return 0;
+	}
 
 	if (mqrq_cur)
 		reqs = mmc_blk_prep_packed_list(mq, mqrq_cur);
@@ -2035,8 +2038,10 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 		} else
 			areq = NULL;
 		areq = mmc_start_req(card->host, areq, (int *) &status);
-		if (!areq)
+		if (!areq) {
+			pr_info("%s: exit (0) (!areq)\n", __func__);
 			return 0;
+		}
 
 		mq_rq = container_of(areq, struct mmc_queue_req, mmc_active);
 		brq = &mq_rq->brq;
@@ -2150,6 +2155,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 
 	mmc_queue_req_free(mq, mq_rq);
 
+	pr_info("%s: exit (1)\n", __func__);
 	return 1;
 
  cmd_abort:
@@ -2184,6 +2190,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 
 	mmc_queue_req_free(mq, mq_rq);
 
+	pr_info("%s: exit (0)\n", __func__);
 	return 0;
 }
 
@@ -2194,10 +2201,13 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 	struct mmc_card *card = md->queue.card;
 	unsigned int cmd_flags = req ? req->cmd_flags : 0;
 
+	pr_info("%s: enter\n", __func__);
+
 	if (req && !mq->qcnt)
 		/* claim host only for the first request */
 		mmc_get_card(card);
 
+	pr_info("%s: mmc_blk_part_switch\n", __func__);
 	ret = mmc_blk_part_switch(card, md);
 	if (ret) {
 		if (req) {
@@ -2208,6 +2218,7 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 	}
 
 	if (cmd_flags & REQ_DISCARD) {
+		pr_info("%s: DISCARD rq\n", __func__);
 		/* complete ongoing async transfer before issuing discard */
 		if (mq->qcnt)
 			mmc_blk_issue_rw_rq(mq, NULL);
@@ -2216,11 +2227,13 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 		else
 			ret = mmc_blk_issue_discard_rq(mq, req);
 	} else if (cmd_flags & REQ_FLUSH) {
+		pr_info("%s: FLUSH rq\n", __func__);
 		/* complete ongoing async transfer before issuing flush */
 		if (mq->qcnt)
 			mmc_blk_issue_rw_rq(mq, NULL);
 		ret = mmc_blk_issue_flush(mq, req);
 	} else {
+		pr_info("%s: RW rq\n", __func__);
 		ret = mmc_blk_issue_rw_rq(mq, req);
 	}
 
@@ -2228,6 +2241,7 @@ out:
 	/* Release host when there are no more requests */
 	if (!mq->qcnt)
 		mmc_put_card(card);
+	pr_info("%s: exit\n", __func__);
 	return ret;
 }
 
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 9be42691..d2d8d9b 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -219,6 +219,8 @@ static void __mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 {
 	int err;
 
+	pr_info("%s: enter\n", __func__);
+
 	/* Assumes host controller has been runtime resumed by mmc_claim_host */
 	err = mmc_retune(host);
 	if (err) {
@@ -256,6 +258,8 @@ static void __mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 	trace_mmc_request_start(host, mrq);
 
 	host->ops->request(host, mrq);
+
+	pr_info("%s: exit\n", __func__);
 }
 
 static int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
@@ -264,6 +268,7 @@ static int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 	unsigned int i, sz;
 	struct scatterlist *sg;
 #endif
+	pr_info("%s: enter\n", __func__);
 	mmc_retune_hold(host);
 
 	if (mmc_card_removed(host->card))
@@ -327,6 +332,7 @@ static int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 	led_trigger_event(host->led, LED_FULL);
 	__mmc_start_request(host, mrq);
 
+	pr_info("%s: exit\n", __func__);
 	return 0;
 }
 
@@ -466,6 +472,8 @@ static int __mmc_start_req(struct mmc_host *host, struct mmc_request *mrq)
 {
 	int err;
 
+	pr_info("%s: enter\n", __func__);
+
 	mmc_wait_ongoing_tfr_cmd(host);
 
 	init_completion(&mrq->completion);
@@ -480,6 +488,8 @@ static int __mmc_start_req(struct mmc_host *host, struct mmc_request *mrq)
 		complete(&mrq->completion);
 	}
 
+	pr_info("%s: exit\n", __func__);
+
 	return err;
 }
 
@@ -502,10 +512,14 @@ static int mmc_wait_for_data_req_done(struct mmc_host *host,
 	struct mmc_context_info *context_info = &host->context_info;
 	int err;
 
+	pr_info("%s: enter\n", __func__);
+
 	while (1) {
 		wait_event_interruptible(context_info->wait,
+//				context_info->is_done_rcv);
 				(context_info->is_done_rcv ||
 				 context_info->is_new_req));
+		pr_info("%s: waiting done\n", __func__);
 		context_info->is_waiting_last_req = false;
 		if (context_info->is_done_rcv) {
 			context_info->is_done_rcv = false;
@@ -527,11 +541,14 @@ static int mmc_wait_for_data_req_done(struct mmc_host *host,
 				continue; /* wait for done/new event again */
 			}
 		} else if (context_info->is_new_req) {
-			if (!next_req)
+			if (!next_req) {
+				pr_info("%s: exit (!next_req)\n", __func__);
 				return MMC_BLK_NEW_REQUEST;
+			}
 		}
 	}
 	mmc_retune_release(host);
+	pr_info("%s: exit (err=%d)\n", __func__, err);
 	return err;
 }
 
@@ -539,8 +556,11 @@ void mmc_wait_for_req_done(struct mmc_host *host, struct mmc_request *mrq)
 {
 	struct mmc_command *cmd;
 
+	pr_info("%s: enter\n", __func__);
+
 	while (1) {
 		wait_for_completion(&mrq->completion);
+		pr_info("%s: waiting done\n", __func__);
 
 		cmd = mrq->cmd;
 
@@ -567,7 +587,7 @@ void mmc_wait_for_req_done(struct mmc_host *host, struct mmc_request *mrq)
 
 		mmc_retune_recheck(host);
 
-		pr_debug("%s: req failed (CMD%u): %d, retrying...\n",
+		pr_info("%s: req failed (CMD%u): %d, retrying...\n",
 			 mmc_hostname(host), cmd->opcode, cmd->error);
 		cmd->retries--;
 		cmd->error = 0;
@@ -575,6 +595,8 @@ void mmc_wait_for_req_done(struct mmc_host *host, struct mmc_request *mrq)
 	}
 
 	mmc_retune_release(host);
+
+	pr_info("%s: exit\n", __func__);
 }
 EXPORT_SYMBOL(mmc_wait_for_req_done);
 
@@ -656,6 +678,10 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
 	int start_err = 0;
 	struct mmc_async_req *data = host->areq;
 
+	pr_info("%s: enter\n", __func__);
+
+	pr_info("%s: areq=%p host->areq=%p\n", __func__, areq, host->areq);
+
 	/* Prepare a new request */
 	if (areq && !areq->pre_req_done) {
 		areq->pre_req_done = true;
@@ -671,6 +697,7 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
 			 * The previous request was not completed,
 			 * nothing to return
 			 */
+			pr_info("%s: exit (NULL)\n", __func__);
 			return NULL;
 		}
 		/*
@@ -714,6 +741,7 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
 
 	if (error)
 		*error = err;
+	pr_info("%s: exit (data=%p)\n", __func__, data);
 	return data;
 }
 EXPORT_SYMBOL(mmc_start_req);
-- 
1.9.1
