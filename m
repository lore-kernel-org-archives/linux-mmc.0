From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V7 17/25] mmc: block: Use local var for mqrq_cur
Date: Fri, 25 Nov 2016 12:07:14 +0200
Message-ID: <1480068442-5169-18-git-send-email-adrian.hunter@intel.com>
References: <1480068442-5169-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:47582 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751917AbcKYKNn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 25 Nov 2016 05:13:43 -0500
In-Reply-To: <1480068442-5169-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

A subsequent patch will remove 'mq->mqrq_cur'. Prepare for that by
assigning it to a local variable.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/card/block.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index f9d2bcf998fb..c1745f2270ba 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -2038,6 +2038,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 	struct mmc_blk_request *brq;
 	int ret = 1, disable_multi = 0, retry = 0, type, retune_retry_done = 0;
 	enum mmc_blk_status status;
+	struct mmc_queue_req *mqrq_cur = mq->mqrq_cur;
 	struct mmc_queue_req *mq_rq;
 	struct request *req;
 	struct mmc_async_req *areq;
@@ -2060,18 +2061,18 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 				!IS_ALIGNED(blk_rq_sectors(rqc), 8)) {
 				pr_err("%s: Transfer size is not 4KB sector size aligned\n",
 					rqc->rq_disk->disk_name);
-				mq_rq = mq->mqrq_cur;
+				mq_rq = mqrq_cur;
 				req = rqc;
 				rqc = NULL;
 				goto cmd_abort;
 			}
 
 			if (reqs >= packed_nr)
-				mmc_blk_packed_hdr_wrq_prep(mq->mqrq_cur,
+				mmc_blk_packed_hdr_wrq_prep(mqrq_cur,
 							    card, mq);
 			else
-				mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
-			areq = &mq->mqrq_cur->mmc_active;
+				mmc_blk_rw_rq_prep(mqrq_cur, card, 0, mq);
+			areq = &mqrq_cur->mmc_active;
 		} else
 			areq = NULL;
 		areq = mmc_start_req(card->host, areq, &status);
@@ -2213,12 +2214,12 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 			/*
 			 * If current request is packed, it needs to put back.
 			 */
-			if (mmc_packed_cmd(mq->mqrq_cur->cmd_type))
-				mmc_blk_revert_packed_req(mq, mq->mqrq_cur);
+			if (mmc_packed_cmd(mqrq_cur->cmd_type))
+				mmc_blk_revert_packed_req(mq, mqrq_cur);
 
-			mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
+			mmc_blk_rw_rq_prep(mqrq_cur, card, 0, mq);
 			mmc_start_req(card->host,
-				      &mq->mqrq_cur->mmc_active, NULL);
+				      &mqrq_cur->mmc_active, NULL);
 		}
 	}
 
-- 
1.9.1

