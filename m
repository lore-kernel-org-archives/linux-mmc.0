From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH RFC 04/10] mmc: card: add read/write support in command queue mode
Date: Wed, 15 Jun 2016 18:31:08 +0530
Message-ID: <1465995674-15816-5-git-send-email-riteshh@codeaurora.org>
References: <1465995674-15816-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:43690 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932842AbcFONCi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jun 2016 09:02:38 -0400
In-Reply-To: <1465995674-15816-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: adrian.hunter@intel.com, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, jh80.chung@samsung.com, dongas86@gmail.com, asutoshd@codeaurora.org, zhangfei.gao@gmail.com, sthumma@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, Subhash Jadavani <subhashj@codeaurora.org>, Ritesh Harjani <riteshh@codeaurora.org>

From: Venkat Gopalakrishnan <venkatg@codeaurora.org>

Command queueing is defined in eMMC-5.1. It is designed for
higher performance by ensuring upto 32 requests to be serviced
at a time.

Adds read/write support for CMDQ enabled devices.

Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
Signed-off-by: Konstantin Dorfman <kdorfman@codeaurora.org>
Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
[subhashj@codeaurora.org: fixed trivial merge conflicts]
Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 drivers/mmc/card/block.c | 243 ++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/mmc/card/queue.c |   2 +
 drivers/mmc/card/queue.h |   1 +
 drivers/mmc/core/core.c  |  57 +++++++++++
 include/linux/mmc/card.h |   3 +-
 include/linux/mmc/core.h |   8 ++
 include/linux/mmc/host.h |  22 +++++
 7 files changed, 333 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 1b69424..4dc9968 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -35,6 +35,7 @@
 #include <linux/capability.h>
 #include <linux/compat.h>
 #include <linux/pm_runtime.h>
+#include <linux/ioprio.h>
 
 #include <linux/mmc/ioctl.h>
 #include <linux/mmc/card.h>
@@ -100,6 +101,7 @@ struct mmc_blk_data {
 #define MMC_BLK_CMD23	(1 << 0)	/* Can do SET_BLOCK_COUNT for multiblock */
 #define MMC_BLK_REL_WR	(1 << 1)	/* MMC Reliable write support */
 #define MMC_BLK_PACKED_CMD	(1 << 2)	/* MMC packed command support */
+#define MMC_BLK_CMD_QUEUE	(1 << 3) /* MMC command queue support */
 
 	unsigned int	usage;
 	unsigned int	read_only;
@@ -135,6 +137,8 @@ MODULE_PARM_DESC(perdev_minors, "Minors numbers to allocate per device");
 static inline int mmc_blk_part_switch(struct mmc_card *card,
 				      struct mmc_blk_data *md);
 static int get_card_status(struct mmc_card *card, u32 *status, int retries);
+static int mmc_blk_cmdq_switch(struct mmc_card *card,
+			       struct mmc_blk_data *md, bool enable);
 
 static inline void mmc_blk_clear_packed(struct mmc_queue_req *mqrq)
 {
@@ -733,6 +737,44 @@ static const struct block_device_operations mmc_bdops = {
 #endif
 };
 
+static int mmc_blk_cmdq_switch(struct mmc_card *card,
+			       struct mmc_blk_data *md, bool enable)
+{
+	int ret = 0;
+	bool cmdq_mode = !!mmc_card_cmdq(card);
+
+	if (!(card->host->caps2 & MMC_CAP2_CMD_QUEUE) ||
+	    !card->ext_csd.cmdq_support ||
+	    (enable && !(md->flags & MMC_BLK_CMD_QUEUE)) ||
+	    (cmdq_mode == enable))
+		return 0;
+
+	if (enable) {
+		ret = mmc_set_blocklen(card, MMC_CARD_CMDQ_BLK_SIZE);
+		if (ret) {
+			pr_err("%s: failed (%d) to set block-size to %d\n",
+			       __func__, ret, MMC_CARD_CMDQ_BLK_SIZE);
+			goto out;
+		}
+	}
+
+	ret = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+			 EXT_CSD_CMDQ, enable,
+			 card->ext_csd.generic_cmd6_time);
+	if (ret) {
+		pr_err("%s: cmdq mode %sable failed %d\n",
+		       md->disk->disk_name, enable ? "en" : "dis", ret);
+		goto out;
+	}
+
+	if (enable)
+		mmc_card_set_cmdq(card);
+	else
+		mmc_card_clr_cmdq(card);
+out:
+	return ret;
+}
+
 static inline int mmc_blk_part_switch(struct mmc_card *card,
 				      struct mmc_blk_data *md)
 {
@@ -745,6 +787,13 @@ static inline int mmc_blk_part_switch(struct mmc_card *card,
 	if (mmc_card_mmc(card)) {
 		u8 part_config = card->ext_csd.part_config;
 
+		if (md->part_type) {
+			/* disable CQ mode for non-user data partitions */
+			ret = mmc_blk_cmdq_switch(card, md, false);
+			if (ret)
+				return ret;
+		}
+
 		part_config &= ~EXT_CSD_PART_CONFIG_ACC_MASK;
 		part_config |= md->part_type;
 
@@ -1923,6 +1972,166 @@ static void mmc_blk_revert_packed_req(struct mmc_queue *mq,
 	mmc_blk_clear_packed(mq_rq);
 }
 
+static int mmc_blk_cmdq_start_req(struct mmc_host *host,
+				  struct mmc_cmdq_req *cmdq_req)
+{
+	struct mmc_request *mrq = &cmdq_req->mrq;
+
+	mrq->done = mmc_blk_cmdq_req_done;
+	return mmc_cmdq_start_req(host, cmdq_req);
+}
+
+#define IS_RT_CLASS_REQ(x)     \
+	(IOPRIO_PRIO_CLASS(req_get_ioprio(x)) == IOPRIO_CLASS_RT)
+
+static struct mmc_cmdq_req *mmc_blk_cmdq_rw_prep(
+		struct mmc_queue_req *mqrq, struct mmc_queue *mq)
+{
+	struct mmc_card *card = mq->card;
+	struct request *req = mqrq->req;
+	struct mmc_blk_data *md = mq->data;
+	bool do_rel_wr = mmc_req_rel_wr(req) && (md->flags & MMC_BLK_REL_WR);
+	bool do_data_tag;
+	bool read_dir = (rq_data_dir(req) == READ);
+	bool prio = IS_RT_CLASS_REQ(req);
+	struct mmc_cmdq_req *cmdq_rq = &mqrq->cmdq_req;
+
+	memset(&mqrq->cmdq_req, 0, sizeof(struct mmc_cmdq_req));
+
+	cmdq_rq->tag = req->tag;
+	if (read_dir) {
+		cmdq_rq->cmdq_req_flags |= DIR;
+		cmdq_rq->data.flags = MMC_DATA_READ;
+	} else {
+		cmdq_rq->data.flags = MMC_DATA_WRITE;
+	}
+	if (prio)
+		cmdq_rq->cmdq_req_flags |= PRIO;
+
+	if (do_rel_wr)
+		cmdq_rq->cmdq_req_flags |= REL_WR;
+
+	cmdq_rq->data.blocks = blk_rq_sectors(req);
+	cmdq_rq->blk_addr = blk_rq_pos(req);
+	cmdq_rq->data.blksz = MMC_CARD_CMDQ_BLK_SIZE;
+
+	mmc_set_data_timeout(&cmdq_rq->data, card);
+
+	do_data_tag = (card->ext_csd.data_tag_unit_size) &&
+		(req->cmd_flags & REQ_META) &&
+		(rq_data_dir(req) == WRITE) &&
+		((cmdq_rq->data.blocks * cmdq_rq->data.blksz) >=
+		 card->ext_csd.data_tag_unit_size);
+	if (do_data_tag)
+		cmdq_rq->cmdq_req_flags |= DAT_TAG;
+	cmdq_rq->data.sg = mqrq->sg;
+	cmdq_rq->data.sg_len = mmc_queue_map_sg(mq, mqrq);
+
+	/*
+	 * Adjust the sg list so it is the same size as the
+	 * request.
+	 */
+	if (cmdq_rq->data.blocks > card->host->max_blk_count)
+		cmdq_rq->data.blocks = card->host->max_blk_count;
+
+	if (cmdq_rq->data.blocks != blk_rq_sectors(req)) {
+		int i, data_size = cmdq_rq->data.blocks << 9;
+		struct scatterlist *sg;
+
+		for_each_sg(cmdq_rq->data.sg, sg, cmdq_rq->data.sg_len, i) {
+			data_size -= sg->length;
+			if (data_size <= 0) {
+				sg->length += data_size;
+				i++;
+				break;
+			}
+		}
+		cmdq_rq->data.sg_len = i;
+	}
+
+	mqrq->cmdq_req.cmd_flags = req->cmd_flags;
+	mqrq->cmdq_req.mrq.req = mqrq->req;
+	mqrq->cmdq_req.mrq.cmdq_req = &mqrq->cmdq_req;
+	mqrq->cmdq_req.mrq.data = &mqrq->cmdq_req.data;
+	mqrq->req->special = mqrq;
+
+	pr_debug("%s: %s: mrq: 0x%p req: 0x%p mqrq: 0x%p bytes to xf: %d mmc_cmdq_req: 0x%p card-addr: 0x%08x dir(r-1/w-0): %d\n",
+		 mmc_hostname(card->host), __func__, &mqrq->cmdq_req.mrq,
+		 mqrq->req, mqrq, (cmdq_rq->data.blocks * cmdq_rq->data.blksz),
+		 cmdq_rq, cmdq_rq->blk_addr,
+		 (cmdq_rq->cmdq_req_flags & DIR) ? 1 : 0);
+
+	return &mqrq->cmdq_req;
+}
+
+static int mmc_blk_cmdq_issue_rw_rq(struct mmc_queue *mq, struct request *req)
+{
+	struct mmc_queue_req *active_mqrq;
+	struct mmc_card *card = mq->card;
+	struct mmc_host *host = card->host;
+	struct mmc_cmdq_req *mc_rq;
+	int ret = 0;
+
+	BUG_ON((req->tag < 0) || (req->tag > card->ext_csd.cmdq_depth));
+	BUG_ON(test_and_set_bit(req->tag, &host->cmdq_ctx.active_reqs));
+
+	active_mqrq = &mq->mqrq_cmdq[req->tag];
+	active_mqrq->req = req;
+
+	mc_rq = mmc_blk_cmdq_rw_prep(active_mqrq, mq);
+
+	ret = mmc_blk_cmdq_start_req(card->host, mc_rq);
+	return ret;
+}
+
+/* invoked by block layer in softirq context */
+void mmc_blk_cmdq_complete_rq(struct request *rq)
+{
+	struct mmc_queue_req *mq_rq = rq->special;
+	struct mmc_request *mrq = &mq_rq->cmdq_req.mrq;
+	struct mmc_host *host = mrq->host;
+	struct mmc_cmdq_context_info *ctx_info = &host->cmdq_ctx;
+	struct mmc_cmdq_req *cmdq_req = &mq_rq->cmdq_req;
+	struct mmc_queue *mq = (struct mmc_queue *)rq->q->queuedata;
+	int err = 0;
+
+	if (mrq->cmd && mrq->cmd->error)
+		err = mrq->cmd->error;
+	else if (mrq->data && mrq->data->error)
+		err = mrq->data->error;
+
+	mmc_cmdq_post_req(host, mrq, err);
+	if (err) {
+		pr_err("%s: %s: txfr error: %d\n", mmc_hostname(mrq->host),
+		       __func__, err);
+		set_bit(CMDQ_STATE_ERR, &ctx_info->curr_state);
+		WARN_ON(1);
+	}
+
+	BUG_ON(!test_and_clear_bit(cmdq_req->tag,
+				   &ctx_info->active_reqs));
+
+	blk_end_request(rq, err, cmdq_req->data.bytes_xfered);
+
+	if (test_and_clear_bit(0, &ctx_info->req_starved))
+		blk_run_queue(mq->queue);
+
+	mmc_release_host(host);
+	return;
+}
+
+/*
+ * Complete reqs from block layer softirq context
+ * Invoked in irq context
+ */
+void mmc_blk_cmdq_req_done(struct mmc_request *mrq)
+{
+	struct request *req = mrq->req;
+
+	blk_complete_request(req);
+}
+EXPORT_SYMBOL(mmc_blk_cmdq_req_done);
+
 static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 {
 	struct mmc_blk_data *md = mq->data;
@@ -2115,6 +2324,28 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 	return 0;
 }
 
+static int mmc_blk_cmdq_issue_rq(struct mmc_queue *mq, struct request *req)
+{
+	int ret;
+	struct mmc_blk_data *md = mq->data;
+	struct mmc_card *card = md->queue.card;
+
+	mmc_claim_host(card->host);
+	ret = mmc_blk_part_switch(card, md);
+	if (ret) {
+		pr_err("%s: %s: partition switch failed %d\n",
+				md->disk->disk_name, __func__, ret);
+		blk_end_request_all(req, ret);
+		mmc_release_host(card->host);
+		goto switch_failure;
+	}
+
+	ret = mmc_blk_cmdq_issue_rw_rq(mq, req);
+
+switch_failure:
+	return ret;
+}
+
 static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 {
 	int ret;
@@ -2269,12 +2500,18 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	if (mmc_card_mmc(card) &&
 	    md->flags & MMC_BLK_CMD23 &&
 	    ((card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN) ||
-	     card->ext_csd.rel_sectors)) {
+	     card->ext_csd.rel_sectors) && !card->cmdq_init) {
 		md->flags |= MMC_BLK_REL_WR;
 		blk_queue_flush(md->queue.queue, REQ_FLUSH | REQ_FUA);
 	}
 
-	if (mmc_card_mmc(card) &&
+	if (card->cmdq_init) {
+		md->flags |= MMC_BLK_CMD_QUEUE;
+		md->queue.cmdq_complete_fn = mmc_blk_cmdq_complete_rq;
+		md->queue.cmdq_issue_fn = mmc_blk_cmdq_issue_rq;
+	}
+
+	if (mmc_card_mmc(card) && !card->cmdq_init &&
 	    (area_type == MMC_BLK_DATA_AREA_MAIN) &&
 	    (md->flags & MMC_BLK_CMD23) &&
 	    card->ext_csd.packed_event_en) {
@@ -2384,6 +2621,8 @@ static void mmc_blk_remove_req(struct mmc_blk_data *md)
 		mmc_cleanup_queue(&md->queue);
 		if (md->flags & MMC_BLK_PACKED_CMD)
 			mmc_packed_clean(&md->queue);
+		if (md->flags & MMC_BLK_CMD_QUEUE)
+			mmc_cmdq_clean(&md->queue, card);
 		if (md->disk->flags & GENHD_FL_UP) {
 			device_remove_file(disk_to_dev(md->disk), &md->force_ro);
 			if ((md->area_type & MMC_BLK_DATA_AREA_BOOT) &&
diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index d4deab5..883f810 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -530,6 +530,7 @@ int mmc_cmdq_init(struct mmc_queue *mq, struct mmc_card *card)
 	/* one slot is reserved for dcmd requests */
 	int q_depth = card->ext_csd.cmdq_depth - 1;
 
+	card->cmdq_init = false;
 	if (!(card->host->caps2 & MMC_CAP2_CMD_QUEUE)) {
 		ret = -ENOTSUPP;
 		goto out;
@@ -563,6 +564,7 @@ int mmc_cmdq_init(struct mmc_queue *mq, struct mmc_card *card)
 	}
 
 	blk_queue_softirq_done(mq->queue, mmc_cmdq_softirq_done);
+	card->cmdq_init = true;
 	goto out;
 
 free_mqrq_sg:
diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
index 4c7e39d2..2f9f43d 100644
--- a/drivers/mmc/card/queue.h
+++ b/drivers/mmc/card/queue.h
@@ -42,6 +42,7 @@ struct mmc_queue_req {
 	struct mmc_async_req	mmc_active;
 	enum mmc_packed_type	cmd_type;
 	struct mmc_packed	*packed;
+	struct mmc_cmdq_req	cmdq_req;
 };
 
 struct mmc_queue {
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 41b1e76..2269363 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -290,6 +290,36 @@ static int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 	return 0;
 }
 
+static void mmc_start_cmdq_request(struct mmc_host *host,
+				   struct mmc_request *mrq)
+{
+	if (mrq->data) {
+		pr_debug("%s:     blksz %d blocks %d flags %08x tsac %lu ms nsac %d\n",
+			mmc_hostname(host), mrq->data->blksz,
+			mrq->data->blocks, mrq->data->flags,
+			mrq->data->timeout_ns / NSEC_PER_MSEC,
+			mrq->data->timeout_clks);
+
+		BUG_ON(mrq->data->blksz > host->max_blk_size);
+		BUG_ON(mrq->data->blocks > host->max_blk_count);
+		BUG_ON(mrq->data->blocks * mrq->data->blksz >
+			host->max_req_size);
+		mrq->data->error = 0;
+		mrq->data->mrq = mrq;
+	}
+
+	if (mrq->cmd) {
+		mrq->cmd->error = 0;
+		mrq->cmd->mrq = mrq;
+	}
+
+	if (likely(host->cmdq_ops->request))
+		host->cmdq_ops->request(host, mrq);
+	else
+		pr_err("%s: %s: issue request failed\n", mmc_hostname(host),
+				__func__);
+}
+
 /**
  *	mmc_start_bkops - start BKOPS for supported cards
  *	@card: MMC card to start BKOPS
@@ -554,6 +584,33 @@ static void mmc_post_req(struct mmc_host *host, struct mmc_request *mrq,
 }
 
 /**
+ *	mmc_cmdq_post_req - post process of a completed request
+ *	@host: host instance
+ *	@mrq: the request to be processed
+ *	@err: non-zero is error, success otherwise
+ */
+void mmc_cmdq_post_req(struct mmc_host *host, struct mmc_request *mrq, int err)
+{
+	if (likely(host->cmdq_ops->post_req))
+		host->cmdq_ops->post_req(host, mrq, err);
+}
+EXPORT_SYMBOL(mmc_cmdq_post_req);
+
+int mmc_cmdq_start_req(struct mmc_host *host, struct mmc_cmdq_req *cmdq_req)
+{
+	struct mmc_request *mrq = &cmdq_req->mrq;
+
+	mrq->host = host;
+	if (mmc_card_removed(host->card)) {
+		mrq->cmd->error = -ENOMEDIUM;
+		return -ENOMEDIUM;
+	}
+	mmc_start_cmdq_request(host, mrq);
+	return 0;
+}
+EXPORT_SYMBOL(mmc_cmdq_start_req);
+
+/**
  *	mmc_start_req - start a non-blocking request
  *	@host: MMC host to start command
  *	@areq: async request to start
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 85a0d8d..8bf1742 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -318,6 +318,7 @@ struct mmc_card {
 	struct dentry		*debugfs_root;
 	struct mmc_part	part[MMC_NUM_PHY_PARTITION]; /* physical partitions */
 	unsigned int    nr_parts;
+	bool cmdq_init;
 };
 
 /*
@@ -539,5 +540,5 @@ extern void mmc_unregister_driver(struct mmc_driver *);
 
 extern void mmc_fixup_device(struct mmc_card *card,
 			     const struct mmc_fixup *table);
-
+extern void mmc_blk_cmdq_req_done(struct mmc_request *mrq);
 #endif /* LINUX_MMC_CARD_H */
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index b01e77d..a93e6f8 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -135,10 +135,18 @@ struct mmc_request {
 	struct completion	completion;
 	void			(*done)(struct mmc_request *);/* completion function */
 	struct mmc_host		*host;
+	struct mmc_cmdq_req	*cmdq_req;
+	struct request		*req;		/* associated block request */
 };
 
 struct mmc_card;
 struct mmc_async_req;
+struct mmc_cmdq_req;
+
+extern void mmc_cmdq_post_req(struct mmc_host *host, struct mmc_request *mrq,
+			      int err);
+extern int mmc_cmdq_start_req(struct mmc_host *host,
+			      struct mmc_cmdq_req *cmdq_req);
 
 extern int mmc_stop_bkops(struct mmc_card *);
 extern int mmc_read_bkops_status(struct mmc_card *);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 96654d5..e4e74c0 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -82,6 +82,9 @@ struct mmc_ios {
 struct mmc_cmdq_host_ops {
 	int (*enable)(struct mmc_host *host);
 	void (*disable)(struct mmc_host *host, bool soft);
+	int (*request)(struct mmc_host *host, struct mmc_request *mrq);
+	void (*post_req)(struct mmc_host *host, struct mmc_request *mrq,
+			 int err);
 };
 
 struct mmc_host_ops {
@@ -154,6 +157,25 @@ struct mmc_host_ops {
 struct mmc_card;
 struct device;
 
+struct mmc_cmdq_req {
+	unsigned int cmd_flags;
+	u32 blk_addr;
+	/* active mmc request */
+	struct mmc_request	mrq;
+	struct mmc_data		data;
+	struct mmc_command	cmd;
+#define DCMD		(1 << 0)
+#define QBR		(1 << 1)
+#define DIR		(1 << 2)
+#define PRIO		(1 << 3)
+#define REL_WR		(1 << 4)
+#define DAT_TAG	(1 << 5)
+#define FORCED_PRG	(1 << 6)
+	unsigned int		cmdq_req_flags;
+	int			tag; /* used for command queuing */
+	u8			ctx_id;
+};
+
 struct mmc_async_req {
 	/* active mmc request */
 	struct mmc_request	*mrq;
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.

