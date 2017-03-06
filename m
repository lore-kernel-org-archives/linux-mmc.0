From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V1 01/18] mmc: queue: Share mmc request array between partitions
Date: Mon,  6 Mar 2017 11:10:56 +0200
Message-ID: <1488791473-24981-2-git-send-email-adrian.hunter@intel.com>
References: <1488791473-24981-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:15497 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753314AbdCFJRQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 6 Mar 2017 04:17:16 -0500
In-Reply-To: <1488791473-24981-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

eMMC can have multiple internal partitions that are represented as separate
disks / queues. However switching between partitions is only done when the
queue is empty. Consequently the array of mmc requests that are queued can
be shared between partitions saving memory.

Keep a pointer to the mmc request queue on the card, and use that instead
of allocating a new one for each partition.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/block.c |  11 ++-
 drivers/mmc/core/queue.c | 235 ++++++++++++++++++++++++++++-------------------
 drivers/mmc/core/queue.h |   2 +
 include/linux/mmc/card.h |   5 +
 4 files changed, 156 insertions(+), 97 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 1621fa08e206..efd640c97b0b 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2106,6 +2106,7 @@ static int mmc_blk_probe(struct mmc_card *card)
 {
 	struct mmc_blk_data *md, *part_md;
 	char cap_str[10];
+	int ret;
 
 	/*
 	 * Check that the card supports the command class(es) we need.
@@ -2115,9 +2116,15 @@ static int mmc_blk_probe(struct mmc_card *card)
 
 	mmc_fixup_device(card, mmc_blk_fixups);
 
+	ret = mmc_queue_alloc_shared_queue(card);
+	if (ret)
+		return ret;
+
 	md = mmc_blk_alloc(card);
-	if (IS_ERR(md))
+	if (IS_ERR(md)) {
+		mmc_queue_free_shared_queue(card);
 		return PTR_ERR(md);
+	}
 
 	string_get_size((u64)get_capacity(md->disk), 512, STRING_UNITS_2,
 			cap_str, sizeof(cap_str));
@@ -2155,6 +2162,7 @@ static int mmc_blk_probe(struct mmc_card *card)
  out:
 	mmc_blk_remove_parts(card, md);
 	mmc_blk_remove_req(md);
+	mmc_queue_free_shared_queue(card);
 	return 0;
 }
 
@@ -2172,6 +2180,7 @@ static void mmc_blk_remove(struct mmc_card *card)
 	pm_runtime_put_noidle(&card->dev);
 	mmc_blk_remove_req(md);
 	dev_set_drvdata(&card->dev, NULL);
+	mmc_queue_free_shared_queue(card);
 }
 
 static int _mmc_blk_suspend(struct mmc_card *card)
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 493eb10ce580..0f2a50f7cad2 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -141,17 +141,13 @@ static void mmc_request_fn(struct request_queue *q)
 		wake_up_process(mq->thread);
 }
 
-static struct scatterlist *mmc_alloc_sg(int sg_len, int *err)
+static struct scatterlist *mmc_alloc_sg(int sg_len)
 {
 	struct scatterlist *sg;
 
 	sg = kmalloc_array(sg_len, sizeof(*sg), GFP_KERNEL);
-	if (!sg)
-		*err = -ENOMEM;
-	else {
-		*err = 0;
+	if (sg)
 		sg_init_table(sg, sg_len);
-	}
 
 	return sg;
 }
@@ -177,80 +173,164 @@ static void mmc_queue_setup_discard(struct request_queue *q,
 		queue_flag_set_unlocked(QUEUE_FLAG_SECERASE, q);
 }
 
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
+}
+
+static void mmc_queue_reqs_free_bufs(struct mmc_queue_req *mqrq, int qdepth)
+{
+	int i;
+
+	for (i = 0; i < qdepth; i++)
+		mmc_queue_req_free_bufs(&mqrq[i]);
+}
+
+static void mmc_queue_free_mqrqs(struct mmc_queue_req *mqrq, int qdepth)
+{
+	mmc_queue_reqs_free_bufs(mqrq, qdepth);
+	kfree(mqrq);
+}
+
 #ifdef CONFIG_MMC_BLOCK_BOUNCE
-static bool mmc_queue_alloc_bounce_bufs(struct mmc_queue *mq,
-					unsigned int bouncesz)
+static int mmc_queue_alloc_bounce_bufs(struct mmc_queue_req *mqrq, int qdepth,
+				       unsigned int bouncesz)
 {
 	int i;
 
-	for (i = 0; i < mq->qdepth; i++) {
-		mq->mqrq[i].bounce_buf = kmalloc(bouncesz, GFP_KERNEL);
-		if (!mq->mqrq[i].bounce_buf)
-			goto out_err;
-	}
+	for (i = 0; i < qdepth; i++) {
+		mqrq[i].bounce_buf = kmalloc(bouncesz, GFP_KERNEL);
+		if (!mqrq[i].bounce_buf)
+			return -ENOMEM;
 
-	return true;
+		mqrq[i].sg = mmc_alloc_sg(1);
+		if (!mqrq[i].sg)
+			return -ENOMEM;
 
-out_err:
-	while (--i >= 0) {
-		kfree(mq->mqrq[i].bounce_buf);
-		mq->mqrq[i].bounce_buf = NULL;
+		mqrq[i].bounce_sg = mmc_alloc_sg(bouncesz / 512);
+		if (!mqrq[i].bounce_sg)
+			return -ENOMEM;
 	}
-	pr_warn("%s: unable to allocate bounce buffers\n",
-		mmc_card_name(mq->card));
-	return false;
+
+	return 0;
 }
 
-static int mmc_queue_alloc_bounce_sgs(struct mmc_queue *mq,
-				      unsigned int bouncesz)
+static bool mmc_queue_alloc_bounce(struct mmc_queue_req *mqrq, int qdepth,
+				   unsigned int bouncesz)
 {
-	int i, ret;
+	int ret;
 
-	for (i = 0; i < mq->qdepth; i++) {
-		mq->mqrq[i].sg = mmc_alloc_sg(1, &ret);
-		if (ret)
-			return ret;
+	ret = mmc_queue_alloc_bounce_bufs(mqrq, qdepth, bouncesz);
+	if (ret)
+		mmc_queue_reqs_free_bufs(mqrq, qdepth);
 
-		mq->mqrq[i].bounce_sg = mmc_alloc_sg(bouncesz / 512, &ret);
-		if (ret)
-			return ret;
-	}
+	return !ret;
+}
+
+static unsigned int mmc_queue_calc_bouncesz(struct mmc_host *host)
+{
+	unsigned int bouncesz = MMC_QUEUE_BOUNCESZ;
+
+	if (host->max_segs != 1)
+		return 0;
+
+	if (bouncesz > host->max_req_size)
+		bouncesz = host->max_req_size;
+	if (bouncesz > host->max_seg_size)
+		bouncesz = host->max_seg_size;
+	if (bouncesz > host->max_blk_count * 512)
+		bouncesz = host->max_blk_count * 512;
+
+	if (bouncesz <= 512)
+		return 0;
+
+	return bouncesz;
+}
+#else
+static inline bool mmc_queue_alloc_bounce(struct mmc_queue_req *mqrq,
+					  int qdepth, unsigned int bouncesz)
+{
+	return false;
+}
 
+static unsigned int mmc_queue_calc_bouncesz(struct mmc_host *host)
+{
 	return 0;
 }
 #endif
 
-static int mmc_queue_alloc_sgs(struct mmc_queue *mq, int max_segs)
+static int mmc_queue_alloc_sgs(struct mmc_queue_req *mqrq, int qdepth,
+			       int max_segs)
 {
-	int i, ret;
+	int i;
 
-	for (i = 0; i < mq->qdepth; i++) {
-		mq->mqrq[i].sg = mmc_alloc_sg(max_segs, &ret);
-		if (ret)
-			return ret;
+	for (i = 0; i < qdepth; i++) {
+		mqrq[i].sg = mmc_alloc_sg(max_segs);
+		if (!mqrq[i].sg)
+			return -ENOMEM;
 	}
 
 	return 0;
 }
 
-static void mmc_queue_req_free_bufs(struct mmc_queue_req *mqrq)
+void mmc_queue_free_shared_queue(struct mmc_card *card)
 {
-	kfree(mqrq->bounce_sg);
-	mqrq->bounce_sg = NULL;
+	if (card->mqrq) {
+		mmc_queue_free_mqrqs(card->mqrq, card->qdepth);
+		card->mqrq = NULL;
+	}
+}
 
-	kfree(mqrq->sg);
-	mqrq->sg = NULL;
+static int __mmc_queue_alloc_shared_queue(struct mmc_card *card, int qdepth)
+{
+	struct mmc_host *host = card->host;
+	struct mmc_queue_req *mqrq;
+	unsigned int bouncesz;
+	int ret = 0;
 
-	kfree(mqrq->bounce_buf);
-	mqrq->bounce_buf = NULL;
+	if (card->mqrq)
+		return -EINVAL;
+
+	mqrq = kcalloc(qdepth, sizeof(*mqrq), GFP_KERNEL);
+	if (!mqrq)
+		return -ENOMEM;
+
+	card->mqrq = mqrq;
+	card->qdepth = qdepth;
+
+	bouncesz = mmc_queue_calc_bouncesz(host);
+
+	if (bouncesz && !mmc_queue_alloc_bounce(mqrq, qdepth, bouncesz)) {
+		bouncesz = 0;
+		pr_warn("%s: unable to allocate bounce buffers\n",
+			mmc_card_name(card));
+	}
+
+	card->bouncesz = bouncesz;
+
+	if (!bouncesz) {
+		ret = mmc_queue_alloc_sgs(mqrq, qdepth, host->max_segs);
+		if (ret)
+			goto out_err;
+	}
+
+	return ret;
+
+out_err:
+	mmc_queue_free_shared_queue(card);
+	return ret;
 }
 
-static void mmc_queue_reqs_free_bufs(struct mmc_queue *mq)
+int mmc_queue_alloc_shared_queue(struct mmc_card *card)
 {
-	int i;
-
-	for (i = 0; i < mq->qdepth; i++)
-		mmc_queue_req_free_bufs(&mq->mqrq[i]);
+	return __mmc_queue_alloc_shared_queue(card, 2);
 }
 
 /**
@@ -267,7 +347,6 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 {
 	struct mmc_host *host = card->host;
 	u64 limit = BLK_BOUNCE_HIGH;
-	bool bounce = false;
 	int ret = -ENOMEM;
 
 	if (mmc_dev(host)->dma_mask && *mmc_dev(host)->dma_mask)
@@ -278,11 +357,8 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 	if (!mq->queue)
 		return -ENOMEM;
 
-	mq->qdepth = 2;
-	mq->mqrq = kcalloc(mq->qdepth, sizeof(struct mmc_queue_req),
-			   GFP_KERNEL);
-	if (!mq->mqrq)
-		goto blk_cleanup;
+	mq->mqrq = card->mqrq;
+	mq->qdepth = card->qdepth;
 	mq->mqrq_cur = &mq->mqrq[0];
 	mq->mqrq_prev = &mq->mqrq[1];
 	mq->queue->queuedata = mq;
@@ -293,44 +369,17 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 	if (mmc_can_erase(card))
 		mmc_queue_setup_discard(mq->queue, card);
 
-#ifdef CONFIG_MMC_BLOCK_BOUNCE
-	if (host->max_segs == 1) {
-		unsigned int bouncesz;
-
-		bouncesz = MMC_QUEUE_BOUNCESZ;
-
-		if (bouncesz > host->max_req_size)
-			bouncesz = host->max_req_size;
-		if (bouncesz > host->max_seg_size)
-			bouncesz = host->max_seg_size;
-		if (bouncesz > (host->max_blk_count * 512))
-			bouncesz = host->max_blk_count * 512;
-
-		if (bouncesz > 512 &&
-		    mmc_queue_alloc_bounce_bufs(mq, bouncesz)) {
-			blk_queue_bounce_limit(mq->queue, BLK_BOUNCE_ANY);
-			blk_queue_max_hw_sectors(mq->queue, bouncesz / 512);
-			blk_queue_max_segments(mq->queue, bouncesz / 512);
-			blk_queue_max_segment_size(mq->queue, bouncesz);
-
-			ret = mmc_queue_alloc_bounce_sgs(mq, bouncesz);
-			if (ret)
-				goto cleanup_queue;
-			bounce = true;
-		}
-	}
-#endif
-
-	if (!bounce) {
+	if (card->bouncesz) {
+		blk_queue_bounce_limit(mq->queue, BLK_BOUNCE_ANY);
+		blk_queue_max_hw_sectors(mq->queue, card->bouncesz / 512);
+		blk_queue_max_segments(mq->queue, card->bouncesz / 512);
+		blk_queue_max_segment_size(mq->queue, card->bouncesz);
+	} else {
 		blk_queue_bounce_limit(mq->queue, limit);
 		blk_queue_max_hw_sectors(mq->queue,
 			min(host->max_blk_count, host->max_req_size / 512));
 		blk_queue_max_segments(mq->queue, host->max_segs);
 		blk_queue_max_segment_size(mq->queue, host->max_seg_size);
-
-		ret = mmc_queue_alloc_sgs(mq, host->max_segs);
-		if (ret)
-			goto cleanup_queue;
 	}
 
 	sema_init(&mq->thread_sem, 1);
@@ -345,11 +394,8 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 
 	return 0;
 
- cleanup_queue:
-	mmc_queue_reqs_free_bufs(mq);
-	kfree(mq->mqrq);
+cleanup_queue:
 	mq->mqrq = NULL;
-blk_cleanup:
 	blk_cleanup_queue(mq->queue);
 	return ret;
 }
@@ -371,10 +417,7 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
 	blk_start_queue(q);
 	spin_unlock_irqrestore(q->queue_lock, flags);
 
-	mmc_queue_reqs_free_bufs(mq);
-	kfree(mq->mqrq);
 	mq->mqrq = NULL;
-
 	mq->card = NULL;
 }
 EXPORT_SYMBOL(mmc_cleanup_queue);
diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index e298f100101b..298ead2b4245 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -51,6 +51,8 @@ struct mmc_queue {
 	int			qdepth;
 };
 
+extern int mmc_queue_alloc_shared_queue(struct mmc_card *card);
+extern void mmc_queue_free_shared_queue(struct mmc_card *card);
 extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, spinlock_t *,
 			  const char *);
 extern void mmc_cleanup_queue(struct mmc_queue *);
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 77e61e0a216a..119ef8f0155c 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -208,6 +208,7 @@ struct sdio_cis {
 struct mmc_host;
 struct sdio_func;
 struct sdio_func_tuple;
+struct mmc_queue_req;
 
 #define SDIO_MAX_FUNCS		7
 
@@ -300,6 +301,10 @@ struct mmc_card {
 	struct dentry		*debugfs_root;
 	struct mmc_part	part[MMC_NUM_PHY_PARTITION]; /* physical partitions */
 	unsigned int    nr_parts;
+
+	struct mmc_queue_req	*mqrq;		/* Shared queue structure */
+	unsigned int		bouncesz;	/* Bounce buffer size */
+	int			qdepth;		/* Shared queue depth */
 };
 
 static inline bool mmc_large_sector(struct mmc_card *card)
-- 
1.9.1

