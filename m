From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 45/54] mmc: block: Factor out mmc_blk_requeue()
Date: Wed, 29 Jun 2016 16:24:58 +0300
Message-ID: <1467206707-30185-46-git-send-email-adrian.hunter@intel.com>
References: <1467206707-30185-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:12766 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752549AbcF2Ncm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 29 Jun 2016 09:32:42 -0400
In-Reply-To: <1467206707-30185-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

The same code is used in a couple of places.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/card/block.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index f76716a3acb4..cbac13f9e082 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1317,6 +1317,13 @@ static int mmc_blk_issue_flush(struct mmc_queue *mq, struct request *req)
 	return ret ? 0 : 1;
 }
 
+static void mmc_blk_requeue(struct request_queue *q, struct request *req)
+{
+	spin_lock_irq(q->queue_lock);
+	blk_requeue_request(q, req);
+	spin_unlock_irq(q->queue_lock);
+}
+
 /*
  * Reformat current write as a reliable write, supporting
  * both legacy and the enhanced reliable write MMC cards.
@@ -1776,11 +1783,8 @@ static u8 mmc_blk_prep_packed_list(struct mmc_queue *mq, struct request *req)
 		reqs++;
 	} while (1);
 
-	if (put_back) {
-		spin_lock_irq(q->queue_lock);
-		blk_requeue_request(q, next);
-		spin_unlock_irq(q->queue_lock);
-	}
+	if (put_back)
+		mmc_blk_requeue(q, next);
 
 	if (reqs > 0) {
 		list_add(&req->queuelist, &mqrq->packed->list);
@@ -1967,9 +1971,7 @@ static void mmc_blk_revert_packed_req(struct mmc_queue *mq,
 		prq = list_entry_rq(packed->list.prev);
 		if (prq->queuelist.prev != &packed->list) {
 			list_del_init(&prq->queuelist);
-			spin_lock_irq(q->queue_lock);
-			blk_requeue_request(mq->queue, prq);
-			spin_unlock_irq(q->queue_lock);
+			mmc_blk_requeue(q, prq);
 		} else {
 			list_del_init(&prq->queuelist);
 		}
-- 
1.9.1

