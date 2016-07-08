From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V3 08/30] mmc: queue: Factor out mmc_queue_alloc_bounce_sgs()
Date: Fri,  8 Jul 2016 13:22:49 +0300
Message-ID: <1467973391-29221-9-git-send-email-adrian.hunter@intel.com>
References: <1467973391-29221-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:51298 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754329AbcGHK17 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 8 Jul 2016 06:27:59 -0400
In-Reply-To: <1467973391-29221-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

In preparation for supporting a queue of requests, factor out
mmc_queue_alloc_bounce_sgs().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/card/queue.c | 44 ++++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 5e60216ca7d7..9927eda50cbb 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -208,6 +208,30 @@ static bool mmc_queue_alloc_bounce_bufs(struct mmc_queue *mq,
 	return true;
 }
 
+static int mmc_queue_alloc_bounce_sgs(struct mmc_queue *mq,
+				      unsigned int bouncesz)
+{
+	struct mmc_queue_req *mqrq_cur = mq->mqrq_cur;
+	struct mmc_queue_req *mqrq_prev = mq->mqrq_prev;
+	int ret;
+
+	mqrq_cur->sg = mmc_alloc_sg(1, &ret);
+	if (ret)
+		return ret;
+
+	mqrq_cur->bounce_sg = mmc_alloc_sg(bouncesz / 512, &ret);
+	if (ret)
+		return ret;
+
+	mqrq_prev->sg = mmc_alloc_sg(1, &ret);
+	if (ret)
+		return ret;
+
+	mqrq_prev->bounce_sg = mmc_alloc_sg(bouncesz / 512, &ret);
+
+	return ret;
+}
+
 /**
  * mmc_init_queue - initialise a queue structure.
  * @mq: mmc queue
@@ -222,6 +246,7 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 {
 	struct mmc_host *host = card->host;
 	u64 limit = BLK_BOUNCE_HIGH;
+	bool bounce = false;
 	int ret;
 	struct mmc_queue_req *mqrq_cur = &mq->mqrq[0];
 	struct mmc_queue_req *mqrq_prev = &mq->mqrq[1];
@@ -264,28 +289,15 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 			blk_queue_max_segments(mq->queue, bouncesz / 512);
 			blk_queue_max_segment_size(mq->queue, bouncesz);
 
-			mqrq_cur->sg = mmc_alloc_sg(1, &ret);
-			if (ret)
-				goto cleanup_queue;
-
-			mqrq_cur->bounce_sg =
-				mmc_alloc_sg(bouncesz / 512, &ret);
-			if (ret)
-				goto cleanup_queue;
-
-			mqrq_prev->sg = mmc_alloc_sg(1, &ret);
-			if (ret)
-				goto cleanup_queue;
-
-			mqrq_prev->bounce_sg =
-				mmc_alloc_sg(bouncesz / 512, &ret);
+			ret = mmc_queue_alloc_bounce_sgs(mq, bouncesz);
 			if (ret)
 				goto cleanup_queue;
+			bounce = true;
 		}
 	}
 #endif
 
-	if (!mqrq_cur->bounce_buf && !mqrq_prev->bounce_buf) {
+	if (!bounce) {
 		blk_queue_bounce_limit(mq->queue, limit);
 		blk_queue_max_hw_sectors(mq->queue,
 			min(host->max_blk_count, host->max_req_size / 512));
-- 
1.9.1

