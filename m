From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH PoC 7/7] mmc-mq: async request support for blk-mq mode
Date: Thu, 22 Sep 2016 15:57:10 +0200
Message-ID: <1474552630-28314-8-git-send-email-b.zolnierkie@samsung.com>
References: <1474552630-28314-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1474552630-28314-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.com>, Tejun Heo <tj@kernel.org>, Omar Sandoval <osandov@osandov.com>, Christoph Hellwig <hch@lst.de>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/mmc/card/block.c | 51 +++++++++--------------------------
 drivers/mmc/card/queue.c | 49 ++++++++++++++++++++++++++++++---
 drivers/mmc/card/queue.h | 36 +++++++++++++++++++++++++
 drivers/mmc/core/core.c  | 70 +++++++++++++++++++++++++++++++++++++-----------
 4 files changed, 148 insertions(+), 58 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 9968623..8d73828 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -89,39 +89,6 @@ static int max_devices;
 static DEFINE_IDA(mmc_blk_ida);
 static DEFINE_SPINLOCK(mmc_blk_lock);
 
-/*
- * There is one mmc_blk_data per slot.
- */
-struct mmc_blk_data {
-	spinlock_t	lock;
-	struct gendisk	*disk;
-	struct mmc_queue queue;
-	struct list_head part;
-
-	unsigned int	flags;
-#define MMC_BLK_CMD23	(1 << 0)	/* Can do SET_BLOCK_COUNT for multiblock */
-#define MMC_BLK_REL_WR	(1 << 1)	/* MMC Reliable write support */
-#define MMC_BLK_PACKED_CMD	(1 << 2)	/* MMC packed command support */
-
-	unsigned int	usage;
-	unsigned int	read_only;
-	unsigned int	part_type;
-	unsigned int	reset_done;
-#define MMC_BLK_READ		BIT(0)
-#define MMC_BLK_WRITE		BIT(1)
-#define MMC_BLK_DISCARD		BIT(2)
-#define MMC_BLK_SECDISCARD	BIT(3)
-
-	/*
-	 * Only set in main mmc_blk_data associated
-	 * with mmc_card with dev_set_drvdata, and keeps
-	 * track of the current selected device partition.
-	 */
-	unsigned int	part_curr;
-	struct device_attribute force_ro;
-	struct device_attribute power_ro_lock;
-	int	area_type;
-};
 
 static DEFINE_MUTEX(open_lock);
 
@@ -1316,7 +1283,7 @@ static int mmc_blk_issue_flush(struct mmc_queue *mq, struct request *req, struct
 	struct mmc_card *card = md->queue.card;
 	int ret = 0;
 
-	ret = mmc_flush_cache(card);
+////	ret = mmc_flush_cache(card);
 	if (ret)
 		ret = -EIO;
 
@@ -1528,7 +1495,7 @@ static int mmc_blk_packed_err_check(struct mmc_card *card,
 	return check;
 }
 
-static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
+void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 			       struct mmc_card *card,
 			       int disable_multi,
 			       struct mmc_queue *mq)
@@ -2204,7 +2171,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct mmc_queue_req *mqrq)
 	return 0;
 }
 
-static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req, struct mmc_queue_req *mqrq)
+int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req, struct mmc_queue_req *mqrq)
 {
 	int ret;
 	struct mmc_blk_data *md = mq->data;
@@ -2216,7 +2183,9 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req, struct mm
 	BUG_ON(!req);
 
 	/* claim host only for the first request */
-	mmc_get_card(card);
+////	pr_info("%s: enter mq->qcnt=%d\n", __func__, mq->qcnt);
+	if (mq->qcnt == 1)
+		mmc_get_card(card);
 
 	blk_mq_start_request(req);
 
@@ -2248,7 +2217,7 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req, struct mm
 out:
 	/* Release host when there are no more requests */
 /////	mmc_put_card(card);
-//	pr_info("%s: exit (mq=%p md=%p)\n", __func__, mq, md);
+////	pr_info("%s: exit (mq=%p md=%p)\n", __func__, mq, md);
 	return ret;
 }
 
@@ -2624,6 +2593,8 @@ static const struct mmc_fixup blk_fixups[] =
 	END_FIXUP
 };
 
+//static int probe_done = 0;
+
 static int mmc_blk_probe(struct mmc_card *card)
 {
 	struct mmc_blk_data *md, *part_md;
@@ -2635,6 +2606,10 @@ static int mmc_blk_probe(struct mmc_card *card)
 	if (!(card->csd.cmdclass & CCC_BLOCK_READ))
 		return -ENODEV;
 
+//	if (probe_done)
+//		return -ENODEV;
+//	probe_done = 1;
+
 	mmc_fixup_device(card, blk_fixups);
 
 	md = mmc_blk_alloc(card);
diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 038c01e..372ec0c2 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -78,7 +78,7 @@ struct mmc_queue_req *mmc_queue_req_find(struct mmc_queue *mq,
 
 ////	spin_lock_irq(req->q->queue_lock);
 	mqrq = &mq->mqrq[i];
-	WARN_ON(mqrq->testtag == 0);
+//	WARN_ON(mqrq->testtag == 0);
 	WARN_ON(mqrq->req || mq->qcnt >= mq->qdepth ||
 		test_bit(mqrq->task_id, &mq->qslots));
 	mqrq->req = req;
@@ -302,6 +302,16 @@ static void mmc_exit_request(void *data, struct request *rq,
 //	kfree(cmd->sense_buffer);
 }
 
+extern void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
+			       struct mmc_card *card,
+			       int disable_multi,
+			       struct mmc_queue *mq);
+
+extern void mmc_pre_req(struct mmc_host *host, struct mmc_request *mrq,
+		 bool is_first_req);
+
+static struct mmc_queue *probe_mq = NULL;
+
 static int mmc_queue_rq(struct blk_mq_hw_ctx *hctx,
 			 const struct blk_mq_queue_data *bd)
 {
@@ -311,15 +321,40 @@ static int mmc_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct mmc_queue_req *mqrq_cur;
 //	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(req);
 	int ret;
+	unsigned long flags = 0;
 
 	WARN_ON(req && req->cmd_type != REQ_TYPE_FS);
 
+	if (!probe_mq)
+		probe_mq = mq;
+
+	if (probe_mq && probe_mq != mq) {
+		return BLK_MQ_RQ_QUEUE_ERROR;
+	}
+
 	if (!mmc_queue_ready(q, mq))
 		return BLK_MQ_RQ_QUEUE_BUSY;
 
+	spin_lock_irqsave(&mq->async_lock, flags);
+////	pr_info("%s: enter mq->qcnt=%d\n", __func__, mq->qcnt);
 	mqrq_cur = mmc_queue_req_find(mq, req);
 	BUG_ON(!mqrq_cur);
-	mq->issue_fn(mq, req, mqrq_cur);
+	if (mq->qcnt == 2) {
+		if ((mqrq_cur->req->cmd_flags & (REQ_DISCARD | REQ_FLUSH)) == 0) {
+			struct mmc_blk_data *md = mq->data;
+			struct mmc_card *card = md->queue.card;
+			struct mmc_host *host = card->host;
+			struct mmc_async_req *areq;
+
+			mmc_blk_rw_rq_prep(mqrq_cur, card, 0, mq);
+			areq = &mqrq_cur->mmc_active;
+			mmc_pre_req(host, areq->mrq, 1);
+		}
+	}
+	if (mq->qcnt == 1)
+		mq->issue_fn(mq, req, mqrq_cur);
+////	pr_info("%s: exit mq->qcnt=%d\n", __func__, mq->qcnt);
+	spin_unlock_irqrestore(&mq->async_lock, flags);
 
 	return BLK_MQ_RQ_QUEUE_OK;
 }
@@ -333,6 +368,7 @@ static struct blk_mq_ops mmc_mq_ops = {
 	.exit_request	= mmc_exit_request,
 };
 
+//static int q_probe = 0;
 
 /**
  * mmc_init_queue - initialise a queue structure.
@@ -352,6 +388,10 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 	bool bounce = false;
 	int ret = -ENOMEM;
 
+//	if (q_probe)
+//		return -ENOMEM;
+//	q_probe = 1;
+
 	if (mmc_dev(host)->dma_mask && *mmc_dev(host)->dma_mask)
 		limit = (u64)dma_max_pfn(mmc_dev(host)) << PAGE_SHIFT;
 
@@ -361,7 +401,7 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 //		return -ENOMEM;
 	memset(&mq->tag_set, 0, sizeof(mq->tag_set));
 	mq->tag_set.ops = &mmc_mq_ops;
-	mq->tag_set.queue_depth = 1;
+	mq->tag_set.queue_depth = 2;
 	mq->tag_set.numa_node = NUMA_NO_NODE;
 	mq->tag_set.flags =
 		BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_SG_MERGE;
@@ -379,12 +419,13 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 	}
 	mq->queue = q;
 
-	mq->qdepth = 1;
+	mq->qdepth = 2;
 	mq->mqrq = mmc_queue_alloc_mqrqs(mq, mq->qdepth);
 	if (!mq->mqrq)
 		goto blk_cleanup;
 	mq->testtag = 1;
 	mq->queue->queuedata = mq;
+	spin_lock_init(&mq->async_lock);
 
 	blk_queue_prep_rq(mq->queue, mmc_prep_request);
 	queue_flag_set_unlocked(QUEUE_FLAG_NONROT, mq->queue);
diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
index b67ac83..99dacb7 100644
--- a/drivers/mmc/card/queue.h
+++ b/drivers/mmc/card/queue.h
@@ -66,6 +66,42 @@ struct mmc_queue {
 
 	/* Block layer tags. */
 	struct blk_mq_tag_set	tag_set;
+
+	spinlock_t		async_lock;
+};
+
+/*
+ * There is one mmc_blk_data per slot.
+ */
+struct mmc_blk_data {
+	spinlock_t	lock;
+	struct gendisk	*disk;
+	struct mmc_queue queue;
+	struct list_head part;
+
+	unsigned int	flags;
+#define MMC_BLK_CMD23	(1 << 0)	/* Can do SET_BLOCK_COUNT for multiblock */
+#define MMC_BLK_REL_WR	(1 << 1)	/* MMC Reliable write support */
+#define MMC_BLK_PACKED_CMD	(1 << 2)	/* MMC packed command support */
+
+	unsigned int	usage;
+	unsigned int	read_only;
+	unsigned int	part_type;
+	unsigned int	reset_done;
+#define MMC_BLK_READ		BIT(0)
+#define MMC_BLK_WRITE		BIT(1)
+#define MMC_BLK_DISCARD		BIT(2)
+#define MMC_BLK_SECDISCARD	BIT(3)
+
+	/*
+	 * Only set in main mmc_blk_data associated
+	 * with mmc_card with dev_set_drvdata, and keeps
+	 * track of the current selected device partition.
+	 */
+	unsigned int	part_curr;
+	struct device_attribute force_ro;
+	struct device_attribute power_ro_lock;
+	int	area_type;
 };
 
 extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, spinlock_t *,
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 64687f1..ebb6ed5 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -415,6 +415,9 @@ EXPORT_SYMBOL(mmc_start_bkops);
 static void mmc_post_req(struct mmc_host *host, struct mmc_request *mrq,
 			 int err);
 
+int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req, struct mmc_queue_req *mqrq);
+int __mmc_start_req(struct mmc_host *host, struct mmc_request *mrq, struct mmc_queue_req *mqrq);
+
 /*
  * mmc_wait_done() - done callback for request
  * @mrq: done request
@@ -431,8 +434,18 @@ static void mmc_wait_done(struct mmc_request *mrq)
 //	struct mmc_queue_req *mq_rq = container_of(areq, struct mmc_queue_req, mmc_active);
 	struct mmc_command *cmd;
 	int err = 0, ret = 0;
+	unsigned long flags = 0;
+	struct mmc_queue *mq = NULL;
 
-//	pr_info("%s: enter\n", __func__);
+	if (mq_rq)
+		mq = mq_rq->req->q->queuedata;
+
+////	pr_info("%s: enter\n", __func__);
+
+	if (mq) {
+		spin_lock_irqsave(&mq->async_lock, flags);
+////		pr_info("%s: enter mq\n", __func__);
+	}
 
 	cmd = mrq->cmd;
 //	pr_info("%s: cmd->opcode=%d mq_rq=%p\n", __func__, cmd->opcode, mq_rq);
@@ -459,11 +472,28 @@ static void mmc_wait_done(struct mmc_request *mrq)
 		cmd->error = 0;
 		__mmc_start_request(host, mrq);
 //		goto out;
+		if (mq)
+			spin_unlock_irqrestore(&mq->async_lock, flags);
 		return;
 	}
 
 	mmc_retune_release(host);
 
+	if (mq && mq->qcnt == 2) {
+		struct mmc_queue_req *mq_rq2 = &mq->mqrq[!mq_rq->task_id];
+
+		if (mq_rq2 &&
+		    (mq_rq2->req->cmd_type == REQ_TYPE_FS) &&
+			(mq_rq2->req->cmd_flags & (REQ_DISCARD | REQ_FLUSH))) {
+			mmc_blk_issue_rq(mq, mq_rq2->req, mq_rq2);
+		} else {
+			struct mmc_async_req *areq;
+
+			areq = &mq_rq2->mmc_active;
+			__mmc_start_req(host, areq->mrq, mq_rq2);
+		}
+	}
+
 //	host->areq->pre_req_done = false;
 	if (mq_rq &&
 	    (mq_rq->req->cmd_type == REQ_TYPE_FS) &&
@@ -472,7 +502,7 @@ static void mmc_wait_done(struct mmc_request *mrq)
 	}
 
 	complete(&mrq->completion);
-BUG_ON(mq_rq && (mq_rq->req->cmd_type == REQ_TYPE_FS) && (mq_rq->req->cmd_flags & (REQ_DISCARD | REQ_FLUSH)));
+//BUG_ON(mq_rq && (mq_rq->req->cmd_type == REQ_TYPE_FS) && (mq_rq->req->cmd_flags & (REQ_DISCARD | REQ_FLUSH)));
 	if (mq_rq &&
 	    (mq_rq->req->cmd_type == REQ_TYPE_FS) &&
 	    ((mq_rq->req->cmd_flags & (REQ_DISCARD | REQ_FLUSH)) == 0)) {
@@ -487,7 +517,9 @@ BUG_ON(mq_rq && (mq_rq->req->cmd_type == REQ_TYPE_FS) && (mq_rq->req->cmd_flags
 		mmc_queue_bounce_post(mq_rq);
 
 		bytes = brq->data.bytes_xfered;
-		mmc_put_card(host->card);
+////		pr_info("%s: enter mq->qcnt=%d\n", __func__, mq->qcnt);
+		if (mq->qcnt == 1)
+			mmc_put_card(host->card);
 //		pr_info("%s: freeing mqrq\n", __func__); //
 		mmc_queue_req_free(req->q->queuedata, mq_rq); //
 //		ret = blk_end_request(req, 0, bytes);
@@ -496,7 +528,9 @@ BUG_ON(mq_rq && (mq_rq->req->cmd_type == REQ_TYPE_FS) && (mq_rq->req->cmd_flags
 			__blk_mq_end_request(req, 0);
 	}
 //out:
-//	pr_info("%s: exit (err=%d, ret=%d)\n", __func__, err, ret);
+////	pr_info("%s: exit (err=%d, ret=%d)\n", __func__, err, ret);
+	if (mq)
+		spin_unlock_irqrestore(&mq->async_lock, flags);
 }
 
 static inline void mmc_wait_ongoing_tfr_cmd(struct mmc_host *host)
@@ -521,7 +555,7 @@ static inline void mmc_wait_ongoing_tfr_cmd(struct mmc_host *host)
  * If an ongoing transfer is already in progress, wait for the command line
  * to become available before sending another command.
  */
-static int __mmc_start_req(struct mmc_host *host, struct mmc_request *mrq, struct mmc_queue_req *mqrq)
+int __mmc_start_req(struct mmc_host *host, struct mmc_request *mrq, struct mmc_queue_req *mqrq)
 {
 	int err;
 
@@ -675,7 +709,7 @@ EXPORT_SYMBOL(mmc_is_req_done);
  *	host prepare for the new request. Preparation of a request may be
  *	performed while another request is running on the host.
  */
-static void mmc_pre_req(struct mmc_host *host, struct mmc_request *mrq,
+void mmc_pre_req(struct mmc_host *host, struct mmc_request *mrq,
 		 bool is_first_req)
 {
 	if (host->ops->pre_req)
@@ -797,9 +831,10 @@ void mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq)
 	if (!mrq->cap_cmd_during_tfr) {
 //		mmc_wait_for_req_done(host, mrq);
 //		BUG(); //
-//		pr_info("%s: wait start\n", __func__);
-		wait_for_completion(&mrq->completion);
-//		pr_info("%s: wait done\n", __func__);
+////		pr_info("%s: wait start\n", __func__);
+		mdelay(500);
+		//wait_for_completion(&mrq->completion);
+////		pr_info("%s: wait done\n", __func__);
 	}
 
 //	pr_info("%s: exit\n", __func__);
@@ -1097,9 +1132,9 @@ int __mmc_claim_host(struct mmc_host *host, atomic_t *abort)
 {
 	DECLARE_WAITQUEUE(wait, current);
 	unsigned long flags;
-	int stop;
+	int stop = 0; //
 	bool pm = false;
-
+#if 0
 	might_sleep();
 
 	add_wait_queue(&host->wq, &wait);
@@ -1114,17 +1149,20 @@ int __mmc_claim_host(struct mmc_host *host, atomic_t *abort)
 		spin_lock_irqsave(&host->lock, flags);
 	}
 	set_current_state(TASK_RUNNING);
+#endif
 	if (!stop) {
 		host->claimed = 1;
 		host->claimer = current;
 		host->claim_cnt += 1;
 		if (host->claim_cnt == 1)
 			pm = true;
+	}
+#if 0
 	} else
 		wake_up(&host->wq);
 	spin_unlock_irqrestore(&host->lock, flags);
 	remove_wait_queue(&host->wq, &wait);
-
+#endif
 	if (pm)
 		pm_runtime_get_sync(mmc_dev(host));
 
@@ -1145,15 +1183,15 @@ void mmc_release_host(struct mmc_host *host)
 
 	WARN_ON(!host->claimed);
 
-	spin_lock_irqsave(&host->lock, flags);
+//	spin_lock_irqsave(&host->lock, flags);
 	if (--host->claim_cnt) {
 		/* Release for nested claim */
-		spin_unlock_irqrestore(&host->lock, flags);
+//		spin_unlock_irqrestore(&host->lock, flags);
 	} else {
 		host->claimed = 0;
 		host->claimer = NULL;
-		spin_unlock_irqrestore(&host->lock, flags);
-		wake_up(&host->wq);
+//		spin_unlock_irqrestore(&host->lock, flags);
+//		wake_up(&host->wq);
 		pm_runtime_mark_last_busy(mmc_dev(host));
 		pm_runtime_put_autosuspend(mmc_dev(host));
 	}
-- 
1.9.1
