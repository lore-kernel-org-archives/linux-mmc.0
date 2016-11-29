From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V8 08/20] mmc: queue: Introduce queue depth and use it to allocate and free
Date: Tue, 29 Nov 2016 12:09:15 +0200
Message-ID: <1480414167-15577-9-git-send-email-adrian.hunter@intel.com>
References: <1480414167-15577-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:48807 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754395AbcK2KPD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 29 Nov 2016 05:15:03 -0500
In-Reply-To: <1480414167-15577-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

Add a mmc_queue member to record the size of the queue, which currently
supports 2 requests on-the-go at a time. Instead of allocating resources
for 2 slots in the queue, allow for an arbitrary number.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/card/queue.c | 115 +++++++++++++++++++++++------------------------
 drivers/mmc/card/queue.h |   3 +-
 2 files changed, 59 insertions(+), 59 deletions(-)

diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 7234cc48097e..48197545b539 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -189,86 +189,75 @@ static void mmc_queue_setup_discard(struct request_queue *q,
 static bool mmc_queue_alloc_bounce_bufs(struct mmc_queue *mq,
 					unsigned int bouncesz)
 {
-	struct mmc_queue_req *mqrq_cur = mq->mqrq_cur;
-	struct mmc_queue_req *mqrq_prev = mq->mqrq_prev;
-
-	mqrq_cur->bounce_buf = kmalloc(bouncesz, GFP_KERNEL);
-	if (!mqrq_cur->bounce_buf) {
-		pr_warn("%s: unable to allocate bounce cur buffer\n",
-			mmc_card_name(mq->card));
-		return false;
-	}
+	int i;
 
-	mqrq_prev->bounce_buf = kmalloc(bouncesz, GFP_KERNEL);
-	if (!mqrq_prev->bounce_buf) {
-		pr_warn("%s: unable to allocate bounce prev buffer\n",
-			mmc_card_name(mq->card));
-		kfree(mqrq_cur->bounce_buf);
-		mqrq_cur->bounce_buf = NULL;
-		return false;
+	for (i = 0; i < mq->qdepth; i++) {
+		mq->mqrq[i].bounce_buf = kmalloc(bouncesz, GFP_KERNEL);
+		if (!mq->mqrq[i].bounce_buf)
+			goto out_err;
 	}
 
 	return true;
+
+out_err:
+	while (--i >= 0) {
+		kfree(mq->mqrq[i].bounce_buf);
+		mq->mqrq[i].bounce_buf = NULL;
+	}
+	pr_warn("%s: unable to allocate bounce buffers\n",
+		mmc_card_name(mq->card));
+	return false;
 }
 
 static int mmc_queue_alloc_bounce_sgs(struct mmc_queue *mq,
 				      unsigned int bouncesz)
 {
-	struct mmc_queue_req *mqrq_cur = mq->mqrq_cur;
-	struct mmc_queue_req *mqrq_prev = mq->mqrq_prev;
-	int ret;
-
-	mqrq_cur->sg = mmc_alloc_sg(1, &ret);
-	if (ret)
-		return ret;
-
-	mqrq_cur->bounce_sg = mmc_alloc_sg(bouncesz / 512, &ret);
-	if (ret)
-		return ret;
+	int i, ret;
 
-	mqrq_prev->sg = mmc_alloc_sg(1, &ret);
-	if (ret)
-		return ret;
+	for (i = 0; i < mq->qdepth; i++) {
+		mq->mqrq[i].sg = mmc_alloc_sg(1, &ret);
+		if (ret)
+			return ret;
 
-	mqrq_prev->bounce_sg = mmc_alloc_sg(bouncesz / 512, &ret);
+		mq->mqrq[i].bounce_sg = mmc_alloc_sg(bouncesz / 512, &ret);
+		if (ret)
+			return ret;
+	}
 
-	return ret;
+	return 0;
 }
 
 static int mmc_queue_alloc_sgs(struct mmc_queue *mq, int max_segs)
 {
-	struct mmc_queue_req *mqrq_cur = mq->mqrq_cur;
-	struct mmc_queue_req *mqrq_prev = mq->mqrq_prev;
-	int ret;
+	int i, ret;
 
-	mqrq_cur->sg = mmc_alloc_sg(max_segs, &ret);
-	if (ret)
-		return ret;
+	for (i = 0; i < mq->qdepth; i++) {
+		mq->mqrq[i].sg = mmc_alloc_sg(max_segs, &ret);
+		if (ret)
+			return ret;
+	}
 
-	mqrq_prev->sg = mmc_alloc_sg(max_segs, &ret);
+	return 0;
+}
 
-	return ret;
+static void mmc_queue_req_free_bufs(struct mmc_queue_req *mqrq)
+{
+	kfree(mqrq->bounce_sg);
+	mqrq->bounce_sg = NULL;
+
+	kfree(mqrq->sg);
+	mqrq->sg = NULL;
+
+	kfree(mqrq->bounce_buf);
+	mqrq->bounce_buf = NULL;
 }
 
 static void mmc_queue_reqs_free_bufs(struct mmc_queue *mq)
 {
-	struct mmc_queue_req *mqrq_cur = mq->mqrq_cur;
-	struct mmc_queue_req *mqrq_prev = mq->mqrq_prev;
-
-	kfree(mqrq_cur->bounce_sg);
-	mqrq_cur->bounce_sg = NULL;
-	kfree(mqrq_prev->bounce_sg);
-	mqrq_prev->bounce_sg = NULL;
-
-	kfree(mqrq_cur->sg);
-	mqrq_cur->sg = NULL;
-	kfree(mqrq_cur->bounce_buf);
-	mqrq_cur->bounce_buf = NULL;
-
-	kfree(mqrq_prev->sg);
-	mqrq_prev->sg = NULL;
-	kfree(mqrq_prev->bounce_buf);
-	mqrq_prev->bounce_buf = NULL;
+	int i;
+
+	for (i = 0; i < mq->qdepth; i++)
+		mmc_queue_req_free_bufs(&mq->mqrq[i]);
 }
 
 /**
@@ -286,7 +275,7 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 	struct mmc_host *host = card->host;
 	u64 limit = BLK_BOUNCE_HIGH;
 	bool bounce = false;
-	int ret;
+	int ret = -ENOMEM;
 
 	if (mmc_dev(host)->dma_mask && *mmc_dev(host)->dma_mask)
 		limit = (u64)dma_max_pfn(mmc_dev(host)) << PAGE_SHIFT;
@@ -296,6 +285,11 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 	if (!mq->queue)
 		return -ENOMEM;
 
+	mq->qdepth = 2;
+	mq->mqrq = kcalloc(mq->qdepth, sizeof(struct mmc_queue_req),
+			   GFP_KERNEL);
+	if (!mq->mqrq)
+		goto blk_cleanup;
 	mq->mqrq_cur = &mq->mqrq[0];
 	mq->mqrq_prev = &mq->mqrq[1];
 	mq->queue->queuedata = mq;
@@ -360,6 +354,9 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 
  cleanup_queue:
 	mmc_queue_reqs_free_bufs(mq);
+	kfree(mq->mqrq);
+	mq->mqrq = NULL;
+blk_cleanup:
 	blk_cleanup_queue(mq->queue);
 	return ret;
 }
@@ -382,6 +379,8 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
 	spin_unlock_irqrestore(q->queue_lock, flags);
 
 	mmc_queue_reqs_free_bufs(mq);
+	kfree(mq->mqrq);
+	mq->mqrq = NULL;
 
 	mq->card = NULL;
 }
diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
index d09fce655800..dac8c3d010dd 100644
--- a/drivers/mmc/card/queue.h
+++ b/drivers/mmc/card/queue.h
@@ -42,9 +42,10 @@ struct mmc_queue {
 	bool			asleep;
 	struct mmc_blk_data	*blkdata;
 	struct request_queue	*queue;
-	struct mmc_queue_req	mqrq[2];
+	struct mmc_queue_req	*mqrq;
 	struct mmc_queue_req	*mqrq_cur;
 	struct mmc_queue_req	*mqrq_prev;
+	int			qdepth;
 };
 
 extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, spinlock_t *,
-- 
1.9.1

