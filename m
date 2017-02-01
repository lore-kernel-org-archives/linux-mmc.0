From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 08/10] mmc: block: respect bool returned from blk_end_request()
Date: Wed,  1 Feb 2017 13:47:58 +0100
Message-ID: <20170201124800.13865-9-linus.walleij@linaro.org>
References: <20170201124800.13865-1-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:33906 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750966AbdBAMtK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Feb 2017 07:49:10 -0500
Received: by mail-lf0-f49.google.com with SMTP id v186so227912612lfa.1
        for <linux-mmc@vger.kernel.org>; Wed, 01 Feb 2017 04:49:09 -0800 (PST)
In-Reply-To: <20170201124800.13865-1-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Linus Walleij <linus.walleij@linaro.org>

The return value from blk_end_request() is a bool but is
treated like an int. This is generally safe, but the variable
also has the opaque name "ret" and gets returned from the
helper function mmc_blk_cmd_err().

- Switch the variable to a bool, applies everywhere.

- Return a bool from mmc_blk_cmd_err() and rename the function
  mmc_blk_rw_cmd_err() to indicate through the namespace that
  this is a helper for mmc_blk_issue_rw_rq().

- Rename the variable from "ret" to "req_pending" inside the
  while() loop inside mmc_blk_issue_rq_rq(), which finally
  makes it very clear what this while loop is waiting for.

- Augment the argument "ret" to mmc_blk_rq_cmd_err() to
  old_req_pending so it becomes evident that this is an
  older state, and it is returned only if we fail to get
  the number of written blocks from an SD card in the
  function mmc_sd_num_wr_blocks().

- Augment the while() loop in mmc_blk_rq_cmd_abort(): it
  is evident now that we know this is a bool variable,
  that the function is just spinning waiting for
  blk_end_request() to return false.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/block.c | 51 ++++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 91d506b37024..92f7772ca56d 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1566,11 +1566,13 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 	mmc_queue_bounce_pre(mqrq);
 }
 
-static int mmc_blk_cmd_err(struct mmc_blk_data *md, struct mmc_card *card,
-			   struct mmc_blk_request *brq, struct request *req,
-			   int ret)
+static bool mmc_blk_rw_cmd_err(struct mmc_blk_data *md, struct mmc_card *card,
+			       struct mmc_blk_request *brq, struct request *req,
+			       bool old_req_pending)
 {
 	struct mmc_queue_req *mq_rq;
+	bool req_pending;
+
 	mq_rq = container_of(brq, struct mmc_queue_req, brq);
 
 	/*
@@ -1586,24 +1588,23 @@ static int mmc_blk_cmd_err(struct mmc_blk_data *md, struct mmc_card *card,
 		int err;
 
 		err = mmc_sd_num_wr_blocks(card, &blocks);
-		if (!err) {
-			ret = blk_end_request(req, 0, blocks << 9);
-		}
+		if (err)
+			req_pending = old_req_pending;
+		else
+			req_pending = blk_end_request(req, 0, blocks << 9);
 	} else {
-		ret = blk_end_request(req, 0, brq->data.bytes_xfered);
+		req_pending = blk_end_request(req, 0, brq->data.bytes_xfered);
 	}
-	return ret;
+	return req_pending;
 }
 
 static void mmc_blk_rw_cmd_abort(struct mmc_card *card, struct request *req)
 {
-	int ret = 1;
-
 	if (mmc_card_removed(card))
 		req->rq_flags |= RQF_QUIET;
-	while (ret)
-		ret = blk_end_request(req, -EIO,
-				      blk_rq_cur_bytes(req));
+	while (blk_end_request(req, -EIO, blk_rq_cur_bytes(req)))
+	{
+	}
 }
 
 /**
@@ -1634,12 +1635,13 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 	struct mmc_blk_data *md = mq->blkdata;
 	struct mmc_card *card = md->queue.card;
 	struct mmc_blk_request *brq;
-	int ret = 1, disable_multi = 0, retry = 0, type, retune_retry_done = 0;
+	int disable_multi = 0, retry = 0, type, retune_retry_done = 0;
 	enum mmc_blk_status status;
 	struct mmc_queue_req *mq_rq;
 	struct request *old_req;
 	struct mmc_async_req *new_areq;
 	struct mmc_async_req *old_areq;
+	bool req_pending = true;
 
 	if (!new_req && !mq->mqrq_prev->req)
 		return;
@@ -1693,15 +1695,14 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 			 */
 			mmc_blk_reset_success(md, type);
 
-			ret = blk_end_request(old_req, 0,
-					brq->data.bytes_xfered);
-
+			req_pending = blk_end_request(old_req, 0,
+						      brq->data.bytes_xfered);
 			/*
 			 * If the blk_end_request function returns non-zero even
 			 * though all data has been transferred and no errors
 			 * were returned by the host controller, it's a bug.
 			 */
-			if (status == MMC_BLK_SUCCESS && ret) {
+			if (status == MMC_BLK_SUCCESS && req_pending) {
 				pr_err("%s BUG rq_tot %d d_xfer %d\n",
 				       __func__, blk_rq_bytes(old_req),
 				       brq->data.bytes_xfered);
@@ -1710,13 +1711,13 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 			}
 			break;
 		case MMC_BLK_CMD_ERR:
-			ret = mmc_blk_cmd_err(md, card, brq, old_req, ret);
+			req_pending = mmc_blk_rw_cmd_err(md, card, brq, old_req, req_pending);
 			if (mmc_blk_reset(md, card->host, type)) {
 				mmc_blk_rw_cmd_abort(card, old_req);
 				mmc_blk_rw_try_restart(mq, new_req);
 				return;
 			}
-			if (!ret) {
+			if (!req_pending) {
 				mmc_blk_rw_try_restart(mq, new_req);
 				return;
 			}
@@ -1758,9 +1759,9 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 			 * time, so we only reach here after trying to
 			 * read a single sector.
 			 */
-			ret = blk_end_request(old_req, -EIO,
-						brq->data.blksz);
-			if (!ret) {
+			req_pending = blk_end_request(old_req, -EIO,
+						      brq->data.blksz);
+			if (!req_pending) {
 				mmc_blk_rw_try_restart(mq, new_req);
 				return;
 			}
@@ -1777,7 +1778,7 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 			return;
 		}
 
-		if (ret) {
+		if (req_pending) {
 			/*
 			 * In case of a incomplete request
 			 * prepare it again and resend.
@@ -1788,7 +1789,7 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 					&mq_rq->areq, NULL);
 			mq_rq->brq.retune_retry_done = retune_retry_done;
 		}
-	} while (ret);
+	} while (req_pending);
 }
 
 void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
-- 
2.9.3

