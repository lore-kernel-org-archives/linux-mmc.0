From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V8 17/20] mmc: queue: Share mmc request array between partitions
Date: Tue, 29 Nov 2016 12:09:24 +0200
Message-ID: <1480414167-15577-18-git-send-email-adrian.hunter@intel.com>
References: <1480414167-15577-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:37725 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755213AbcK2KPj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 29 Nov 2016 05:15:39 -0500
In-Reply-To: <1480414167-15577-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

eMMC can have multiple internal partitions that are represented as separate
disks / queues. However the card has only 1 command queue which must be
empty when switching partitions. Consequently the array of mmc requests
that are queued can be shared between partitions saving memory.

Keep a pointer to the mmc request queue on the card, and use that instead
of allocating a new one for each partition. Use a reference count to keep
track of when to free it. Queues are allocated and deallocated via
mmc_blk_probe() and mmc_blk_probe() so no other synchronization is needed
for the reference count.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/card/queue.c | 42 ++++++++++++++++++++++++++++++++++++------
 include/linux/mmc/card.h |  4 ++++
 2 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 34e5be6b94ae..63daf53b7246 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -200,10 +200,22 @@ static struct mmc_queue_req *mmc_queue_alloc_mqrqs(struct mmc_queue *mq,
 	struct mmc_queue_req *mqrq;
 	int i;
 
+	if (mq->card->mqrq) {
+		/*
+		 * Queues are allocated and deallocated via mmc_blk_probe() and
+		 * mmc_blk_probe() so no other synchronization is needed for
+		 * mqrq_ref_cnt.
+		 */
+		mq->card->mqrq_ref_cnt += 1;
+		return mq->card->mqrq;
+	}
+
 	mqrq = kcalloc(qdepth, sizeof(*mqrq), GFP_KERNEL);
 	if (mqrq) {
 		for (i = 0; i < mq->qdepth; i++)
 			mqrq[i].task_id = i;
+		mq->card->mqrq = mqrq;
+		mq->card->mqrq_ref_cnt = 1;
 	}
 
 	return mqrq;
@@ -214,6 +226,9 @@ static bool mmc_queue_alloc_bounce_bufs(struct mmc_queue *mq,
 {
 	int i;
 
+	if (mq->card->mqrq_ref_cnt > 1)
+		return !!mq->mqrq[0].bounce_buf;
+
 	for (i = 0; i < mq->qdepth; i++) {
 		mq->mqrq[i].bounce_buf = kmalloc(bouncesz, GFP_KERNEL);
 		if (!mq->mqrq[i].bounce_buf)
@@ -237,6 +252,9 @@ static int mmc_queue_alloc_bounce_sgs(struct mmc_queue *mq,
 {
 	int i, ret;
 
+	if (mq->card->mqrq_ref_cnt > 1)
+		return 0;
+
 	for (i = 0; i < mq->qdepth; i++) {
 		mq->mqrq[i].sg = mmc_alloc_sg(1, &ret);
 		if (ret)
@@ -254,6 +272,9 @@ static int mmc_queue_alloc_sgs(struct mmc_queue *mq, int max_segs)
 {
 	int i, ret;
 
+	if (mq->card->mqrq_ref_cnt > 1)
+		return 0;
+
 	for (i = 0; i < mq->qdepth; i++) {
 		mq->mqrq[i].sg = mmc_alloc_sg(max_segs, &ret);
 		if (ret)
@@ -283,6 +304,19 @@ static void mmc_queue_reqs_free_bufs(struct mmc_queue *mq)
 		mmc_queue_req_free_bufs(&mq->mqrq[i]);
 }
 
+static void mmc_queue_free_mqrqs(struct mmc_queue *mq)
+{
+	if (!mq->mqrq)
+		return;
+
+	if (!--mq->card->mqrq_ref_cnt) {
+		mmc_queue_reqs_free_bufs(mq);
+		kfree(mq->card->mqrq);
+		mq->card->mqrq = NULL;
+	}
+	mq->mqrq = NULL;
+}
+
 /**
  * mmc_init_queue - initialise a queue structure.
  * @mq: mmc queue
@@ -373,9 +407,7 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 	return 0;
 
  cleanup_queue:
-	mmc_queue_reqs_free_bufs(mq);
-	kfree(mq->mqrq);
-	mq->mqrq = NULL;
+	mmc_queue_free_mqrqs(mq);
 blk_cleanup:
 	blk_cleanup_queue(mq->queue);
 	return ret;
@@ -398,9 +430,7 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
 	blk_start_queue(q);
 	spin_unlock_irqrestore(q->queue_lock, flags);
 
-	mmc_queue_reqs_free_bufs(mq);
-	kfree(mq->mqrq);
-	mq->mqrq = NULL;
+	mmc_queue_free_mqrqs(mq);
 
 	mq->card = NULL;
 }
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 5ac2243bc5a9..47399bcab659 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -207,6 +207,7 @@ struct sdio_cis {
 struct mmc_ios;
 struct sdio_func;
 struct sdio_func_tuple;
+struct mmc_queue_req;
 
 #define SDIO_MAX_FUNCS		7
 
@@ -308,6 +309,9 @@ struct mmc_card {
 	struct dentry		*debugfs_root;
 	struct mmc_part	part[MMC_NUM_PHY_PARTITION]; /* physical partitions */
 	unsigned int    nr_parts;
+
+	struct mmc_queue_req	*mqrq;		/* Shared queue structure */
+	unsigned int		mqrq_ref_cnt;	/* Shared queue ref. count */
 };
 
 /*
-- 
1.9.1

