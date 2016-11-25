From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V7 06/25] mmc: queue: Introduce queue depth
Date: Fri, 25 Nov 2016 12:07:03 +0200
Message-ID: <1480068442-5169-7-git-send-email-adrian.hunter@intel.com>
References: <1480068442-5169-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:61547 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752737AbcKYKMw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 25 Nov 2016 05:12:52 -0500
In-Reply-To: <1480068442-5169-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

Add a mmc_queue member to record the size of the queue, which currently
supports 2 requests on-the-go at a time.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/card/block.c | 3 +++
 drivers/mmc/card/queue.c | 1 +
 drivers/mmc/card/queue.h | 1 +
 3 files changed, 5 insertions(+)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index f8e51640596e..47835b78872f 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1439,6 +1439,9 @@ static int mmc_packed_init(struct mmc_queue *mq, struct mmc_card *card)
 	struct mmc_queue_req *mqrq_prev = &mq->mqrq[1];
 	int ret = 0;
 
+	/* Queue depth is only ever 2 with packed commands */
+	if (mq->qdepth != 2)
+		return -EINVAL;
 
 	mqrq_cur->packed = kzalloc(sizeof(struct mmc_packed), GFP_KERNEL);
 	if (!mqrq_cur->packed) {
diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index cbe92c9cfda1..60fa095adb14 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -296,6 +296,7 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 	if (!mq->queue)
 		return -ENOMEM;
 
+	mq->qdepth = 2;
 	mq->mqrq_cur = &mq->mqrq[0];
 	mq->mqrq_prev = &mq->mqrq[1];
 	mq->queue->queuedata = mq;
diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
index 0e8133c626c9..8a0a45e5650d 100644
--- a/drivers/mmc/card/queue.h
+++ b/drivers/mmc/card/queue.h
@@ -64,6 +64,7 @@ struct mmc_queue {
 	struct mmc_queue_req	mqrq[2];
 	struct mmc_queue_req	*mqrq_cur;
 	struct mmc_queue_req	*mqrq_prev;
+	int			qdepth;
 };
 
 extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, spinlock_t *,
-- 
1.9.1

