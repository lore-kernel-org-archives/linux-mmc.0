From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V9 10/11] mmc: block: Add Software Command Queuing
Date: Thu,  8 Dec 2016 10:44:37 +0200
Message-ID: <1481186678-6307-11-git-send-email-adrian.hunter@intel.com>
References: <1481186678-6307-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:38669 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751742AbcLHIuZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 8 Dec 2016 03:50:25 -0500
In-Reply-To: <1481186678-6307-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

eMMC Command Queuing is a feature added in version 5.1.  The card maintains
a queue of up to 32 data transfers.  Commands CMD44/CMD45 are sent to queue
up transfers in advance, and then one of the transfers is selected to
"execute" by CMD46/CMD47 at which point data transfer actually begins.

The advantage of command queuing is that the card can prepare for transfers
in advance. That makes a big difference in the case of random reads because
the card can start reading into its cache in advance.

A v5.1 host controller can manage the command queue itself, but it is also
possible for software to manage the queue using an non-v5.1 host controller
- that is what Software Command Queuing is.

Refer to the JEDEC (http://www.jedec.org/) eMMC v5.1 Specification for more
information about Command Queuing.

Two important aspects of Command Queuing that affect the implementation
are:
 - only read/write requests are queued
 - the queue must be empty to send other commands, including re-tuning

To support Software Command Queuing a separate function is provided to
issue read/write requests (i.e. mmc_swcmdq_issue_rw_rq()) and the
mmc_blk_request structure amended to cater for additional commands CMD44
and CMD45. There is a separate function (mmc_swcmdq_prep()) to prepare the
needed commands, but transfers are started by mmc_start_req() like normal.

mmc_swcmdq_issue_rw_rq() enqueues the new request and then executes tasks
until the queue is empty or mmc_swcmdq_execute() asks for a new request.
This puts mmc_swcmdq_execute() in control of the decision whether to queue
more requests or wait for the active one.

Recovery is invoked if anything goes wrong. Recovery has 2 options:
 1. Discard the queue and re-queue all requests. If that fails, fall back
    to option 2.
 2. Reset and re-queue all requests. If that fails, error out all the
    requests.
In either case, re-tuning will be done if needed after the queue becomes
empty because re-tuning is released at that point.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/card/block.c | 591 ++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/mmc/card/queue.c |  10 +-
 drivers/mmc/card/queue.h |  11 +-
 include/linux/mmc/core.h |   1 +
 4 files changed, 610 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 53d8198ef257..790a62b937b9 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -108,6 +108,7 @@ struct mmc_blk_data {
 #define MMC_BLK_WRITE		BIT(1)
 #define MMC_BLK_DISCARD		BIT(2)
 #define MMC_BLK_SECDISCARD	BIT(3)
+#define MMC_BLK_SWCMDQ		BIT(4)
 
 	/*
 	 * Only set in main mmc_blk_data associated
@@ -1630,7 +1631,584 @@ static int mmc_blk_cmd_err(struct mmc_blk_data *md, struct mmc_card *card,
 	return ret;
 }
 
-static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
+static enum mmc_blk_status mmc_swcmdq_err_check(struct mmc_card *card,
+						struct mmc_async_req *areq)
+{
+	struct mmc_queue_req *mqrq = container_of(areq, struct mmc_queue_req,
+						  mmc_active);
+	struct mmc_blk_request *brq = &mqrq->brq;
+	struct request *req = mqrq->req;
+	int err;
+
+	err = brq->data.error;
+	/* In the case of data errors, send stop */
+	if (err)
+		mmc_wait_for_cmd(card->host, &brq->stop, 0);
+	else
+		err = brq->cmd.error;
+
+	/* In the case of CRC errors when re-tuning is needed, retry */
+	if (err == -EILSEQ && card->host->need_retune)
+		return MMC_BLK_RETRY;
+
+	/* For other errors abort */
+	if (err)
+		return MMC_BLK_ABORT;
+
+	if (blk_rq_bytes(req) != brq->data.bytes_xfered)
+		return MMC_BLK_PARTIAL;
+
+	return MMC_BLK_SUCCESS;
+}
+
+static void mmc_swcmdq_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq)
+{
+	struct mmc_blk_data *md = mq->blkdata;
+	struct mmc_card *card = md->queue.card;
+	struct mmc_blk_request *brq = &mqrq->brq;
+	struct request *req = mqrq->req;
+	bool do_data_tag;
+
+	/*
+	 * Reliable writes are used to implement Forced Unit Access and
+	 * are supported only on MMCs.
+	 */
+	bool do_rel_wr = (req->cmd_flags & REQ_FUA) &&
+		(rq_data_dir(req) == WRITE) &&
+		(md->flags & MMC_BLK_REL_WR);
+
+	memset(brq, 0, sizeof(struct mmc_blk_request));
+	brq->mrq.cmd = &brq->cmd;
+	brq->mrq.data = &brq->data;
+	brq->mrq.cap_cmd_during_tfr = true;
+
+	if (rq_data_dir(req) == READ) {
+		brq->cmd.opcode = MMC_EXECUTE_READ_TASK;
+		brq->data.flags = MMC_DATA_READ;
+		brq->stop.flags = MMC_RSP_R1 | MMC_CMD_AC;
+	} else {
+		brq->cmd.opcode = MMC_EXECUTE_WRITE_TASK;
+		brq->data.flags = MMC_DATA_WRITE;
+		brq->stop.flags = MMC_RSP_R1B | MMC_CMD_AC;
+	}
+	brq->cmd.arg = mqrq->task_id << 16;
+	brq->cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
+
+	brq->data.blksz = 512;
+	brq->data.blocks = blk_rq_sectors(req);
+
+	brq->stop.opcode = MMC_STOP_TRANSMISSION;
+	brq->stop.arg = 0;
+
+	/*
+	 * The block layer doesn't support all sector count
+	 * restrictions, so we need to be prepared for too big
+	 * requests.
+	 */
+	if (brq->data.blocks > card->host->max_blk_count)
+		brq->data.blocks = card->host->max_blk_count;
+
+	if (do_rel_wr)
+		mmc_apply_rel_rw(brq, card, req);
+
+	/*
+	 * Data tag is used only during writing meta data to speed
+	 * up write and any subsequent read of this meta data
+	 */
+	do_data_tag = (card->ext_csd.data_tag_unit_size) &&
+		(req->cmd_flags & REQ_META) &&
+		(rq_data_dir(req) == WRITE) &&
+		((brq->data.blocks * brq->data.blksz) >=
+		 card->ext_csd.data_tag_unit_size);
+
+	brq->cmd44.opcode = MMC_QUE_TASK_PARAMS;
+	brq->cmd44.arg = brq->data.blocks |
+			 (do_rel_wr ? (1 << 31) : 0) |
+			 ((rq_data_dir(req) == READ) ? (1 << 30) : 0) |
+			 (do_data_tag ? (1 << 29) : 0) |
+			 mqrq->task_id << 16;
+	brq->cmd44.flags = MMC_RSP_R1 | MMC_CMD_AC;
+
+	brq->cmd45.opcode = MMC_QUE_TASK_ADDR;
+	brq->cmd45.arg = blk_rq_pos(req);
+
+	mmc_set_data_timeout(&brq->data, card);
+
+	brq->data.sg = mqrq->sg;
+	brq->data.sg_len = mmc_queue_map_sg(mq, mqrq);
+
+	/*
+	 * Adjust the sg list so it is the same size as the
+	 * request.
+	 */
+	if (brq->data.blocks != blk_rq_sectors(req)) {
+		int i, data_size = brq->data.blocks << 9;
+		struct scatterlist *sg;
+
+		for_each_sg(brq->data.sg, sg, brq->data.sg_len, i) {
+			data_size -= sg->length;
+			if (data_size <= 0) {
+				sg->length += data_size;
+				i++;
+				break;
+			}
+		}
+		brq->data.sg_len = i;
+	}
+
+	mqrq->mmc_active.mrq = &brq->mrq;
+	mqrq->mmc_active.err_check = mmc_swcmdq_err_check;
+
+	mmc_queue_bounce_pre(mqrq);
+}
+
+static int mmc_swcmdq_blk_err(struct mmc_card *card, int err)
+{
+	/* Re-try after CRC errors when re-tuning is needed */
+	if (err == -EILSEQ && card->host->need_retune)
+		return MMC_BLK_RETRY;
+
+	if (err)
+		return MMC_BLK_ABORT;
+
+	return 0;
+}
+
+#define SWCMDQ_ENQUEUE_ERR (	\
+	R1_OUT_OF_RANGE |	\
+	R1_ADDRESS_ERROR |	\
+	R1_BLOCK_LEN_ERROR |	\
+	R1_WP_VIOLATION |	\
+	R1_CC_ERROR |		\
+	R1_ERROR |		\
+	R1_COM_CRC_ERROR |	\
+	R1_ILLEGAL_COMMAND)
+
+static int __mmc_swcmdq_enqueue(struct mmc_queue *mq,
+				struct mmc_queue_req *mqrq)
+{
+	struct mmc_card *card = mq->card;
+	int err;
+
+	mmc_swcmdq_prep(mq, mqrq);
+
+	err = mmc_wait_for_cmd(card->host, &mqrq->brq.cmd44, 0);
+	if (err)
+		goto out;
+
+	err = mmc_wait_for_cmd(card->host, &mqrq->brq.cmd45, 0);
+	if (err)
+		goto out;
+
+	/*
+	 * Don't assume the task is queued if there are any error bits set in
+	 * the response.
+	 */
+	if (mqrq->brq.cmd45.resp[0] & SWCMDQ_ENQUEUE_ERR)
+		return MMC_BLK_ABORT;
+out:
+	return mmc_swcmdq_blk_err(card, err);
+}
+
+static int mmc_swcmdq_enqueue(struct mmc_queue *mq, struct request *req)
+{
+	struct mmc_queue_req *mqrq;
+
+	mqrq = mmc_queue_req_find(mq, req);
+	if (!mqrq) {
+		WARN_ON(1);
+		mmc_blk_requeue(mq->queue, req);
+		return 0;
+	}
+
+	/* Need to hold re-tuning so long as the queue is not empty */
+	if (mq->qcnt == 1)
+		mmc_retune_hold(mq->card->host);
+
+	return __mmc_swcmdq_enqueue(mq, mqrq);
+}
+
+static struct mmc_async_req *mmc_swcmdq_next(struct mmc_queue *mq)
+{
+	int i = __ffs(mq->qsr);
+
+	__clear_bit(i, &mq->qsr);
+
+	if (i >= mq->qdepth)
+		return NULL;
+
+	return &mq->mqrq[i].mmc_active;
+}
+
+static int mmc_get_qsr(struct mmc_card *card, u32 *qsr)
+{
+	struct mmc_command cmd = {0};
+	int err, retries = 3;
+
+	cmd.opcode = MMC_SEND_STATUS;
+	cmd.arg = card->rca << 16 | 1 << 15;
+	cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
+	err = mmc_wait_for_cmd(card->host, &cmd, retries);
+	if (err)
+		return err;
+
+	*qsr = cmd.resp[0];
+
+	return 0;
+}
+
+static int mmc_await_qsr(struct mmc_card *card, u32 *qsr)
+{
+	unsigned long timeout;
+	u32 status = 0;
+	int err;
+
+	timeout = jiffies + msecs_to_jiffies(10 * 1000);
+	while (!status) {
+		err = mmc_get_qsr(card, &status);
+		if (err)
+			return err;
+		if (time_after(jiffies, timeout)) {
+			pr_err("%s: Card stuck with queued tasks\n",
+			       mmc_hostname(card->host));
+			return -ETIMEDOUT;
+		}
+	}
+
+	*qsr = status;
+
+	return 0;
+}
+
+static int mmc_swcmdq_await_qsr(struct mmc_queue *mq, struct mmc_card *card,
+				bool wait)
+{
+	struct mmc_queue_req *mqrq;
+	u32 qsr;
+	int err;
+
+	if (wait)
+		err = mmc_await_qsr(card, &qsr);
+	else
+		err = mmc_get_qsr(card, &qsr);
+	if (err)
+		goto out_err;
+
+	mq->qsr = qsr;
+
+	if (card->host->areq) {
+		/*
+		 * The active request remains in the QSR until completed. Remove
+		 * it so that mq->qsr only contains ones that are ready but not
+		 * executed.
+		 */
+		mqrq = container_of(card->host->areq, struct mmc_queue_req,
+				    mmc_active);
+		__clear_bit(mqrq->task_id, &mq->qsr);
+	}
+
+	if (mq->qsr)
+		mq->qsr_err = false;
+out_err:
+	if (err) {
+		/* Don't repeatedly retry if no progress is made */
+		if (mq->qsr_err)
+			return MMC_BLK_ABORT;
+		mq->qsr_err = true;
+	}
+
+	return mmc_swcmdq_blk_err(card, err);
+}
+
+static int mmc_swcmdq_execute(struct mmc_queue *mq, bool flush, bool requeuing,
+			      bool new_req)
+{
+	struct mmc_card *card = mq->card;
+	struct mmc_async_req *next = NULL, *prev;
+	struct mmc_blk_request *brq;
+	struct mmc_queue_req *mqrq;
+	enum mmc_blk_status status;
+	struct request *req;
+	int active = card->host->areq ? 1 : 0;
+	int ret;
+
+	if (mq->prepared_areq) {
+		/*
+		 * A request that has been prepared before (i.e. passed to
+		 * mmc_start_req()) but not started because another new request
+		 * turned up.
+		 */
+		next = mq->prepared_areq;
+	} else if (requeuing) {
+		/* Just finish the active request */
+		next = NULL;
+	} else if (mq->qsr) {
+		/* Get the next task from the Queue Status Register */
+		next = mmc_swcmdq_next(mq);
+	} else if (mq->qcnt > active) {
+		/*
+		 * There are queued tasks so read the Queue Status Register to
+		 * see if any are ready. Wait for a ready task only if there is
+		 * no active request and no new request.
+		 */
+		ret = mmc_swcmdq_await_qsr(mq, card, !active && !new_req);
+		if (ret)
+			return ret;
+		if (mq->qsr)
+			next = mmc_swcmdq_next(mq);
+	}
+
+	if (next) {
+		/*
+		 * Don't wake for a new request when waiting for the active
+		 * request if there is another request ready to start.
+		 */
+		if (active)
+			mmc_queue_set_wake(mq, false);
+	} else {
+		if (!active)
+			return 0;
+		/*
+		 * Don't wake for a new request when flushing or the queue is
+		 * full.
+		 */
+		if (flush || mq->qcnt == mq->qdepth)
+			mmc_queue_set_wake(mq, false);
+		else
+			mmc_queue_set_wake(mq, true);
+	}
+
+	prev = mmc_start_req(card->host, next, &status);
+
+	if (status == MMC_BLK_NEW_REQUEST) {
+		mq->prepared_areq = next;
+		return status;
+	}
+
+	mq->prepared_areq = NULL;
+
+	if (!prev)
+		return 0;
+
+	mqrq = container_of(prev, struct mmc_queue_req, mmc_active);
+	brq = &mqrq->brq;
+	req = mqrq->req;
+
+	mmc_queue_bounce_post(mqrq);
+
+	switch (status) {
+	case MMC_BLK_SUCCESS:
+	case MMC_BLK_PARTIAL:
+	case MMC_BLK_SUCCESS_ERR:
+		mmc_blk_reset_success(mq->blkdata, MMC_BLK_SWCMDQ);
+		ret = blk_end_request(req, 0, brq->data.bytes_xfered);
+		if (ret) {
+			if (!requeuing)
+				return __mmc_swcmdq_enqueue(mq, mqrq);
+			return 0;
+		}
+		break;
+	case MMC_BLK_NEW_REQUEST:
+		return status;
+	default:
+		if (mqrq->retry_cnt++) {
+			blk_end_request_all(req, -EIO);
+			break;
+		}
+		return status;
+	}
+
+	mmc_queue_req_free(mq, mqrq);
+
+	/* Release re-tuning when queue is empty */
+	if (!mq->qcnt)
+		mmc_retune_release(card->host);
+
+	return 0;
+}
+
+static enum mmc_blk_status mmc_swcmdq_requeue_check(struct mmc_card *card,
+						    struct mmc_async_req *areq)
+{
+	enum mmc_blk_status ret = mmc_swcmdq_err_check(card, areq);
+
+	/*
+	 * In the case of success, prevent mmc_start_req() from starting
+	 * another request by returning MMC_BLK_SUCCESS_ERR.
+	 */
+	return ret == MMC_BLK_SUCCESS ? MMC_BLK_SUCCESS_ERR : ret;
+}
+
+static int mmc_swcmdq_await_active(struct mmc_queue *mq)
+{
+	struct mmc_async_req *areq = mq->card->host->areq;
+	int err;
+
+	if (!areq)
+		return 0;
+
+	areq->err_check = mmc_swcmdq_requeue_check;
+
+	err = mmc_swcmdq_execute(mq, true, true, false);
+
+	/* The request will be requeued anyway, so ignore 'retry' */
+	if (err == MMC_BLK_RETRY)
+		err = 0;
+
+	return err;
+}
+
+static int mmc_swcmdq_discard_queue(struct mmc_queue *mq)
+{
+	struct mmc_command cmd = {0};
+
+	if (!mq->qcnt)
+		return 0;
+
+	mq->qsr = 0;
+
+	cmd.opcode = MMC_CMDQ_TASK_MGMT;
+	cmd.arg = 1; /* Discard entire queue */
+	cmd.flags = MMC_RSP_R1B | MMC_CMD_AC;
+	/* This is for recovery and the response is not needed, so ignore CRC */
+	cmd.flags &= ~MMC_RSP_CRC;
+
+	return mmc_wait_for_cmd(mq->card->host, &cmd, 0);
+}
+
+static int __mmc_swcmdq_requeue(struct mmc_queue *mq)
+{
+	unsigned long i, qslots = mq->qslots;
+	int err;
+
+	if (qslots) {
+		/* Cause re-tuning before next command, if needed */
+		mmc_retune_release(mq->card->host);
+		mmc_retune_hold(mq->card->host);
+	}
+
+	while (qslots) {
+		i = __ffs(qslots);
+		err = __mmc_swcmdq_enqueue(mq, &mq->mqrq[i]);
+		if (err)
+			return err;
+		__clear_bit(i, &qslots);
+	}
+
+	return 0;
+}
+
+static void __mmc_swcmdq_error_out(struct mmc_queue *mq)
+{
+	unsigned long i, qslots = mq->qslots;
+	struct request *req;
+
+	if (qslots)
+		mmc_retune_release(mq->card->host);
+
+	while (qslots) {
+		i = __ffs(qslots);
+		req = mq->mqrq[i].req;
+		blk_end_request_all(req, -EIO);
+		mq->mqrq[i].req = NULL;
+		__clear_bit(i, &qslots);
+	}
+
+	mq->qslots = 0;
+	mq->qcnt = 0;
+}
+
+static int mmc_swcmdq_requeue(struct mmc_queue *mq)
+{
+	int err;
+
+	/* Wait for active request */
+	err = mmc_swcmdq_await_active(mq);
+	if (err)
+		return err;
+
+	err = mmc_swcmdq_discard_queue(mq);
+	if (err)
+		return err;
+
+	return __mmc_swcmdq_requeue(mq);
+}
+
+static void mmc_swcmdq_reset(struct mmc_queue *mq)
+{
+	/* Wait for active request ignoring errors */
+	mmc_swcmdq_await_active(mq);
+
+	/* Ensure the queue is discarded */
+	mmc_swcmdq_discard_queue(mq);
+
+	/* Reset and requeue else error out all requests */
+	if (mmc_blk_reset(mq->blkdata, mq->card->host, MMC_BLK_SWCMDQ) ||
+	    __mmc_swcmdq_requeue(mq))
+		__mmc_swcmdq_error_out(mq);
+}
+
+/*
+ * Recovery has 2 options:
+ * 1. Discard the queue and re-queue all requests. If that fails, fall back to
+ *    option 2.
+ * 2. Reset and re-queue all requests. If that fails, error out all the
+ *    requests.
+ * In either case, re-tuning will be done if needed after the queue becomes
+ * empty because re-tuning is released at that point.
+ */
+static void mmc_swcmdq_recovery(struct mmc_queue *mq, int err)
+{
+	switch (err) {
+	case MMC_BLK_RETRY:
+		err = mmc_swcmdq_requeue(mq);
+		if (!err)
+			break;
+		/* Fall through */
+	default:
+		mmc_swcmdq_reset(mq);
+	}
+}
+
+static int mmc_swcmdq_issue_rw_rq(struct mmc_queue *mq, struct request *req)
+{
+	struct mmc_context_info *cntx = &mq->card->host->context_info;
+	bool flush = !req && !cntx->is_waiting_last_req;
+	int err;
+
+	/* Enqueue new requests */
+	if (req) {
+		err = mmc_swcmdq_enqueue(mq, req);
+		if (err)
+			mmc_swcmdq_recovery(mq, err);
+	}
+
+	/*
+	 * Keep executing queued requests until the queue is empty or
+	 * mmc_swcmdq_execute() asks for new requests by returning
+	 * MMC_BLK_NEW_REQUEST.
+	 */
+	while (mq->qcnt) {
+		/*
+		 * Re-tuning can only be done when the queue is empty. Recovery
+		 * for MMC_BLK_RETRY will discard the queue and re-queue all
+		 * requests. At the point the queue is empty, re-tuning is
+		 * released and will be done automatically before the next
+		 * mmc_request.
+		 */
+		if (mq->card->host->need_retune)
+			mmc_swcmdq_recovery(mq, MMC_BLK_RETRY);
+		err = mmc_swcmdq_execute(mq, flush, false, !!req);
+		if (err == MMC_BLK_NEW_REQUEST)
+			return 0;
+		if (err)
+			mmc_swcmdq_recovery(mq, err);
+	}
+
+	return 0;
+}
+
+static int __mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 {
 	struct mmc_blk_data *md = mq->blkdata;
 	struct mmc_card *card = md->queue.card;
@@ -1802,6 +2380,17 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 	return 0;
 }
 
+static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
+{
+	struct mmc_blk_data *md = mq->blkdata;
+	struct mmc_card *card = md->queue.card;
+
+	if (card->ext_csd.cmdq_en)
+		return mmc_swcmdq_issue_rw_rq(mq, req);
+	else
+		return __mmc_blk_issue_rw_rq(mq, req);
+}
+
 int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 {
 	int ret;
diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index ff01bef720be..d58405a7d2f5 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -64,6 +64,7 @@ struct mmc_queue_req *mmc_queue_req_find(struct mmc_queue *mq,
 	mqrq->req = req;
 	mq->qcnt += 1;
 	__set_bit(mqrq->task_id, &mq->qslots);
+	mqrq->retry_cnt = 0;
 
 	return mqrq;
 }
@@ -377,7 +378,14 @@ static int __mmc_queue_alloc_shared_queue(struct mmc_card *card, int qdepth)
 
 int mmc_queue_alloc_shared_queue(struct mmc_card *card)
 {
-	return __mmc_queue_alloc_shared_queue(card, 2);
+	int qdepth;
+
+	if (card->ext_csd.cmdq_en)
+		qdepth = card->ext_csd.cmdq_depth;
+	else
+		qdepth = 2;
+
+	return __mmc_queue_alloc_shared_queue(card, qdepth);
 }
 
 /**
diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
index 78ad5ab8c496..208df56cf4e1 100644
--- a/drivers/mmc/card/queue.h
+++ b/drivers/mmc/card/queue.h
@@ -15,9 +15,13 @@ static inline bool mmc_req_is_special(struct request *req)
 
 struct mmc_blk_request {
 	struct mmc_request	mrq;
-	struct mmc_command	sbc;
+	union {
+		struct mmc_command	sbc;
+		struct mmc_command	cmd44;
+	};
 	struct mmc_command	cmd;
 	struct mmc_command	stop;
+	struct mmc_command	cmd45;
 	struct mmc_data		data;
 	int			retune_retry_done;
 };
@@ -31,6 +35,7 @@ struct mmc_queue_req {
 	unsigned int		bounce_sg_len;
 	struct mmc_async_req	mmc_active;
 	int			task_id;
+	unsigned int		retry_cnt;
 };
 
 struct mmc_queue {
@@ -47,6 +52,10 @@ struct mmc_queue {
 	int			qdepth;
 	int			qcnt;
 	unsigned long		qslots;
+	/* Following are defined for Software Command Queuing */
+	unsigned long		qsr;
+	struct mmc_async_req	*prepared_areq;
+	bool			qsr_err;
 };
 
 extern int mmc_queue_alloc_shared_queue(struct mmc_card *card);
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 3152135af4fd..08800b8a41c7 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -25,6 +25,7 @@ enum mmc_blk_status {
 	MMC_BLK_ECC_ERR,
 	MMC_BLK_NOMEDIUM,
 	MMC_BLK_NEW_REQUEST,
+	MMC_BLK_SUCCESS_ERR, /* Success but prevent starting another request */
 };
 
 struct mmc_command {
-- 
1.9.1

