From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH PoC 4/7] mmc-mq: implement checking for queue busy condition
Date: Thu, 22 Sep 2016 15:57:07 +0200
Message-ID: <1474552630-28314-5-git-send-email-b.zolnierkie@samsung.com>
References: <1474552630-28314-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1474552630-28314-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.com>, Tejun Heo <tj@kernel.org>, Omar Sandoval <osandov@osandov.com>, Christoph Hellwig <hch@lst.de>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/mmc/card/queue.c | 28 +++++++++++++++++++++++-----
 drivers/mmc/card/queue.h |  2 ++
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 6fd711d..3ed4477 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -46,6 +46,21 @@ static int mmc_prep_request(struct request_queue *q, struct request *req)
 	return BLKPREP_OK;
 }
 
+int mmc_queue_ready(struct request_queue *q, struct mmc_queue *mq)
+{
+	unsigned int busy;
+
+	busy = atomic_inc_return(&mq->device_busy) - 1;
+
+	if (busy >= mq->qdepth)
+		goto out_dec;
+
+	return 1;
+out_dec:
+	atomic_dec(&mq->device_busy);
+	return 0;
+}
+
 struct mmc_queue_req *mmc_queue_req_find(struct mmc_queue *mq,
 					 struct request *req)
 {
@@ -81,13 +96,14 @@ void mmc_queue_req_free(struct mmc_queue *mq,
 	struct request *req;
 	pr_info("%s: enter\n", __func__);
 	req = mqrq->req;
-	spin_lock_irq(req->q->queue_lock);
+////	spin_lock_irq(req->q->queue_lock);
 	WARN_ON(!mqrq->req || mq->qcnt < 1 ||
 		!test_bit(mqrq->task_id, &mq->qslots));
 	mqrq->req = NULL;
 	mq->qcnt -= 1;
 	__clear_bit(mqrq->task_id, &mq->qslots);
-	spin_unlock_irq(req->q->queue_lock);
+////	spin_unlock_irq(req->q->queue_lock);
+	atomic_dec(&mq->device_busy);
 	pr_info("%s: exit\n", __func__);
 }
 
@@ -114,9 +130,9 @@ repeat:
 	req = blk_fetch_request(q);
 	WARN_ON(req && req->cmd_type != REQ_TYPE_FS);
 	if (req && req->cmd_type == REQ_TYPE_FS) {
-		mqrq_cur = mmc_queue_req_find(mq, req);
-		if (!mqrq_cur) {
-			pr_info("%s: command already queued (%d)\n", __func__, mq->qcnt);
+		if (mmc_queue_ready(q, mq)) {
+		} else {
+			pr_info("%s: command already queued\n", __func__);
 //			WARN_ON(1);
 //			spin_unlock_irq(q->queue_lock);
 			blk_requeue_request(mq->queue, req);
@@ -129,6 +145,8 @@ repeat:
 		return;
 	}
 	spin_unlock_irq(q->queue_lock);
+	mqrq_cur = mmc_queue_req_find(mq, req);
+	BUG_ON(!mqrq_cur);
 	mq->issue_fn(mq, req, mqrq_cur);
 	spin_lock_irq(q->queue_lock);
 	goto repeat;
diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
index 3adf1bc..20399e4 100644
--- a/drivers/mmc/card/queue.h
+++ b/drivers/mmc/card/queue.h
@@ -61,6 +61,8 @@ struct mmc_queue {
 	unsigned long		qslots;
 
 	int			testtag;
+
+	atomic_t		device_busy;
 };
 
 extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, spinlock_t *,
-- 
1.9.1
