From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH PoC 3/7] mmc-mq: request completion fixes
Date: Thu, 22 Sep 2016 15:57:06 +0200
Message-ID: <1474552630-28314-4-git-send-email-b.zolnierkie@samsung.com>
References: <1474552630-28314-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1474552630-28314-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.com>, Tejun Heo <tj@kernel.org>, Omar Sandoval <osandov@osandov.com>, Christoph Hellwig <hch@lst.de>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/mmc/card/block.c    |  52 ++++++++++++--------
 drivers/mmc/card/mmc_test.c |   8 +--
 drivers/mmc/card/queue.c    |  11 ++++-
 drivers/mmc/card/queue.h    |   4 ++
 drivers/mmc/core/core.c     | 117 +++++++++++++++++++++++++++++++++++++++-----
 drivers/mmc/core/mmc_ops.c  |   9 ++++
 drivers/mmc/host/dw_mmc.c   |   3 +-
 include/linux/mmc/core.h    |   6 ++-
 8 files changed, 169 insertions(+), 41 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 1d4a09f..3c2bdc2 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1057,9 +1057,12 @@ static int mmc_blk_cmd_recovery(struct mmc_card *card, struct request *req,
 	 * we can't be sure the returned status is for the r/w command.
 	 */
 	for (retry = 2; retry >= 0; retry--) {
-		err = get_card_status(card, &status, 0);
-		if (!err)
-			break;
+		mdelay(100);
+		pr_info("%s: mdelay(100)\n", __func__);
+		return ERR_CONTINUE;
+//		err = get_card_status(card, &status, 0);
+//		if (!err)
+//			break;
 
 		/* Re-tune if needed */
 		mmc_retune_recheck(card->host);
@@ -1230,6 +1233,7 @@ out:
 		goto retry;
 	if (!err)
 		mmc_blk_reset_success(md, type);
+	mmc_put_card(card);
 	mmc_queue_req_free(mq, mqrq);
 	blk_end_request(req, err, blk_rq_bytes(req));
 
@@ -1298,6 +1302,7 @@ out_retry:
 	if (!err)
 		mmc_blk_reset_success(md, type);
 out:
+	mmc_put_card(card);
 	mmc_queue_req_free(mq, mqrq);
 	blk_end_request(req, err, blk_rq_bytes(req));
 
@@ -1314,6 +1319,7 @@ static int mmc_blk_issue_flush(struct mmc_queue *mq, struct request *req, struct
 	if (ret)
 		ret = -EIO;
 
+	mmc_put_card(card);
 	mmc_queue_req_free(mq, mqrq);
 	blk_end_request_all(req, ret);
 
@@ -1419,10 +1425,13 @@ static int mmc_blk_err_check(struct mmc_card *card,
 			gen_err = 1;
 		}
 
-		err = card_busy_detect(card, MMC_BLK_TIMEOUT_MS, false, req,
-					&gen_err);
-		if (err)
-			return MMC_BLK_CMD_ERR;
+		mdelay(100);
+		pr_info("%s: mdelay(100)\n", __func__);
+		return MMC_BLK_SUCCESS;
+//		err = card_busy_detect(card, MMC_BLK_TIMEOUT_MS, false, req,
+//					&gen_err);
+//		if (err)
+//			return MMC_BLK_CMD_ERR;
 	}
 
 	/* if general error occurs, retry the write operation. */
@@ -2035,12 +2044,13 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct mmc_queue_req *mqrq)
 			areq = &mqrq_cur->mmc_active;
 		} else
 			areq = NULL;
-		areq = mmc_start_req(card->host, areq, (int *) &status);
+		areq = mmc_start_req(card->host, areq, (int *) &status, mqrq);
 		if (!areq) {
 			pr_info("%s: exit (0) (!areq)\n", __func__);
 			return 0;
 		}
-
+		ret = 0; //
+#if 0
 		mq_rq = container_of(areq, struct mmc_queue_req, mmc_active);
 		brq = &mq_rq->brq;
 		req = mq_rq->req;
@@ -2139,7 +2149,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct mmc_queue_req *mqrq)
 					goto cmd_abort;
 				mmc_blk_packed_hdr_wrq_prep(mq_rq, card, mq);
 				mmc_start_req(card->host,
-					      &mq_rq->mmc_active, NULL);
+					      &mq_rq->mmc_active, NULL, mq_rq);
 			} else {
 
 				/*
@@ -2149,10 +2159,11 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct mmc_queue_req *mqrq)
 				mmc_blk_rw_rq_prep(mq_rq, card,
 						disable_multi, mq);
 				mmc_start_req(card->host,
-						&mq_rq->mmc_active, NULL);
+						&mq_rq->mmc_active, NULL, mq_rq);
 			}
 			mq_rq->brq.retune_retry_done = retune_retry_done;
 		}
+#endif
 	} while (ret);
 
 	pr_info("%s: exit (1==ok)\n", __func__);
@@ -2184,10 +2195,10 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct mmc_queue_req *mqrq)
 
 			mmc_blk_rw_rq_prep(mqrq_cur, card, 0, mq);
 			mmc_start_req(card->host,
-				      &mqrq_cur->mmc_active, NULL);
+				      &mqrq_cur->mmc_active, NULL, mqrq_cur);
 		}
 	}
-
+	BUG();
 	mmc_queue_req_free(mq, mq_rq);
 
 	pr_info("%s: exit (0)\n", __func__);
@@ -2201,17 +2212,18 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req, struct mm
 	struct mmc_card *card = md->queue.card;
 	unsigned int cmd_flags = req ? req->cmd_flags : 0;
 
-	pr_info("%s: enter\n", __func__);
+	pr_info("%s: enter (mq=%p md=%p)\n", __func__, mq, md);
 
 	BUG_ON(!req);
 
 	/* claim host only for the first request */
 	mmc_get_card(card);
 
-	pr_info("%s: mmc_blk_part_switch\n", __func__);
+	pr_info("%s: mmc_blk_part_switch (mq=%p md=%p)\n", __func__, mq, md);
 	ret = mmc_blk_part_switch(card, md);
 	if (ret) {
 		if (req) {
+			mmc_queue_req_free(req->q->queuedata, mqrq); //
 			blk_end_request_all(req, -EIO);
 		}
 		ret = 0;
@@ -2219,23 +2231,23 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req, struct mm
 	}
 
 	if (cmd_flags & REQ_DISCARD) {
-		pr_info("%s: DISCARD rq\n", __func__);
+		pr_info("%s: DISCARD rq (mq=%p md=%p)\n", __func__, mq, md);
 		if (req->cmd_flags & REQ_SECURE)
 			ret = mmc_blk_issue_secdiscard_rq(mq, req, mqrq);
 		else
 			ret = mmc_blk_issue_discard_rq(mq, req, mqrq);
 	} else if (cmd_flags & REQ_FLUSH) {
-		pr_info("%s: FLUSH rq\n", __func__);
+		pr_info("%s: FLUSH rq (mq=%p md=%p)\n", __func__, mq, md);
 		ret = mmc_blk_issue_flush(mq, req, mqrq);
 	} else {
-		pr_info("%s: RW rq\n", __func__);
+		pr_info("%s: RW rq (mq=%p md=%p)\n", __func__, mq, md);
 		ret = mmc_blk_issue_rw_rq(mq, mqrq);
 	}
 
 out:
 	/* Release host when there are no more requests */
-	mmc_put_card(card);
-	pr_info("%s: exit\n", __func__);
+/////	mmc_put_card(card);
+	pr_info("%s: exit (mq=%p md=%p)\n", __func__, mq, md);
 	return ret;
 }
 
diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
index 7dee9e5..ff375c1 100644
--- a/drivers/mmc/card/mmc_test.c
+++ b/drivers/mmc/card/mmc_test.c
@@ -2413,10 +2413,10 @@ static int mmc_test_ongoing_transfer(struct mmc_test_card *test,
 	} while (repeat_cmd && R1_CURRENT_STATE(status) != R1_STATE_TRAN);
 
 	/* Wait for data request to complete */
-	if (use_areq)
-		mmc_start_req(host, NULL, &ret);
-	else
-		mmc_wait_for_req_done(test->card->host, mrq);
+//	if (use_areq)
+//		mmc_start_req(host, NULL, &ret);
+//	else
+//		mmc_wait_for_req_done(test->card->host, mrq);
 
 	/*
 	 * For cap_cmd_during_tfr request, upper layer must send stop if
diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index e9c9bbf..6fd711d 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -52,14 +52,17 @@ struct mmc_queue_req *mmc_queue_req_find(struct mmc_queue *mq,
 	struct mmc_queue_req *mqrq;
 	int i = ffz(mq->qslots);
 
-	pr_info("%s: enter (%d)\n", __func__, i);
+	pr_info("%s: enter (%d) (testtag=%d qdepth=%d 0.testtag=%d\n", __func__, i, mq->testtag, mq->qdepth, mq->mqrq[0].testtag);
 
-	WARN_ON(i >= mq->qdepth);
+	WARN_ON(mq->testtag == 0);
+//////	WARN_ON(i >= mq->qdepth);
 	if (i >= mq->qdepth)
 		return NULL;
+	WARN_ON(mq->qdepth == 0);
 
 ////	spin_lock_irq(req->q->queue_lock);
 	mqrq = &mq->mqrq[i];
+	WARN_ON(mqrq->testtag == 0);
 	WARN_ON(mqrq->req || mq->qcnt >= mq->qdepth ||
 		test_bit(mqrq->task_id, &mq->qslots));
 	mqrq->req = req;
@@ -109,6 +112,7 @@ static void mmc_request_fn(struct request_queue *q)
 	}
 repeat:
 	req = blk_fetch_request(q);
+	WARN_ON(req && req->cmd_type != REQ_TYPE_FS);
 	if (req && req->cmd_type == REQ_TYPE_FS) {
 		mqrq_cur = mmc_queue_req_find(mq, req);
 		if (!mqrq_cur) {
@@ -179,6 +183,8 @@ static struct mmc_queue_req *mmc_queue_alloc_mqrqs(struct mmc_queue *mq,
 			mqrq[i].task_id = i;
 	}
 
+	mqrq[0].testtag = 1;
+
 	return mqrq;
 }
 
@@ -285,6 +291,7 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 	mq->mqrq = mmc_queue_alloc_mqrqs(mq, mq->qdepth);
 	if (!mq->mqrq)
 		goto blk_cleanup;
+	mq->testtag = 1;
 	mq->queue->queuedata = mq;
 
 	blk_queue_prep_rq(mq->queue, mmc_prep_request);
diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
index c52fa88..3adf1bc 100644
--- a/drivers/mmc/card/queue.h
+++ b/drivers/mmc/card/queue.h
@@ -43,6 +43,8 @@ struct mmc_queue_req {
 	enum mmc_packed_type	cmd_type;
 	struct mmc_packed	*packed;
 	int			task_id;
+
+	int			testtag;
 };
 
 struct mmc_queue {
@@ -57,6 +59,8 @@ struct mmc_queue {
 	int			qdepth;
 	int			qcnt;
 	unsigned long		qslots;
+
+	int			testtag;
 };
 
 extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, spinlock_t *,
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 7496c22..22052f0 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -231,6 +231,9 @@ static void __mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 		return;
 	}
 
+	if (mrq->cmd->retries == 3 && mrq->cmd->opcode == 5)
+		WARN_ON(1);
+
 	/*
 	 * For sdio rw commands we must wait for card busy otherwise some
 	 * sdio devices won't work properly.
@@ -408,6 +411,9 @@ out:
 }
 EXPORT_SYMBOL(mmc_start_bkops);
 
+static void mmc_post_req(struct mmc_host *host, struct mmc_request *mrq,
+			 int err);
+
 /*
  * mmc_wait_done() - done callback for request
  * @mrq: done request
@@ -416,7 +422,77 @@ EXPORT_SYMBOL(mmc_start_bkops);
  */
 static void mmc_wait_done(struct mmc_request *mrq)
 {
+	struct mmc_host *host = mrq->host; //
+	struct mmc_queue_req *mq_rq = mrq->mqrq;
+	struct mmc_async_req *areq = NULL;
+//	struct mmc_queue_req *mq_rq = container_of(next_req, struct mmc_queue_req,
+//						    mmc_active);
+//	struct mmc_queue_req *mq_rq = container_of(areq, struct mmc_queue_req, mmc_active);
+	struct mmc_command *cmd;
+	int err = 0, ret = 0;
+
+	pr_info("%s: enter\n", __func__);
+
+	cmd = mrq->cmd;
+	pr_info("%s: cmd->opcode=%d mq_rq=%p\n", __func__, cmd->opcode, mq_rq);
+
+	if (mq_rq)
+		areq = &mq_rq->mmc_active;
+
+	if (!cmd->error || !cmd->retries ||
+	    mmc_card_removed(host->card)) {
+		if (mq_rq &&
+		    (mq_rq->req->cmd_type == REQ_TYPE_FS) &&
+		    ((mq_rq->req->cmd_flags & (REQ_DISCARD | REQ_FLUSH)) == 0)) {
+			err = areq->err_check(host->card, areq);
+			BUG_ON(err != MMC_BLK_SUCCESS);
+		}
+	}
+	else {
+//		WARN_ON(1);
+		mmc_retune_recheck(host);
+		pr_info("%s: req failed (CMD%u): %d, retrying...\n",
+			mmc_hostname(host),
+			cmd->opcode, cmd->error);
+		cmd->retries--;
+		cmd->error = 0;
+		__mmc_start_request(host, mrq);
+		goto out;
+	}
+
+	mmc_retune_release(host);
+
+//	host->areq->pre_req_done = false;
+	if (mq_rq &&
+	    (mq_rq->req->cmd_type == REQ_TYPE_FS) &&
+	    ((mq_rq->req->cmd_flags & (REQ_DISCARD | REQ_FLUSH)) == 0)) {
+		mmc_post_req(host, mrq, 0);
+	}
+
 	complete(&mrq->completion);
+BUG_ON(mq_rq && (mq_rq->req->cmd_type == REQ_TYPE_FS) && (mq_rq->req->cmd_flags & (REQ_DISCARD | REQ_FLUSH)));
+	if (mq_rq &&
+	    (mq_rq->req->cmd_type == REQ_TYPE_FS) &&
+	    ((mq_rq->req->cmd_flags & (REQ_DISCARD | REQ_FLUSH)) == 0)) {
+		struct mmc_blk_request *brq;
+		struct request *req;
+		struct mmc_blk_data *md = mq_rq->req->q->queuedata;
+		int bytes;
+
+		brq = &mq_rq->brq;
+		req = mq_rq->req;
+//		type = rq_data_dir(req) == READ ? MMC_BLK_READ : MMC_BLK_WRITE;
+		mmc_queue_bounce_post(mq_rq);
+
+		bytes = brq->data.bytes_xfered;
+		mmc_put_card(host->card);
+		pr_info("%s: freeing mqrq\n", __func__); //
+		mmc_queue_req_free(req->q->queuedata, mq_rq); //
+		ret = blk_end_request(req, 0, bytes);
+
+	}
+out:
+	pr_info("%s: exit (err=%d, ret=%d)\n", __func__, err, ret);
 }
 
 static inline void mmc_wait_ongoing_tfr_cmd(struct mmc_host *host)
@@ -441,7 +517,7 @@ static inline void mmc_wait_ongoing_tfr_cmd(struct mmc_host *host)
  * If an ongoing transfer is already in progress, wait for the command line
  * to become available before sending another command.
  */
-static int __mmc_start_req(struct mmc_host *host, struct mmc_request *mrq)
+static int __mmc_start_req(struct mmc_host *host, struct mmc_request *mrq, struct mmc_queue_req *mqrq)
 {
 	int err;
 
@@ -452,6 +528,7 @@ static int __mmc_start_req(struct mmc_host *host, struct mmc_request *mrq)
 	init_completion(&mrq->completion);
 	mrq->done = mmc_wait_done;
 	mrq->host = host;
+	mrq->mqrq = mqrq;
 
 	init_completion(&mrq->cmd_completion);
 
@@ -466,7 +543,7 @@ static int __mmc_start_req(struct mmc_host *host, struct mmc_request *mrq)
 
 	return err;
 }
-
+#if 0
 /*
  * mmc_wait_for_data_req_done() - wait for request completed
  * @host: MMC host to prepare the command.
@@ -564,7 +641,7 @@ void mmc_wait_for_req_done(struct mmc_host *host, struct mmc_request *mrq)
 	pr_info("%s: exit\n", __func__);
 }
 EXPORT_SYMBOL(mmc_wait_for_req_done);
-
+#endif
 /**
  *	mmc_is_req_done - Determine if a 'cap_cmd_during_tfr' request is done
  *	@host: MMC host
@@ -634,7 +711,7 @@ static void mmc_post_req(struct mmc_host *host, struct mmc_request *mrq,
  *	is returned without waiting. NULL is not an error condition.
  */
 struct mmc_async_req *mmc_start_req(struct mmc_host *host,
-				    struct mmc_async_req *areq, int *error)
+				    struct mmc_async_req *areq, int *error, struct mmc_queue_req *mqrq)
 {
 	int err = 0;
 	int start_err = 0;
@@ -645,15 +722,17 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
 	pr_info("%s: areq=%p host->areq=%p\n", __func__, areq, host->areq);
 
 	/* Prepare a new request */
-	if (areq && !areq->pre_req_done) {
-		areq->pre_req_done = true;
+//	if (areq && !areq->pre_req_done) {
+//		areq->pre_req_done = true;
 		mmc_pre_req(host, areq->mrq, !host->areq);
-	}
+//	}
 
 	if (areq) //
-		start_err = __mmc_start_req(host, areq->mrq); //
-
+		start_err = __mmc_start_req(host, areq->mrq, mqrq); //
+	data = areq; //
+#if 0
 	host->areq = areq; //
+
 	if (host->areq) {
 		err = mmc_wait_for_data_req_done(host, host->areq->mrq,	areq);
 		/*
@@ -687,6 +766,7 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
 
 	if (error)
 		*error = err;
+#endif
 	pr_info("%s: exit (data=%p)\n", __func__, data);
 	return data;
 }
@@ -706,10 +786,19 @@ EXPORT_SYMBOL(mmc_start_req);
  */
 void mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq)
 {
-	__mmc_start_req(host, mrq);
+	pr_info("%s: enter\n", __func__);
 
-	if (!mrq->cap_cmd_during_tfr)
-		mmc_wait_for_req_done(host, mrq);
+	__mmc_start_req(host, mrq, NULL);
+
+	if (!mrq->cap_cmd_during_tfr) {
+//		mmc_wait_for_req_done(host, mrq);
+//		BUG(); //
+		pr_info("%s: wait start\n", __func__);
+		wait_for_completion(&mrq->completion);
+		pr_info("%s: wait done\n", __func__);
+	}
+
+	pr_info("%s: exit\n", __func__);
 }
 EXPORT_SYMBOL(mmc_wait_for_req);
 
@@ -794,6 +883,8 @@ int mmc_wait_for_cmd(struct mmc_host *host, struct mmc_command *cmd, int retries
 {
 	struct mmc_request mrq = {NULL};
 
+	pr_info("%s: enter (cmd->opcode=%d retries=%d)\n", __func__, cmd->opcode, cmd->retries);
+
 	WARN_ON(!host->claimed);
 
 	memset(cmd->resp, 0, sizeof(cmd->resp));
@@ -801,8 +892,10 @@ int mmc_wait_for_cmd(struct mmc_host *host, struct mmc_command *cmd, int retries
 
 	mrq.cmd = cmd;
 	cmd->data = NULL;
+	pr_info("%s: cmd->opcode=%d retries=%d\n", __func__, cmd->opcode, cmd->retries);
 
 	mmc_wait_for_req(host, &mrq);
+	pr_info("%s: exit (cmd->opcode=%d retries=%d cmd->error=%d)\n", __func__, cmd->opcode, cmd->retries, cmd->error);
 
 	return cmd->error;
 }
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 7ec7d62..0cfa3ad 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -482,6 +482,9 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 	bool expired = false;
 	bool busy = false;
 
+	WARN_ON(1);
+	pr_info("%s: enter\n", __func__);
+
 	mmc_retune_hold(host);
 
 	/*
@@ -536,6 +539,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 	/* Must check status to be sure of no errors. */
 	timeout = jiffies + msecs_to_jiffies(timeout_ms) + 1;
 	do {
+		pr_info("%s: busy loop enter\n", __func__);
 		/*
 		 * Due to the possibility of being preempted after
 		 * sending the status command, check the expiration
@@ -543,6 +547,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		 */
 		expired = time_after(jiffies, timeout);
 		if (send_status) {
+			pr_info("%s: send status\n", __func__);
 			err = __mmc_send_status(card, &status, ignore_crc);
 			if (err)
 				goto out;
@@ -550,6 +555,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		if ((host->caps & MMC_CAP_WAIT_WHILE_BUSY) && use_r1b_resp)
 			break;
 		if (host->ops->card_busy) {
+			pr_info("%s: card busy\n", __func__);
 			if (!host->ops->card_busy(host))
 				break;
 			busy = true;
@@ -563,6 +569,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		 * rely on waiting for the stated timeout to be sufficient.
 		 */
 		if (!send_status && !host->ops->card_busy) {
+			pr_info("%s: mmc delay\n", __func__);
 			mmc_delay(timeout_ms);
 			goto out;
 		}
@@ -575,12 +582,14 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 			err = -ETIMEDOUT;
 			goto out;
 		}
+		pr_info("%s: busy loop (busy=%d)\n", __func__, busy);
 	} while (R1_CURRENT_STATE(status) == R1_STATE_PRG || busy);
 
 	err = mmc_switch_status_error(host, status);
 out:
 	mmc_retune_release(host);
 
+	pr_info("%s: exit\n", __func__);
 	return err;
 }
 
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index c2a1286..c23b1b2 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1229,6 +1229,7 @@ static void dw_mci_queue_request(struct dw_mci *host, struct dw_mci_slot *slot,
 	dev_vdbg(&slot->mmc->class_dev, "queue request: state=%d\n",
 		 host->state);
 
+	BUG_ON(slot->mrq);
 	slot->mrq = mrq;
 
 	if (host->state == STATE_WAITING_CMD11_DONE) {
@@ -1255,8 +1256,6 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	struct dw_mci_slot *slot = mmc_priv(mmc);
 	struct dw_mci *host = slot->host;
 
-	WARN_ON(slot->mrq);
-
 	/*
 	 * The check for card presence and queueing of the request must be
 	 * atomic, otherwise the card could be removed in between and the
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 4c6d131..2d0aec8 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -126,6 +126,7 @@ struct mmc_data {
 };
 
 struct mmc_host;
+struct mmc_queue_req;
 struct mmc_request {
 	struct mmc_command	*sbc;		/* SET_BLOCK_COUNT for multiblock */
 	struct mmc_command	*cmd;
@@ -139,6 +140,8 @@ struct mmc_request {
 
 	/* Allow other commands during this ongoing data transfer or busy wait */
 	bool			cap_cmd_during_tfr;
+
+	struct mmc_queue_req	*mqrq;
 };
 
 struct mmc_card;
@@ -147,7 +150,8 @@ struct mmc_async_req;
 extern int mmc_stop_bkops(struct mmc_card *);
 extern int mmc_read_bkops_status(struct mmc_card *);
 extern struct mmc_async_req *mmc_start_req(struct mmc_host *,
-					   struct mmc_async_req *, int *);
+					   struct mmc_async_req *, int *,
+					   struct mmc_queue_req *);
 extern int mmc_interrupt_hpi(struct mmc_card *);
 extern void mmc_wait_for_req(struct mmc_host *, struct mmc_request *);
 extern void mmc_wait_for_req_done(struct mmc_host *host,
-- 
1.9.1
