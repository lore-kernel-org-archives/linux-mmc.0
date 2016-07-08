From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V3 11/30] mmc: queue: Introduce queue depth
Date: Fri,  8 Jul 2016 13:22:52 +0300
Message-ID: <1467973391-29221-12-git-send-email-adrian.hunter@intel.com>
References: <1467973391-29221-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:45373 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754046AbcGHK2N (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 8 Jul 2016 06:28:13 -0400
In-Reply-To: <1467973391-29221-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

Add a mmc_queue member to record the size of the queue, which currently
supports 2 requests on-the-go at a time.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/card/queue.c | 4 ++++
 drivers/mmc/card/queue.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index b10bae73d157..1a8e5d45f74d 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -293,6 +293,7 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 	if (!mq->queue)
 		return -ENOMEM;
 
+	mq->qdepth = 2;
 	mq->mqrq_cur = &mq->mqrq[0];
 	mq->mqrq_prev = &mq->mqrq[1];
 	mq->queue->queuedata = mq;
@@ -390,6 +391,9 @@ int mmc_packed_init(struct mmc_queue *mq, struct mmc_card *card)
 	struct mmc_queue_req *mqrq_prev = &mq->mqrq[1];
 	int ret = 0;
 
+	/* Queue depth is only ever 2 with packed commands */
+	if (mq->qdepth != 2)
+		return -EINVAL;
 
 	mqrq_cur->packed = kzalloc(sizeof(struct mmc_packed), GFP_KERNEL);
 	if (!mqrq_cur->packed) {
diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
index 872c82a83729..b687a90c4ea1 100644
--- a/drivers/mmc/card/queue.h
+++ b/drivers/mmc/card/queue.h
@@ -59,6 +59,7 @@ struct mmc_queue {
 	struct mmc_queue_req	mqrq[2];
 	struct mmc_queue_req	*mqrq_cur;
 	struct mmc_queue_req	*mqrq_prev;
+	int			qdepth;
 };
 
 extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, spinlock_t *,
-- 
1.9.1

