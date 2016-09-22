From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH PoC 6/7] mmc-mq: initial blk-mq support
Date: Thu, 22 Sep 2016 15:57:09 +0200
Message-ID: <1474552630-28314-7-git-send-email-b.zolnierkie@samsung.com>
References: <1474552630-28314-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1474552630-28314-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.com>, Tejun Heo <tj@kernel.org>, Omar Sandoval <osandov@osandov.com>, Christoph Hellwig <hch@lst.de>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/mmc/card/block.c | 15 +++++----
 drivers/mmc/card/queue.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++--
 drivers/mmc/card/queue.h |  3 ++
 drivers/mmc/core/core.c  |  7 ++--
 4 files changed, 98 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index ef230e8..9968623 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -27,6 +27,7 @@
 #include <linux/errno.h>
 #include <linux/hdreg.h>
 #include <linux/kdev_t.h>
+#include <linux/blk-mq.h>
 #include <linux/blkdev.h>
 #include <linux/mutex.h>
 #include <linux/scatterlist.h>
@@ -1235,7 +1236,7 @@ out:
 		mmc_blk_reset_success(md, type);
 	mmc_put_card(card);
 	mmc_queue_req_free(mq, mqrq);
-	blk_end_request(req, err, blk_rq_bytes(req));
+	blk_mq_end_request(req, err);
 
 	return err ? 0 : 1;
 }
@@ -1304,7 +1305,7 @@ out_retry:
 out:
 	mmc_put_card(card);
 	mmc_queue_req_free(mq, mqrq);
-	blk_end_request(req, err, blk_rq_bytes(req));
+	blk_mq_end_request(req, err);
 
 	return err ? 0 : 1;
 }
@@ -1321,16 +1322,14 @@ static int mmc_blk_issue_flush(struct mmc_queue *mq, struct request *req, struct
 
 	mmc_put_card(card);
 	mmc_queue_req_free(mq, mqrq);
-	blk_end_request_all(req, ret);
+	blk_mq_end_request(req, ret);
 
 	return ret ? 0 : 1;
 }
 
 static void mmc_blk_requeue(struct request_queue *q, struct request *req)
 {
-	spin_lock_irq(q->queue_lock);
-	blk_requeue_request(q, req);
-	spin_unlock_irq(q->queue_lock);
+	blk_mq_requeue_request(req);
 }
 
 /*
@@ -2219,12 +2218,14 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req, struct mm
 	/* claim host only for the first request */
 	mmc_get_card(card);
 
+	blk_mq_start_request(req);
+
 //	pr_info("%s: mmc_blk_part_switch (mq=%p md=%p)\n", __func__, mq, md);
 	ret = mmc_blk_part_switch(card, md);
 	if (ret) {
 		if (req) {
 			mmc_queue_req_free(req->q->queuedata, mqrq); //
-			blk_end_request_all(req, -EIO);
+			blk_mq_end_request(req, -EIO);
 		}
 		ret = 0;
 		goto out;
diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index d4f4859..038c01e 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -11,6 +11,7 @@
  */
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/blk-mq.h>
 #include <linux/blkdev.h>
 #include <linux/freezer.h>
 #include <linux/kthread.h>
@@ -280,6 +281,59 @@ static void mmc_queue_reqs_free_bufs(struct mmc_queue *mq)
 		mmc_queue_req_free_bufs(&mq->mqrq[i]);
 }
 
+static int mmc_init_request(void *data, struct request *rq,
+		unsigned int hctx_idx, unsigned int request_idx,
+		unsigned int numa_node)
+{
+//	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(rq);
+
+//	cmd->sense_buffer = kzalloc_node(SCSI_SENSE_BUFFERSIZE, GFP_KERNEL,
+//			numa_node);
+//	if (!cmd->sense_buffer)
+//		return -ENOMEM;
+	return 0;
+}
+
+static void mmc_exit_request(void *data, struct request *rq,
+		unsigned int hctx_idx, unsigned int request_idx)
+{
+//	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(rq);
+
+//	kfree(cmd->sense_buffer);
+}
+
+static int mmc_queue_rq(struct blk_mq_hw_ctx *hctx,
+			 const struct blk_mq_queue_data *bd)
+{
+	struct request *req = bd->rq;
+	struct request_queue *q = req->q;
+	struct mmc_queue *mq = q->queuedata;
+	struct mmc_queue_req *mqrq_cur;
+//	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(req);
+	int ret;
+
+	WARN_ON(req && req->cmd_type != REQ_TYPE_FS);
+
+	if (!mmc_queue_ready(q, mq))
+		return BLK_MQ_RQ_QUEUE_BUSY;
+
+	mqrq_cur = mmc_queue_req_find(mq, req);
+	BUG_ON(!mqrq_cur);
+	mq->issue_fn(mq, req, mqrq_cur);
+
+	return BLK_MQ_RQ_QUEUE_OK;
+}
+
+static struct blk_mq_ops mmc_mq_ops = {
+	.map_queue	= blk_mq_map_queue,
+	.queue_rq	= mmc_queue_rq,
+//	.complete	= scsi_softirq_done,
+//	.timeout	= scsi_timeout,
+	.init_request	= mmc_init_request,
+	.exit_request	= mmc_exit_request,
+};
+
+
 /**
  * mmc_init_queue - initialise a queue structure.
  * @mq: mmc queue
@@ -293,6 +347,7 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 		   spinlock_t *lock, const char *subname)
 {
 	struct mmc_host *host = card->host;
+ 	struct request_queue *q;
 	u64 limit = BLK_BOUNCE_HIGH;
 	bool bounce = false;
 	int ret = -ENOMEM;
@@ -301,9 +356,28 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 		limit = (u64)dma_max_pfn(mmc_dev(host)) << PAGE_SHIFT;
 
 	mq->card = card;
-	mq->queue = blk_init_queue(mmc_request_fn, lock);
-	if (!mq->queue)
-		return -ENOMEM;
+//	mq->queue = blk_init_queue(mmc_request_fn, lock);
+//	if (!mq->queue)
+//		return -ENOMEM;
+	memset(&mq->tag_set, 0, sizeof(mq->tag_set));
+	mq->tag_set.ops = &mmc_mq_ops;
+	mq->tag_set.queue_depth = 1;
+	mq->tag_set.numa_node = NUMA_NO_NODE;
+	mq->tag_set.flags =
+		BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_SG_MERGE;
+	mq->tag_set.nr_hw_queues = 1;
+	mq->tag_set.cmd_size = sizeof(struct mmc_queue_req);
+
+	ret = blk_mq_alloc_tag_set(&mq->tag_set);
+	if (ret)
+		goto out;
+
+	q = blk_mq_init_queue(&mq->tag_set);
+	if (IS_ERR(q)) {
+		ret = PTR_ERR(q);
+		goto cleanup_tag_set;
+	}
+	mq->queue = q;
 
 	mq->qdepth = 1;
 	mq->mqrq = mmc_queue_alloc_mqrqs(mq, mq->qdepth);
@@ -366,6 +440,9 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 	mq->mqrq = NULL;
 blk_cleanup:
 	blk_cleanup_queue(mq->queue);
+cleanup_tag_set:
+	blk_mq_free_tag_set(&mq->tag_set);
+out:
 	return ret;
 }
 
@@ -387,6 +464,8 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
 	kfree(mq->mqrq);
 	mq->mqrq = NULL;
 
+	blk_mq_free_tag_set(&mq->tag_set);
+
 	mq->card = NULL;
 }
 EXPORT_SYMBOL(mmc_cleanup_queue);
diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
index 20399e4..b67ac83 100644
--- a/drivers/mmc/card/queue.h
+++ b/drivers/mmc/card/queue.h
@@ -63,6 +63,9 @@ struct mmc_queue {
 	int			testtag;
 
 	atomic_t		device_busy;
+
+	/* Block layer tags. */
+	struct blk_mq_tag_set	tag_set;
 };
 
 extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, spinlock_t *,
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 549e65e..64687f1 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -30,6 +30,7 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/kernel.h>
+#include <linux/blk-mq.h>
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
@@ -489,8 +490,10 @@ BUG_ON(mq_rq && (mq_rq->req->cmd_type == REQ_TYPE_FS) && (mq_rq->req->cmd_flags
 		mmc_put_card(host->card);
 //		pr_info("%s: freeing mqrq\n", __func__); //
 		mmc_queue_req_free(req->q->queuedata, mq_rq); //
-		ret = blk_end_request(req, 0, bytes);
-
+//		ret = blk_end_request(req, 0, bytes);
+		ret = blk_update_request(req, 0, bytes);
+		if (!ret)
+			__blk_mq_end_request(req, 0);
 	}
 //out:
 //	pr_info("%s: exit (err=%d, ret=%d)\n", __func__, err, ret);
-- 
1.9.1
