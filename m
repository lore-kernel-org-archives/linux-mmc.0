From: Asutosh Das <asutoshd@codeaurora.org>
Subject: [PATCH 2/5] mmc: queue: initialization of command-queue support
Date: Tue, 2 Dec 2014 17:27:28 +0530
Message-ID: <20141202115728.GA27647@asutoshd-ics.in.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:1153 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932946AbaLBL5c (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Dec 2014 06:57:32 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org

Add command queue initialization support. This is
applicable for emmc devices supporting cmd-queueing.

Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
Signed-off-by: Konstantin Dorfman <kdorfman@codeaurora.org>
---
 drivers/mmc/card/queue.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/card/queue.h |  6 ++++
 include/linux/mmc/card.h |  2 ++
 include/linux/mmc/host.h |  1 +
 4 files changed, 83 insertions(+)

diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 3e049c1..c99e385 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -403,6 +403,80 @@ void mmc_packed_clean(struct mmc_queue *mq)
 	mqrq_prev->packed = NULL;
 }
 
+static void mmc_cmdq_softirq_done(struct request *rq)
+{
+	struct mmc_queue *mq = rq->q->queuedata;
+
+	mq->cmdq_complete_fn(rq);
+}
+
+int mmc_cmdq_init(struct mmc_queue *mq, struct mmc_card *card)
+{
+	int i, ret = 0;
+	/* one slot is reserved for dcmd requests */
+	int q_depth = card->ext_csd.cmdq_depth - 1;
+
+	card->cmdq_init = false;
+	if (!(card->host->caps2 & MMC_CAP2_CMD_QUEUE)) {
+		ret = -ENOTSUPP;
+		goto out;
+	}
+
+	mq->mqrq_cmdq = kzalloc(
+			sizeof(struct mmc_queue_req) * q_depth, GFP_KERNEL);
+	if (!mq->mqrq_cmdq) {
+		pr_warn("%s: unable to allocate mqrq's for q_depth %d\n",
+			mmc_card_name(card), q_depth);
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	for (i = 0; i < q_depth; i++) {
+		/* TODO: reduce the sg allocation by delaying them */
+		mq->mqrq_cmdq[i].sg = mmc_alloc_sg(card->host->max_segs, &ret);
+		if (ret) {
+			pr_warn("%s: unable to allocate cmdq sg of size %d\n",
+				mmc_card_name(card),
+				card->host->max_segs);
+			goto free_mqrq_sg;
+		}
+	}
+
+	ret = blk_queue_init_tags(mq->queue, q_depth, NULL);
+	if (ret) {
+		pr_warn("%s: unable to allocate cmdq tags %d\n",
+				mmc_card_name(card), q_depth);
+		goto free_mqrq_sg;
+	}
+
+	blk_queue_softirq_done(mq->queue, mmc_cmdq_softirq_done);
+	card->cmdq_init = true;
+	goto out;
+
+free_mqrq_sg:
+	for (i = 0; i < q_depth; i++)
+		kfree(mq->mqrq_cmdq[i].sg);
+	kfree(mq->mqrq_cmdq);
+	mq->mqrq_cmdq = NULL;
+out:
+	return ret;
+}
+
+void mmc_cmdq_clean(struct mmc_queue *mq, struct mmc_card *card)
+{
+	int i;
+	int q_depth = card->ext_csd.cmdq_depth - 1;
+
+	blk_free_tags(mq->queue->queue_tags);
+	mq->queue->queue_tags = NULL;
+	blk_queue_free_tags(mq->queue);
+
+	for (i = 0; i < q_depth; i++)
+		kfree(mq->mqrq_cmdq[i].sg);
+	kfree(mq->mqrq_cmdq);
+	mq->mqrq_cmdq = NULL;
+}
+
 /**
  * mmc_queue_suspend - suspend a MMC request queue
  * @mq: MMC queue to suspend
diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
index 5752d50..36a8d64 100644
--- a/drivers/mmc/card/queue.h
+++ b/drivers/mmc/card/queue.h
@@ -52,11 +52,14 @@ struct mmc_queue {
 #define MMC_QUEUE_NEW_REQUEST	(1 << 1)
 
 	int			(*issue_fn)(struct mmc_queue *, struct request *);
+	int (*cmdq_issue_fn)(struct mmc_queue *, struct request *);
+	void (*cmdq_complete_fn)(struct request *);
 	void			*data;
 	struct request_queue	*queue;
 	struct mmc_queue_req	mqrq[2];
 	struct mmc_queue_req	*mqrq_cur;
 	struct mmc_queue_req	*mqrq_prev;
+	struct mmc_queue_req	*mqrq_cmdq;
 };
 
 extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, spinlock_t *,
@@ -73,4 +76,7 @@ extern void mmc_queue_bounce_post(struct mmc_queue_req *);
 extern int mmc_packed_init(struct mmc_queue *, struct mmc_card *);
 extern void mmc_packed_clean(struct mmc_queue *);
 
+extern int mmc_cmdq_init(struct mmc_queue *mq, struct mmc_card *card);
+extern void mmc_cmdq_clean(struct mmc_queue *mq, struct mmc_card *card);
+
 #endif
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index b87a27c..41f368d 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -309,6 +309,7 @@ struct mmc_card {
 	struct dentry		*debugfs_root;
 	struct mmc_part	part[MMC_NUM_PHY_PARTITION]; /* physical partitions */
 	unsigned int    nr_parts;
+	bool			cmdq_init; /* cmdq init done */
 };
 
 /*
@@ -545,4 +546,5 @@ extern void mmc_unregister_driver(struct mmc_driver *);
 extern void mmc_fixup_device(struct mmc_card *card,
 			     const struct mmc_fixup *table);
 
+extern void mmc_blk_cmdq_req_done(struct mmc_request *mrq);
 #endif /* LINUX_MMC_CARD_H */
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index cb61ea4..f0edb36 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -278,6 +278,7 @@ struct mmc_host {
 #define MMC_CAP2_PACKED_CMD	(MMC_CAP2_PACKED_RD | \
 				 MMC_CAP2_PACKED_WR)
 #define MMC_CAP2_NO_PRESCAN_POWERUP (1 << 14)	/* Don't power up before scan */
+#define MMC_CAP2_CMD_QUEUE	(1 << 15)	/* support eMMC command queue */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 
-- 
1.8.2.1

The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

