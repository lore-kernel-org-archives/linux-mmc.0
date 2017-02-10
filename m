From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 09/39] mmc: queue: Add a function to control wake-up on new requests
Date: Fri, 10 Feb 2017 14:55:22 +0200
Message-ID: <1486731352-8018-10-git-send-email-adrian.hunter@intel.com>
References: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:22345 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751203AbdBJNpk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 10 Feb 2017 08:45:40 -0500
In-Reply-To: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

Add a function to control wake-up on new requests. This will enable
Software Command Queuing to choose whether or not to queue new
requests immediately or wait for the current task to complete.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/queue.c | 16 ++++++++++++++++
 drivers/mmc/core/queue.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 479638bfb092..9e7e4eb9250c 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -97,6 +97,7 @@ static int mmc_queue_thread(void *d)
 		cntx->is_waiting_last_req = false;
 		cntx->is_new_req = false;
 		if (!req) {
+			mq->is_new_req = false;
 			/*
 			 * Dispatch queue is empty so set flags for
 			 * mmc_request_fn() to wake us up.
@@ -147,6 +148,8 @@ static void mmc_request_fn(struct request_queue *q)
 		return;
 	}
 
+	mq->is_new_req = true;
+
 	cntx = &mq->card->host->context_info;
 
 	if (cntx->is_waiting_last_req) {
@@ -158,6 +161,19 @@ static void mmc_request_fn(struct request_queue *q)
 		wake_up_process(mq->thread);
 }
 
+void mmc_queue_set_wake(struct mmc_queue *mq, bool wake_me)
+{
+	struct mmc_context_info *cntx = &mq->card->host->context_info;
+	struct request_queue *q = mq->queue;
+
+	if (cntx->is_waiting_last_req != wake_me) {
+		spin_lock_irq(q->queue_lock);
+		cntx->is_waiting_last_req = wake_me;
+		cntx->is_new_req = wake_me && mq->is_new_req;
+		spin_unlock_irq(q->queue_lock);
+	}
+}
+
 static struct scatterlist *mmc_alloc_sg(int sg_len)
 {
 	struct scatterlist *sg;
diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index 871796c3f406..c9ce0172dd08 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -43,6 +43,7 @@ struct mmc_queue {
 	struct semaphore	thread_sem;
 	bool			suspended;
 	bool			asleep;
+	bool			is_new_req;
 	struct mmc_blk_data	*blkdata;
 	struct request_queue	*queue;
 	struct mmc_queue_req	*mqrq;
@@ -69,5 +70,6 @@ extern unsigned int mmc_queue_map_sg(struct mmc_queue *,
 extern struct mmc_queue_req *mmc_queue_req_find(struct mmc_queue *,
 						struct request *);
 extern void mmc_queue_req_free(struct mmc_queue *, struct mmc_queue_req *);
+extern void mmc_queue_set_wake(struct mmc_queue *, bool);
 
 #endif
-- 
1.9.1

