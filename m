From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 03/22] mmc: block: Use local var for mqrq_cur
Date: Mon, 13 Mar 2017 14:36:34 +0200
Message-ID: <1489408613-26915-4-git-send-email-adrian.hunter@intel.com>
References: <1489408613-26915-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:50284 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752316AbdCMMmv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 13 Mar 2017 08:42:51 -0400
In-Reply-To: <1489408613-26915-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

A subsequent patch will remove 'mq->mqrq_cur'. Prepare for that by
assigning it to a local variable.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/block.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 05afefcfb611..465c933b45cf 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1600,7 +1600,8 @@ static void mmc_blk_rw_cmd_abort(struct mmc_card *card, struct request *req)
  * @mq: the queue with the card and host to restart
  * @req: a new request that want to be started after the current one
  */
-static void mmc_blk_rw_try_restart(struct mmc_queue *mq, struct request *req)
+static void mmc_blk_rw_try_restart(struct mmc_queue *mq, struct request *req,
+				   struct mmc_queue_req *mqrq)
 {
 	if (!req)
 		return;
@@ -1614,8 +1615,8 @@ static void mmc_blk_rw_try_restart(struct mmc_queue *mq, struct request *req)
 		return;
 	}
 	/* Else proceed and try to restart the current async request */
-	mmc_blk_rw_rq_prep(mq->mqrq_cur, mq->card, 0, mq);
-	mmc_start_areq(mq->card->host, &mq->mqrq_cur->areq, NULL);
+	mmc_blk_rw_rq_prep(mqrq, mq->card, 0, mq);
+	mmc_start_areq(mq->card->host, &mqrq->areq, NULL);
 }
 
 static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
@@ -1625,6 +1626,7 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 	struct mmc_blk_request *brq;
 	int disable_multi = 0, retry = 0, type, retune_retry_done = 0;
 	enum mmc_blk_status status;
+	struct mmc_queue_req *mqrq_cur = mq->mqrq_cur;
 	struct mmc_queue_req *mq_rq;
 	struct request *old_req;
 	struct mmc_async_req *new_areq;
@@ -1648,8 +1650,8 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 				return;
 			}
 
-			mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
-			new_areq = &mq->mqrq_cur->areq;
+			mmc_blk_rw_rq_prep(mqrq_cur, card, 0, mq);
+			new_areq = &mqrq_cur->areq;
 		} else
 			new_areq = NULL;
 
@@ -1703,11 +1705,11 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 			if (mmc_blk_reset(md, card->host, type)) {
 				if (req_pending)
 					mmc_blk_rw_cmd_abort(card, old_req);
-				mmc_blk_rw_try_restart(mq, new_req);
+				mmc_blk_rw_try_restart(mq, new_req, mqrq_cur);
 				return;
 			}
 			if (!req_pending) {
-				mmc_blk_rw_try_restart(mq, new_req);
+				mmc_blk_rw_try_restart(mq, new_req, mqrq_cur);
 				return;
 			}
 			break;
@@ -1720,7 +1722,7 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 			if (!mmc_blk_reset(md, card->host, type))
 				break;
 			mmc_blk_rw_cmd_abort(card, old_req);
-			mmc_blk_rw_try_restart(mq, new_req);
+			mmc_blk_rw_try_restart(mq, new_req, mqrq_cur);
 			return;
 		case MMC_BLK_DATA_ERR: {
 			int err;
@@ -1730,7 +1732,7 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 				break;
 			if (err == -ENODEV) {
 				mmc_blk_rw_cmd_abort(card, old_req);
-				mmc_blk_rw_try_restart(mq, new_req);
+				mmc_blk_rw_try_restart(mq, new_req, mqrq_cur);
 				return;
 			}
 			/* Fall through */
@@ -1751,19 +1753,19 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 			req_pending = blk_end_request(old_req, -EIO,
 						      brq->data.blksz);
 			if (!req_pending) {
-				mmc_blk_rw_try_restart(mq, new_req);
+				mmc_blk_rw_try_restart(mq, new_req, mqrq_cur);
 				return;
 			}
 			break;
 		case MMC_BLK_NOMEDIUM:
 			mmc_blk_rw_cmd_abort(card, old_req);
-			mmc_blk_rw_try_restart(mq, new_req);
+			mmc_blk_rw_try_restart(mq, new_req, mqrq_cur);
 			return;
 		default:
 			pr_err("%s: Unhandled return value (%d)",
 					old_req->rq_disk->disk_name, status);
 			mmc_blk_rw_cmd_abort(card, old_req);
-			mmc_blk_rw_try_restart(mq, new_req);
+			mmc_blk_rw_try_restart(mq, new_req, mqrq_cur);
 			return;
 		}
 
-- 
1.9.1

