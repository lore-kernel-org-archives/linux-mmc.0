From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH RFC 05/10] mmc: core: add flush request support to command queue
Date: Wed, 15 Jun 2016 18:31:09 +0530
Message-ID: <1465995674-15816-6-git-send-email-riteshh@codeaurora.org>
References: <1465995674-15816-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:43707 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932842AbcFONCo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jun 2016 09:02:44 -0400
In-Reply-To: <1465995674-15816-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: adrian.hunter@intel.com, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, jh80.chung@samsung.com, dongas86@gmail.com, asutoshd@codeaurora.org, zhangfei.gao@gmail.com, sthumma@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, Subhash Jadavani <subhashj@codeaurora.org>

From: Asutosh Das <asutoshd@codeaurora.org>

Adds flush request support to command-queue. This uses DCMD
feature of the controller for sending commands in
command-queue mode. DCMD is a direct command feature that uses
a pre-configured slot for sending commands other than Class 11.

Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
[subhashj@codeaurora.org: fixed trivial merge conflicts]
Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
---
 drivers/mmc/card/block.c   | 81 +++++++++++++++++++++++++++++++++++++++++++---
 drivers/mmc/card/queue.c   |  3 +-
 drivers/mmc/core/core.c    |  8 +++++
 drivers/mmc/core/mmc_ops.c | 47 +++++++++++++++++++++++----
 include/linux/mmc/core.h   |  4 +++
 include/linux/mmc/host.h   |  1 +
 6 files changed, 133 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 4dc9968..48d7ee6 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1981,6 +1981,26 @@ static int mmc_blk_cmdq_start_req(struct mmc_host *host,
 	return mmc_cmdq_start_req(host, cmdq_req);
 }
 
+/* prepare for non-data commands */
+static struct mmc_cmdq_req *mmc_cmdq_prep_dcmd(
+		struct mmc_queue_req *mqrq, struct mmc_queue *mq)
+{
+	struct request *req = mqrq->req;
+	struct mmc_cmdq_req *cmdq_req = &mqrq->cmdq_req;
+
+	memset(&mqrq->cmdq_req, 0, sizeof(struct mmc_cmdq_req));
+
+	cmdq_req->mrq.data = NULL;
+	cmdq_req->cmd_flags = req->cmd_flags;
+	cmdq_req->mrq.req = mqrq->req;
+	req->special = mqrq;
+	cmdq_req->cmdq_req_flags |= DCMD;
+	cmdq_req->mrq.cmdq_req = cmdq_req;
+
+	return &mqrq->cmdq_req;
+}
+
+
 #define IS_RT_CLASS_REQ(x)     \
 	(IOPRIO_PRIO_CLASS(req_get_ioprio(x)) == IOPRIO_CLASS_RT)
 
@@ -2084,6 +2104,47 @@ static int mmc_blk_cmdq_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 	return ret;
 }
 
+/*
+ * Issues a flush (dcmd) request
+ */
+int mmc_blk_cmdq_issue_flush_rq(struct mmc_queue *mq, struct request *req)
+{
+	int err;
+	struct mmc_queue_req *active_mqrq;
+	struct mmc_card *card = mq->card;
+	struct mmc_host *host;
+	struct mmc_cmdq_req *cmdq_req;
+	struct mmc_cmdq_context_info *ctx_info;
+
+	BUG_ON(!card);
+	host = card->host;
+	BUG_ON(!host);
+	BUG_ON(req->tag > card->ext_csd.cmdq_depth);
+	BUG_ON(test_and_set_bit(req->tag, &host->cmdq_ctx.active_reqs));
+
+	ctx_info = &host->cmdq_ctx;
+
+	set_bit(CMDQ_STATE_DCMD_ACTIVE, &ctx_info->curr_state);
+
+	active_mqrq = &mq->mqrq_cmdq[req->tag];
+	active_mqrq->req = req;
+
+	cmdq_req = mmc_cmdq_prep_dcmd(active_mqrq, mq);
+	cmdq_req->cmdq_req_flags |= QBR;
+	cmdq_req->mrq.cmd = &cmdq_req->cmd;
+	cmdq_req->tag = req->tag;
+
+	err = mmc_cmdq_prepare_flush(cmdq_req->mrq.cmd);
+	if (err) {
+		pr_err("%s: failed (%d) preparing flush req\n",
+		       mmc_hostname(host), err);
+		return err;
+	}
+	err = mmc_blk_cmdq_start_req(card->host, cmdq_req);
+	return err;
+}
+EXPORT_SYMBOL(mmc_blk_cmdq_issue_flush_rq);
+
 /* invoked by block layer in softirq context */
 void mmc_blk_cmdq_complete_rq(struct request *rq)
 {
@@ -2110,12 +2171,17 @@ void mmc_blk_cmdq_complete_rq(struct request *rq)
 
 	BUG_ON(!test_and_clear_bit(cmdq_req->tag,
 				   &ctx_info->active_reqs));
+	if (cmdq_req->cmdq_req_flags & DCMD) {
+		clear_bit(CMDQ_STATE_DCMD_ACTIVE, &ctx_info->curr_state);
+		blk_end_request_all(rq, 0);
+		goto out;
+	}
 
 	blk_end_request(rq, err, cmdq_req->data.bytes_xfered);
 
+out:
 	if (test_and_clear_bit(0, &ctx_info->req_starved))
 		blk_run_queue(mq->queue);
-
 	mmc_release_host(host);
 	return;
 }
@@ -2329,18 +2395,25 @@ static int mmc_blk_cmdq_issue_rq(struct mmc_queue *mq, struct request *req)
 	int ret;
 	struct mmc_blk_data *md = mq->data;
 	struct mmc_card *card = md->queue.card;
+	unsigned int cmd_flags = req ? req->cmd_flags : 0;
 
 	mmc_claim_host(card->host);
 	ret = mmc_blk_part_switch(card, md);
 	if (ret) {
 		pr_err("%s: %s: partition switch failed %d\n",
 				md->disk->disk_name, __func__, ret);
-		blk_end_request_all(req, ret);
+		if (req)
+			blk_end_request_all(req, ret);
 		mmc_release_host(card->host);
 		goto switch_failure;
 	}
 
-	ret = mmc_blk_cmdq_issue_rw_rq(mq, req);
+	if (req) {
+		if (cmd_flags & REQ_FLUSH)
+			ret = mmc_blk_cmdq_issue_flush_rq(mq, req);
+		else
+			ret = mmc_blk_cmdq_issue_rw_rq(mq, req);
+	}
 
 switch_failure:
 	return ret;
@@ -2500,7 +2573,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	if (mmc_card_mmc(card) &&
 	    md->flags & MMC_BLK_CMD23 &&
 	    ((card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN) ||
-	     card->ext_csd.rel_sectors) && !card->cmdq_init) {
+	     card->ext_csd.rel_sectors)) {
 		md->flags |= MMC_BLK_REL_WR;
 		blk_queue_flush(md->queue.queue, REQ_FLUSH | REQ_FUA);
 	}
diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 883f810..32f9726 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -49,7 +49,8 @@ static int mmc_prep_request(struct request_queue *q, struct request *req)
 static inline bool mmc_cmdq_should_pull_reqs(struct mmc_host *host,
 					struct mmc_cmdq_context_info *ctx)
 {
-	if (test_bit(CMDQ_STATE_ERR, &ctx->curr_state)) {
+	if (test_bit(CMDQ_STATE_DCMD_ACTIVE, &ctx->curr_state) ||
+		test_bit(CMDQ_STATE_ERR, &ctx->curr_state)) {
 		pr_debug("%s: %s: skip pulling reqs: state: %lu\n",
 			 mmc_hostname(host), __func__, ctx->curr_state);
 		return false;
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 2269363..ce5e303 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -610,6 +610,14 @@ int mmc_cmdq_start_req(struct mmc_host *host, struct mmc_cmdq_req *cmdq_req)
 }
 EXPORT_SYMBOL(mmc_cmdq_start_req);
 
+int mmc_cmdq_prepare_flush(struct mmc_command *cmd)
+{
+	return   __mmc_switch_cmdq_mode(cmd, EXT_CSD_CMD_SET_NORMAL,
+				     EXT_CSD_FLUSH_CACHE, 1,
+				     0, true, true);
+}
+EXPORT_SYMBOL(mmc_cmdq_prepare_flush);
+
 /**
  *	mmc_start_req - start a non-blocking request
  *	@host: MMC host to start command
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 62355bd..c15df0b 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -456,6 +456,45 @@ int mmc_switch_status_error(struct mmc_host *host, u32 status)
 }
 
 /**
+ *	mmc_prepare_switch - helper; prepare to modify EXT_CSD register
+ *	@card: the MMC card associated with the data transfer
+ *	@set: cmd set values
+ *	@index: EXT_CSD register index
+ *	@value: value to program into EXT_CSD register
+ *	@tout_ms: timeout (ms) for operation performed by register write,
+ *                   timeout of zero implies maximum possible timeout
+ *	@use_busy_signal: use the busy signal as response type
+ *
+ *	Helper to prepare to modify EXT_CSD register for selected card.
+ */
+
+static inline void mmc_prepare_switch(struct mmc_command *cmd, u8 index,
+				      u8 value, u8 set, unsigned int tout_ms,
+				      bool use_busy_signal)
+{
+	cmd->opcode = MMC_SWITCH;
+	cmd->arg = (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
+		  (index << 16) |
+		  (value << 8) |
+		  set;
+	cmd->flags = MMC_CMD_AC;
+	cmd->busy_timeout = tout_ms;
+	if (use_busy_signal)
+		cmd->flags |= MMC_RSP_SPI_R1B | MMC_RSP_R1B;
+	else
+		cmd->flags |= MMC_RSP_SPI_R1 | MMC_RSP_R1;
+}
+
+int __mmc_switch_cmdq_mode(struct mmc_command *cmd, u8 set, u8 index, u8 value,
+			   unsigned int timeout_ms, bool use_busy_signal,
+			   bool ignore_timeout)
+{
+	mmc_prepare_switch(cmd, index, value, set, timeout_ms, use_busy_signal);
+	return 0;
+}
+EXPORT_SYMBOL(__mmc_switch_cmdq_mode);
+
+/**
  *	__mmc_switch - modify EXT_CSD register
  *	@card: the MMC card associated with the data transfer
  *	@set: cmd set values
@@ -493,12 +532,8 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		(timeout_ms > host->max_busy_timeout))
 		use_r1b_resp = false;
 
-	cmd.opcode = MMC_SWITCH;
-	cmd.arg = (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
-		  (index << 16) |
-		  (value << 8) |
-		  set;
-	cmd.flags = MMC_CMD_AC;
+	mmc_prepare_switch(&cmd, index, value, set, timeout_ms,
+			   use_r1b_resp);
 	if (use_r1b_resp) {
 		cmd.flags |= MMC_RSP_SPI_R1B | MMC_RSP_R1B;
 		/*
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index a93e6f8..7b3a60c 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -147,6 +147,7 @@ extern void mmc_cmdq_post_req(struct mmc_host *host, struct mmc_request *mrq,
 			      int err);
 extern int mmc_cmdq_start_req(struct mmc_host *host,
 			      struct mmc_cmdq_req *cmdq_req);
+extern int mmc_cmdq_prepare_flush(struct mmc_command *cmd);
 
 extern int mmc_stop_bkops(struct mmc_card *);
 extern int mmc_read_bkops_status(struct mmc_card *);
@@ -160,6 +161,9 @@ extern int mmc_wait_for_app_cmd(struct mmc_host *, struct mmc_card *,
 	struct mmc_command *, int);
 extern void mmc_start_bkops(struct mmc_card *card, bool from_exception);
 extern int mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int);
+extern int __mmc_switch_cmdq_mode(struct mmc_command *cmd, u8 set, u8 index,
+				  u8 value, unsigned int timeout_ms,
+				  bool use_busy_signal, bool ignore_timeout);
 extern int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error);
 extern int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index e4e74c0..dfe094a 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -215,6 +215,7 @@ struct mmc_cmdq_context_info {
 	unsigned long	active_reqs; /* in-flight requests */
 	unsigned long	curr_state;
 #define	CMDQ_STATE_ERR 0
+#define	CMDQ_STATE_DCMD_ACTIVE 1
 	/* no free tag available */
 	unsigned long	req_starved;
 };
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.

