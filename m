From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 23/46] mmc: queue: Fix queue thread wake-up
Date: Thu,  9 Jun 2016 14:52:23 +0300
Message-ID: <1465473166-22532-24-git-send-email-adrian.hunter@intel.com>
References: <1465473166-22532-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:48207 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751569AbcFIL6U (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 9 Jun 2016 07:58:20 -0400
In-Reply-To: <1465473166-22532-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>

The only time the driver sleeps expecting to be woken upon the arrival of
a new request, is when the dispatch queue is empty. The only time that it
is known whether the dispatch queue is empty is after NULL is returned
from blk_fetch_request() while under the queue lock.

Recognizing those facts, simplify the synchronization between the queue
thread and the request function. A couple of flags tell the request
function what to do, and the queue lock and barriers associated with
wake-ups ensure synchronization.

The result is simpler and allows the removal of the context_info lock.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/card/block.c |  7 -------
 drivers/mmc/card/queue.c | 35 +++++++++++++++++++++--------------
 drivers/mmc/card/queue.h |  1 +
 drivers/mmc/core/core.c  |  6 ------
 include/linux/mmc/host.h |  2 --
 5 files changed, 22 insertions(+), 29 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 5345730c6eeb..7e69dceaf645 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -2146,8 +2146,6 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 	int ret;
 	struct mmc_blk_data *md = mq->data;
 	struct mmc_card *card = md->queue.card;
-	struct mmc_host *host = card->host;
-	unsigned long flags;
 	unsigned int cmd_flags = req ? req->cmd_flags : 0;
 
 	if (req && !mq->mqrq_prev->req)
@@ -2178,11 +2176,6 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 			mmc_blk_issue_rw_rq(mq, NULL);
 		ret = mmc_blk_issue_flush(mq, req);
 	} else {
-		if (!req && host->areq) {
-			spin_lock_irqsave(&host->context_info.lock, flags);
-			host->context_info.is_waiting_last_req = true;
-			spin_unlock_irqrestore(&host->context_info.lock, flags);
-		}
 		ret = mmc_blk_issue_rw_rq(mq, req);
 	}
 
diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 6f4323c6d653..7469d0d99027 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -50,6 +50,7 @@ static int mmc_queue_thread(void *d)
 {
 	struct mmc_queue *mq = d;
 	struct request_queue *q = mq->queue;
+	struct mmc_context_info *cntx = &mq->card->host->context_info;
 
 	current->flags |= PF_MEMALLOC;
 
@@ -61,6 +62,19 @@ static int mmc_queue_thread(void *d)
 		spin_lock_irq(q->queue_lock);
 		set_current_state(TASK_INTERRUPTIBLE);
 		req = blk_fetch_request(q);
+		mq->asleep = false;
+		cntx->is_waiting_last_req = false;
+		cntx->is_new_req = false;
+		if (!req) {
+			/*
+			 * Dispatch queue is empty so set flags for
+			 * mmc_request_fn() to wake us up.
+			 */
+			if (mq->mqrq_prev->req)
+				cntx->is_waiting_last_req = true;
+			else
+				mq->asleep = true;
+		}
 		mq->mqrq_cur->req = req;
 		spin_unlock_irq(q->queue_lock);
 
@@ -112,7 +126,6 @@ static void mmc_request_fn(struct request_queue *q)
 {
 	struct mmc_queue *mq = q->queuedata;
 	struct request *req;
-	unsigned long flags;
 	struct mmc_context_info *cntx;
 
 	if (!mq) {
@@ -124,19 +137,13 @@ static void mmc_request_fn(struct request_queue *q)
 	}
 
 	cntx = &mq->card->host->context_info;
-	if (!mq->mqrq_cur->req && mq->mqrq_prev->req) {
-		/*
-		 * New MMC request arrived when MMC thread may be
-		 * blocked on the previous request to be complete
-		 * with no current request fetched
-		 */
-		spin_lock_irqsave(&cntx->lock, flags);
-		if (cntx->is_waiting_last_req) {
-			cntx->is_new_req = true;
-			wake_up_interruptible(&cntx->wait);
-		}
-		spin_unlock_irqrestore(&cntx->lock, flags);
-	} else if (!mq->mqrq_cur->req && !mq->mqrq_prev->req)
+
+	if (cntx->is_waiting_last_req) {
+		cntx->is_new_req = true;
+		wake_up_interruptible(&cntx->wait);
+	}
+
+	if (mq->asleep)
 		wake_up_process(mq->thread);
 }
 
diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
index 36cddab57d77..872c82a83729 100644
--- a/drivers/mmc/card/queue.h
+++ b/drivers/mmc/card/queue.h
@@ -51,6 +51,7 @@ struct mmc_queue {
 	unsigned int		flags;
 #define MMC_QUEUE_SUSPENDED	(1 << 0)
 #define MMC_QUEUE_NEW_REQUEST	(1 << 1)
+	bool			asleep;
 
 	int			(*issue_fn)(struct mmc_queue *, struct request *);
 	void			*data;
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 8563dc9e1519..2c50883f3845 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -501,18 +501,14 @@ static int mmc_wait_for_data_req_done(struct mmc_host *host,
 	struct mmc_command *cmd;
 	struct mmc_context_info *context_info = &host->context_info;
 	int err;
-	unsigned long flags;
 
 	while (1) {
 		wait_event_interruptible(context_info->wait,
 				(context_info->is_done_rcv ||
 				 context_info->is_new_req));
-		spin_lock_irqsave(&context_info->lock, flags);
 		context_info->is_waiting_last_req = false;
-		spin_unlock_irqrestore(&context_info->lock, flags);
 		if (context_info->is_done_rcv) {
 			context_info->is_done_rcv = false;
-			context_info->is_new_req = false;
 			cmd = mrq->cmd;
 
 			if (!cmd->error || !cmd->retries ||
@@ -531,7 +527,6 @@ static int mmc_wait_for_data_req_done(struct mmc_host *host,
 				continue; /* wait for done/new event again */
 			}
 		} else if (context_info->is_new_req) {
-			context_info->is_new_req = false;
 			if (!next_req)
 				return MMC_BLK_NEW_REQUEST;
 		}
@@ -2939,7 +2934,6 @@ void mmc_unregister_pm_notifier(struct mmc_host *host)
  */
 void mmc_init_context_info(struct mmc_host *host)
 {
-	spin_lock_init(&host->context_info.lock);
 	host->context_info.is_new_req = false;
 	host->context_info.is_done_rcv = false;
 	host->context_info.is_waiting_last_req = false;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index af247e4c75d5..567c6c14c9f3 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -198,14 +198,12 @@ struct mmc_slot {
  * @is_new_req		wake up reason was new request
  * @is_waiting_last_req	mmc context waiting for single running request
  * @wait		wait queue
- * @lock		lock to protect data fields
  */
 struct mmc_context_info {
 	bool			is_done_rcv;
 	bool			is_new_req;
 	bool			is_waiting_last_req;
 	wait_queue_head_t	wait;
-	spinlock_t		lock;
 };
 
 struct regulator;
-- 
1.9.1

