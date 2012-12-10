From: Konstantin Dorfman <kdorfman@codeaurora.org>
Subject: [RESEND PATCH v4] mmc: fix async request mechanism for sequential read scenarios
Date: Mon, 10 Dec 2012 16:23:50 +0200
Message-ID: <1355149430-17496-1-git-send-email-kdorfman@codeaurora.org>
References: <n>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:18965 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437Ab2LJOYN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Dec 2012 09:24:13 -0500
In-Reply-To: <n>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, per.lkml@gmail.com, tgih.jun@samsung.com, Konstantin Dorfman <kdorfman@codeaurora.org>

When current request is running on the bus and if next request fetched
by mmcqd is NULL, mmc context (mmcqd thread) gets blocked until the
current request completes. This means if new request comes in while
the mmcqd thread is blocked, this new request can not be prepared in
parallel to current ongoing request. This may result in latency to
start new request.

This change allows to wake up the MMC thread (which
is waiting for the current running request to complete). Now once the
MMC thread is woken up, new request can be fetched and prepared in
parallel to current running request which means this new request can
be started immediately after the current running request completes.

With this change read throughput is improved by 16%.

Signed-off-by: Konstantin Dorfman <kdorfman@codeaurora.org>
---


v4:     
	keeps new synchronization mechanism within mmc/core
	layer, so mmc/core external API's are not changed.
	- context_info moved into mmc_host struct
	- context_info initialized in mmc_rescan_try_freq()

v3:
	- new MMC_QUEUE_NEW_REQUEST flag to mark new request case
	- lock added to update is_new_req flag
	- condition for sending new req notification changed
	- Moved start waiting for new req notification after fetching NULL
v2: 
	- Removed synchronization flags
	- removed lock from done()
	- flags names changed
v1: 
	- Initial submit

 drivers/mmc/card/block.c |   25 +++++------
 drivers/mmc/card/queue.c |   27 ++++++++++-
 drivers/mmc/card/queue.h |    2 +
 drivers/mmc/core/core.c  |  112 ++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/mmc/card.h |   12 +++++
 include/linux/mmc/core.h |    3 +-
 include/linux/mmc/host.h |   16 +++++++
 7 files changed, 177 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 21056b9..6fe0412 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -113,17 +113,6 @@ struct mmc_blk_data {
 
 static DEFINE_MUTEX(open_lock);
 
-enum mmc_blk_status {
-	MMC_BLK_SUCCESS = 0,
-	MMC_BLK_PARTIAL,
-	MMC_BLK_CMD_ERR,
-	MMC_BLK_RETRY,
-	MMC_BLK_ABORT,
-	MMC_BLK_DATA_ERR,
-	MMC_BLK_ECC_ERR,
-	MMC_BLK_NOMEDIUM,
-};
-
 module_param(perdev_minors, int, 0444);
 MODULE_PARM_DESC(perdev_minors, "Minors numbers to allocate per device");
 
@@ -1180,6 +1169,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 	memset(brq, 0, sizeof(struct mmc_blk_request));
 	brq->mrq.cmd = &brq->cmd;
 	brq->mrq.data = &brq->data;
+	brq->mrq.host = card->host;
 
 	brq->cmd.arg = blk_rq_pos(req);
 	if (!mmc_card_blockaddr(card))
@@ -1363,9 +1353,12 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 			areq = &mq->mqrq_cur->mmc_active;
 		} else
 			areq = NULL;
-		areq = mmc_start_req(card->host, areq, (int *) &status);
-		if (!areq)
+		areq = mmc_start_req(card->host, areq, (int *)&status);
+		if (!areq) {
+			if (status == MMC_BLK_NEW_REQUEST)
+				mq->flags |= MMC_QUEUE_NEW_REQUEST;
 			return 0;
+		}
 
 		mq_rq = container_of(areq, struct mmc_queue_req, mmc_active);
 		brq = &mq_rq->brq;
@@ -1374,6 +1367,8 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 		mmc_queue_bounce_post(mq_rq);
 
 		switch (status) {
+		case MMC_BLK_NEW_REQUEST:
+			BUG(); /* should never get here */
 		case MMC_BLK_SUCCESS:
 		case MMC_BLK_PARTIAL:
 			/*
@@ -1486,6 +1481,7 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 		goto out;
 	}
 
+	mq->flags &= ~MMC_QUEUE_NEW_REQUEST;
 	if (req && req->cmd_flags & REQ_DISCARD) {
 		/* complete ongoing async transfer before issuing discard */
 		if (card->host->areq)
@@ -1505,9 +1501,10 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 	}
 
 out:
-	if (!req)
+	if (!req && !(mq->flags & MMC_QUEUE_NEW_REQUEST))
 		/* release host only when there are no more requests */
 		mmc_release_host(card->host);
+
 	return ret;
 }
 
diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index fadf52e..0c37b49 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -22,7 +22,6 @@
 
 #define MMC_QUEUE_BOUNCESZ	65536
 
-#define MMC_QUEUE_SUSPENDED	(1 << 0)
 
 /*
  * Prepare a MMC request. This just filters out odd stuff.
@@ -63,11 +62,20 @@ static int mmc_queue_thread(void *d)
 		set_current_state(TASK_INTERRUPTIBLE);
 		req = blk_fetch_request(q);
 		mq->mqrq_cur->req = req;
+		if (!req && mq->mqrq_prev->req &&
+			!(mq->mqrq_prev->req->cmd_flags & REQ_FLUSH) &&
+			!(mq->mqrq_prev->req->cmd_flags & REQ_DISCARD))
+			mq->card->host->context_info.is_waiting_last_req = true;
+
 		spin_unlock_irq(q->queue_lock);
 
 		if (req || mq->mqrq_prev->req) {
 			set_current_state(TASK_RUNNING);
 			mq->issue_fn(mq, req);
+			if (mq->flags & MMC_QUEUE_NEW_REQUEST) {
+				mq->flags &= ~MMC_QUEUE_NEW_REQUEST;
+				continue; /* fetch again */
+			}
 
 			/*
 			 * Current request becomes previous request
@@ -103,6 +111,8 @@ static void mmc_request_fn(struct request_queue *q)
 {
 	struct mmc_queue *mq = q->queuedata;
 	struct request *req;
+	unsigned long flags;
+	struct mmc_context_info *cntx;
 
 	if (!mq) {
 		while ((req = blk_fetch_request(q)) != NULL) {
@@ -112,7 +122,20 @@ static void mmc_request_fn(struct request_queue *q)
 		return;
 	}
 
-	if (!mq->mqrq_cur->req && !mq->mqrq_prev->req)
+	cntx = &mq->card->host->context_info;
+	if (!mq->mqrq_cur->req && mq->mqrq_prev->req) {
+		/*
+		 * New MMC request arrived when MMC thread may be
+		 * blocked on the previous request to be complete
+		 * with no current request fetched
+		 */
+		spin_lock_irqsave(&cntx->lock, flags);
+		if (cntx->is_waiting_last_req) {
+			cntx->is_new_req = true;
+			wake_up_interruptible(&cntx->wait);
+		}
+		spin_unlock_irqrestore(&cntx->lock, flags);
+	} else if (!mq->mqrq_cur->req && !mq->mqrq_prev->req)
 		wake_up_process(mq->thread);
 }
 
diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
index d2a1eb4..970d9e7 100644
--- a/drivers/mmc/card/queue.h
+++ b/drivers/mmc/card/queue.h
@@ -26,6 +26,8 @@ struct mmc_queue {
 	struct mmc_card		*card;
 	struct task_struct	*thread;
 	struct semaphore	thread_sem;
+#define MMC_QUEUE_SUSPENDED	(1 << 0)
+#define MMC_QUEUE_NEW_REQUEST	(1 << 1)
 	unsigned int		flags;
 	int			(*issue_fn)(struct mmc_queue *, struct request *);
 	void			*data;
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index aaed768..344cd3a 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -319,11 +319,43 @@ out:
 }
 EXPORT_SYMBOL(mmc_start_bkops);
 
+/*
+ * mmc_wait_data_done() - done callback for data request
+ * @mrq: done data request
+ *
+ * Wakes up mmc context, passed as callback to host controller driver
+ */
+static void mmc_wait_data_done(struct mmc_request *mrq)
+{
+	mrq->host->context_info.is_done_rcv = true;
+	wake_up_interruptible(&mrq->host->context_info.wait);
+}
+
 static void mmc_wait_done(struct mmc_request *mrq)
 {
 	complete(&mrq->completion);
 }
 
+/*
+ *__mmc_start_data_req() - starts data request
+ * @host: MMC host to start the request
+ * @mrq: data request to start
+ *
+ * Fills done callback that will be used when request are done by card.
+ * Starts data mmc request execution
+ */
+static int __mmc_start_data_req(struct mmc_host *host, struct mmc_request *mrq)
+{
+	mrq->done = mmc_wait_data_done;
+	if (mmc_card_removed(host->card)) {
+		mrq->cmd->error = -ENOMEDIUM;
+		return -ENOMEDIUM;
+	}
+	mmc_start_request(host, mrq);
+
+	return 0;
+}
+
 static int __mmc_start_req(struct mmc_host *host, struct mmc_request *mrq)
 {
 	init_completion(&mrq->completion);
@@ -337,6 +369,60 @@ static int __mmc_start_req(struct mmc_host *host, struct mmc_request *mrq)
 	return 0;
 }
 
+/*
+ * mmc_wait_for_data_req_done() - wait for request completed or new
+ *				  request notification arrives
+ * @host: MMC host to prepare the command.
+ * @mrq: MMC request to wait for
+ *
+ * Blocks MMC context till host controller will ack end of data request
+ * execution or new request arrives from block layer. Handles
+ * command retries.
+ *
+ * Returns enum mmc_blk_status after checking errors.
+ */
+static int mmc_wait_for_data_req_done(struct mmc_host *host,
+				      struct mmc_request *mrq)
+{
+	struct mmc_command *cmd;
+	struct mmc_context_info *context_info = &host->context_info;
+	int err;
+	unsigned long flags;
+
+	while (1) {
+		wait_event_interruptible(context_info->wait,
+				(context_info->is_done_rcv ||
+				 context_info->is_new_req));
+		spin_lock_irqsave(&context_info->lock, flags);
+		context_info->is_waiting_last_req = false;
+		spin_unlock_irqrestore(&context_info->lock, flags);
+		if (context_info->is_done_rcv) {
+			context_info->is_done_rcv = false;
+			context_info->is_new_req = false;
+			cmd = mrq->cmd;
+			if (!cmd->error || !cmd->retries ||
+					mmc_card_removed(host->card)) {
+				err = host->areq->err_check(host->card,
+						host->areq);
+				break; /* return err */
+			} else {
+				pr_info("%s: req failed (CMD%u): %d, retrying...\n",
+						mmc_hostname(host),
+						cmd->opcode, cmd->error);
+				cmd->retries--;
+				cmd->error = 0;
+				host->ops->request(host, mrq);
+				continue; /* wait for done/new event again */
+			}
+		} else if (context_info->is_new_req) {
+			context_info->is_new_req = false;
+			err = MMC_BLK_NEW_REQUEST;
+			break; /* return err */
+		}
+	} /* while */
+	return err;
+}
+
 static void mmc_wait_for_req_done(struct mmc_host *host,
 				  struct mmc_request *mrq)
 {
@@ -426,8 +512,21 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
 		mmc_pre_req(host, areq->mrq, !host->areq);
 
 	if (host->areq) {
-		mmc_wait_for_req_done(host, host->areq->mrq);
-		err = host->areq->err_check(host->card, host->areq);
+		err = mmc_wait_for_data_req_done(host, host->areq->mrq);
+		if (err == MMC_BLK_NEW_REQUEST) {
+			if (areq) {
+				pr_err("%s: new request while areq = %p",
+						mmc_hostname(host), areq);
+				BUG_ON(1);
+			}
+			if (error)
+				*error = err;
+			/*
+			 * The previous request was not completed,
+			 * nothing to return
+			 */
+			return NULL;
+		}
 		/*
 		 * Check BKOPS urgency for each R1 response
 		 */
@@ -439,7 +538,7 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
 	}
 
 	if (!err && areq)
-		start_err = __mmc_start_req(host, areq->mrq);
+		start_err = __mmc_start_data_req(host, areq->mrq);
 
 	if (host->areq)
 		mmc_post_req(host, host->areq->mrq, 0);
@@ -455,6 +554,7 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
 
 	if (error)
 		*error = err;
+
 	return data;
 }
 EXPORT_SYMBOL(mmc_start_req);
@@ -2086,6 +2186,12 @@ static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
 
 	mmc_send_if_cond(host, host->ocr_avail);
 
+	spin_lock_init(&host->context_info.lock);
+	host->context_info.is_new_req = false;
+	host->context_info.is_done_rcv = false;
+	host->context_info.is_waiting_last_req = false;
+	init_waitqueue_head(&host->context_info.wait);
+
 	/* Order's important: probe SDIO, then SD, then MMC */
 	if (!mmc_attach_sdio(host))
 		return 0;
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 5c69315..be2500a 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -187,6 +187,18 @@ struct sdio_func_tuple;
 
 #define SDIO_MAX_FUNCS		7
 
+enum mmc_blk_status {
+	MMC_BLK_SUCCESS = 0,
+	MMC_BLK_PARTIAL,
+	MMC_BLK_CMD_ERR,
+	MMC_BLK_RETRY,
+	MMC_BLK_ABORT,
+	MMC_BLK_DATA_ERR,
+	MMC_BLK_ECC_ERR,
+	MMC_BLK_NOMEDIUM,
+	MMC_BLK_NEW_REQUEST,
+};
+
 /* The number of MMC physical partitions.  These consist of:
  * boot partitions (2), general purpose partitions (4) in MMC v4.4.
  */
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 5bf7c22..724cc95 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -120,6 +120,7 @@ struct mmc_data {
 	s32			host_cookie;	/* host private data */
 };
 
+struct mmc_host;
 struct mmc_request {
 	struct mmc_command	*sbc;		/* SET_BLOCK_COUNT for multiblock */
 	struct mmc_command	*cmd;
@@ -128,9 +129,9 @@ struct mmc_request {
 
 	struct completion	completion;
 	void			(*done)(struct mmc_request *);/* completion function */
+	struct mmc_host         *host;
 };
 
-struct mmc_host;
 struct mmc_card;
 struct mmc_async_req;
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 61a10c1..c26c180 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -177,6 +177,21 @@ struct mmc_supply {
 	struct regulator *vqmmc;	/* Optional Vccq supply */
 };
 
+/**
+ * mmc_context_info - synchronization details for mmc context
+ * @is_done_rcv		wake up reason was done request
+ * @is_new_req	wake up reason was new request
+ * @is_waiting_last_req	mmc context waiting for single running request
+ * @wait		wait queue
+ */
+struct mmc_context_info {
+	bool			is_done_rcv;
+	bool			is_new_req;
+	bool			is_waiting_last_req;
+	wait_queue_head_t	wait;
+	spinlock_t		lock;
+};
+
 struct mmc_host {
 	struct device		*parent;
 	struct device		class_dev;
@@ -331,6 +346,7 @@ struct mmc_host {
 	struct dentry		*debugfs_root;
 
 	struct mmc_async_req	*areq;		/* active async req */
+	struct mmc_context_info context_info;   /* async synchronization info */
 
 #ifdef CONFIG_FAIL_MMC_REQUEST
 	struct fault_attr	fail_mmc_request;
-- 
1.7.6
--
Konstantin Dorfman,
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center,
Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
