From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 26/46] mmc: queue: Factor out mmc_queue_alloc_sgs()
Date: Thu,  9 Jun 2016 14:52:26 +0300
Message-ID: <1465473166-22532-27-git-send-email-adrian.hunter@intel.com>
References: <1465473166-22532-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:48207 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751174AbcFIL6c (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 9 Jun 2016 07:58:32 -0400
In-Reply-To: <1465473166-22532-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>

In preparation for supporting a queue of requests, factor out
mmc_queue_alloc_sgs().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/card/queue.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 9927eda50cbb..3c41bc58510b 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -232,6 +232,21 @@ static int mmc_queue_alloc_bounce_sgs(struct mmc_queue *mq,
 	return ret;
 }
 
+static int mmc_queue_alloc_sgs(struct mmc_queue *mq, int max_segs)
+{
+	struct mmc_queue_req *mqrq_cur = mq->mqrq_cur;
+	struct mmc_queue_req *mqrq_prev = mq->mqrq_prev;
+	int ret;
+
+	mqrq_cur->sg = mmc_alloc_sg(max_segs, &ret);
+	if (ret)
+		return ret;
+
+	mqrq_prev->sg = mmc_alloc_sg(max_segs, &ret);
+
+	return ret;
+}
+
 /**
  * mmc_init_queue - initialise a queue structure.
  * @mq: mmc queue
@@ -304,12 +319,7 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 		blk_queue_max_segments(mq->queue, host->max_segs);
 		blk_queue_max_segment_size(mq->queue, host->max_seg_size);
 
-		mqrq_cur->sg = mmc_alloc_sg(host->max_segs, &ret);
-		if (ret)
-			goto cleanup_queue;
-
-
-		mqrq_prev->sg = mmc_alloc_sg(host->max_segs, &ret);
+		ret = mmc_queue_alloc_sgs(mq, host->max_segs);
 		if (ret)
 			goto cleanup_queue;
 	}
-- 
1.9.1

