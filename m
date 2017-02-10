From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 01/39] mmc: block: Use local var for mqrq_cur
Date: Fri, 10 Feb 2017 14:55:14 +0200
Message-ID: <1486731352-8018-2-git-send-email-adrian.hunter@intel.com>
References: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:36439 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751305AbdBJN3L (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 10 Feb 2017 08:29:11 -0500
In-Reply-To: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

A subsequent patch will remove 'mq->mqrq_cur'. Prepare for that by
assigning it to a local variable.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/block.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 985477cdcb3e..061133f3b0b2 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1605,7 +1605,8 @@ static void mmc_blk_rw_cmd_abort(struct mmc_card *card, struct request *req)
  * @mq: the queue with the card and host to restart
  * @req: a new request that want to be started after the current one
  */
-static void mmc_blk_rw_try_restart(struct mmc_queue *mq, struct request *req)
+static void mmc_blk_rw_try_restart(struct mmc_queue *mq, struct request *req,
+				   struct mmc_queue_req *mqrq)
 {
 	if (!req)
 		return;
@@ -1619,8 +1620,8 @@ static void mmc_blk_rw_try_restart(struct mmc_queue *mq, struct request *req)
 		return;
 	}
 	/* Else proceed and try to restart the current async request */
-	mmc_blk_rw_rq_prep(mq->mqrq_cur, mq->card, 0, mq);
-	mmc_start_areq(mq->card->host, &mq->mqrq_cur->areq, NULL);
+	mmc_blk_rw_rq_prep(mqrq, mq->card, 0, mq);
+	mmc_start_areq(mq->card->host, &mqrq->areq, NULL);
 }
 
 static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
@@ -1630,6 +1631,7 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 	struct mmc_blk_request *brq;
 	int disable_multi = 0, retry = 0, type, retune_retry_done = 0;
 	enum mmc_blk_status status;
+	struct mmc_queue_req *mqrq_cur = mq->mqrq_cur;
 	struct mmc_queue_req *mq_rq;
 	struct request *old_req;
 	struct mmc_async_req *new_areq;
@@ -1653,8 +1655,8 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 				return;
 			}
 
-			mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
-			new_areq = &mq->mqrq_cur->areq;
+			mmc_blk_rw_rq_prep(mqrq_cur, card, 0, mq);
+			new_areq = &mqrq_cur->areq;
 		} else
 			new_areq = NULL;
 
@@ -1707,11 +1709,11 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 			req_pending = mmc_blk_rw_cmd_err(md, card, brq, old_req, req_pending);
 			if (mmc_blk_reset(md, card->host, type)) {
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
@@ -1724,7 +1726,7 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 			if (!mmc_blk_reset(md, card->host, type))
 				break;
 			mmc_blk_rw_cmd_abort(card, old_req);
-			mmc_blk_rw_try_restart(mq, new_req);
+			mmc_blk_rw_try_restart(mq, new_req, mqrq_cur);
 			return;
 		case MMC_BLK_DATA_ERR: {
 			int err;
@@ -1734,7 +1736,7 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 				break;
 			if (err == -ENODEV) {
 				mmc_blk_rw_cmd_abort(card, old_req);
-				mmc_blk_rw_try_restart(mq, new_req);
+				mmc_blk_rw_try_restart(mq, new_req, mqrq_cur);
 				return;
 			}
 			/* Fall through */
@@ -1755,19 +1757,19 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
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

