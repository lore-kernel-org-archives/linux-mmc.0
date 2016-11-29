From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V8 15/20] mmc: block: Use local var for mqrq_cur
Date: Tue, 29 Nov 2016 12:09:22 +0200
Message-ID: <1480414167-15577-16-git-send-email-adrian.hunter@intel.com>
References: <1480414167-15577-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:37725 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754234AbcK2KPb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 29 Nov 2016 05:15:31 -0500
In-Reply-To: <1480414167-15577-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

A subsequent patch will remove 'mq->mqrq_cur'. Prepare for that by
assigning it to a local variable.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/card/block.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index e84e2d8f6e31..fdeb3f335fd5 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1630,6 +1630,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 	struct mmc_blk_request *brq;
 	int ret = 1, disable_multi = 0, retry = 0, type, retune_retry_done = 0;
 	enum mmc_blk_status status;
+	struct mmc_queue_req *mqrq_cur = mq->mqrq_cur;
 	struct mmc_queue_req *mq_rq;
 	struct request *req;
 	struct mmc_async_req *areq;
@@ -1647,14 +1648,14 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 				!IS_ALIGNED(blk_rq_sectors(rqc), 8)) {
 				pr_err("%s: Transfer size is not 4KB sector size aligned\n",
 					rqc->rq_disk->disk_name);
-				mq_rq = mq->mqrq_cur;
+				mq_rq = mqrq_cur;
 				req = rqc;
 				rqc = NULL;
 				goto cmd_abort;
 			}
 
-			mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
-			areq = &mq->mqrq_cur->mmc_active;
+			mmc_blk_rw_rq_prep(mqrq_cur, card, 0, mq);
+			areq = &mqrq_cur->mmc_active;
 		} else
 			areq = NULL;
 		areq = mmc_start_req(card->host, areq, &status);
@@ -1774,9 +1775,9 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 			rqc->cmd_flags |= REQ_QUIET;
 			blk_end_request_all(rqc, -EIO);
 		} else {
-			mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
+			mmc_blk_rw_rq_prep(mqrq_cur, card, 0, mq);
 			mmc_start_req(card->host,
-				      &mq->mqrq_cur->mmc_active, NULL);
+				      &mqrq_cur->mmc_active, NULL);
 		}
 	}
 
-- 
1.9.1

