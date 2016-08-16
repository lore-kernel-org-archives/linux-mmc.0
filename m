From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V4 26/30] mmc: queue: Add a function to control wake-up on new requests
Date: Tue, 16 Aug 2016 13:44:36 +0300
Message-ID: <1471344280-16663-27-git-send-email-adrian.hunter@intel.com>
References: <1471344280-16663-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:44366 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753136AbcHPKuz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 16 Aug 2016 06:50:55 -0400
In-Reply-To: <1471344280-16663-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

Add a function to control wake-up on new requests. This will enable
Software Command Queuing to choose whether or not to queue new
requests immediately or wait for the current task to complete.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/card/queue.c | 16 ++++++++++++++++
 drivers/mmc/card/queue.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 5457591cc739..1f3752fbb430 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -95,6 +95,7 @@ static int mmc_queue_thread(void *d)
 		cntx->is_waiting_last_req = false;
 		cntx->is_new_req = false;
 		if (!req) {
+			mq->is_new_req = false;
 			/*
 			 * Dispatch queue is empty so set flags for
 			 * mmc_request_fn() to wake us up.
@@ -145,6 +146,8 @@ static void mmc_request_fn(struct request_queue *q)
 		return;
 	}
 
+	mq->is_new_req = true;
+
 	cntx = &mq->card->host->context_info;
 
 	if (cntx->is_waiting_last_req) {
@@ -156,6 +159,19 @@ static void mmc_request_fn(struct request_queue *q)
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
 static struct scatterlist *mmc_alloc_sg(int sg_len, int *err)
 {
 	struct scatterlist *sg;
diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
index b487e0a62b50..c72758ad86b5 100644
--- a/drivers/mmc/card/queue.h
+++ b/drivers/mmc/card/queue.h
@@ -50,6 +50,7 @@ struct mmc_queue {
 	unsigned int		flags;
 #define MMC_QUEUE_SUSPENDED	(1 << 0)
 	bool			asleep;
+	bool			is_new_req;
 
 	int			(*issue_fn)(struct mmc_queue *, struct request *);
 	void			*data;
@@ -79,5 +80,6 @@ extern int mmc_access_rpmb(struct mmc_queue *);
 extern struct mmc_queue_req *mmc_queue_req_find(struct mmc_queue *,
 						struct request *);
 extern void mmc_queue_req_free(struct mmc_queue *, struct mmc_queue_req *);
+extern void mmc_queue_set_wake(struct mmc_queue *, bool);
 
 #endif
-- 
1.9.1

