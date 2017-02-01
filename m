From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 04/10] mmc: block: refactor mmc_blk_rw_try_restart()
Date: Wed,  1 Feb 2017 13:47:54 +0100
Message-ID: <20170201124800.13865-5-linus.walleij@linaro.org>
References: <20170201124800.13865-1-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:35819 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750951AbdBAMs6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Feb 2017 07:48:58 -0500
Received: by mail-lf0-f42.google.com with SMTP id n124so227404624lfd.2
        for <linux-mmc@vger.kernel.org>; Wed, 01 Feb 2017 04:48:52 -0800 (PST)
In-Reply-To: <20170201124800.13865-1-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Linus Walleij <linus.walleij@linaro.org>

The mmc_blk_rw_start_new() was named after the label inside
mmc_blk_issue_rw_rq() but is really a confusing name for this
function: what it does is to try to restart the latest issued
command on the host and card of the current MMC queue.

So rename it mmc_blk_rw_try_restart() that reflects what it
is doing and at this point also refactore the function to
treat the removed card as an exception and just exit if this
happens and run on in the function if that is not happening.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/block.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 3246cd396c77..8216ce3874b9 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1603,20 +1603,27 @@ static void mmc_blk_rw_cmd_abort(struct mmc_card *card, struct request *req)
 				      blk_rq_cur_bytes(req));
 }
 
-static void mmc_blk_rw_start_new(struct mmc_queue *mq, struct mmc_card *card,
-				 struct request *req)
+/**
+ * mmc_blk_rw_try_restart() - tries to restart the current async request
+ * @mq: the queue with the card and host to restart
+ * @req: a new request that want to be started after the current one
+ */
+static void mmc_blk_rw_try_restart(struct mmc_queue *mq, struct request *req)
 {
 	if (!req)
 		return;
 
-	if (mmc_card_removed(card)) {
+	/*
+	 * If the card was removed, just cancel everything and return.
+	 */
+	if (mmc_card_removed(mq->card)) {
 		req->rq_flags |= RQF_QUIET;
 		blk_end_request_all(req, -EIO);
-	} else {
-		mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
-		mmc_start_areq(card->host,
-			       &mq->mqrq_cur->mmc_active, NULL);
+		return;
 	}
+	/* Else proceed and try to restart the current async request */
+	mmc_blk_rw_rq_prep(mq->mqrq_cur, mq->card, 0, mq);
+	mmc_start_areq(mq->card->host, &mq->mqrq_cur->mmc_active, NULL);
 }
 
 static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
@@ -1703,11 +1710,11 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 			ret = mmc_blk_cmd_err(md, card, brq, old_req, ret);
 			if (mmc_blk_reset(md, card->host, type)) {
 				mmc_blk_rw_cmd_abort(card, old_req);
-				mmc_blk_rw_start_new(mq, card, new_req);
+				mmc_blk_rw_try_restart(mq, new_req);
 				return;
 			}
 			if (!ret) {
-				mmc_blk_rw_start_new(mq, card, new_req);
+				mmc_blk_rw_try_restart(mq, new_req);
 				return;
 			}
 			break;
@@ -1720,7 +1727,7 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 			if (!mmc_blk_reset(md, card->host, type))
 				break;
 			mmc_blk_rw_cmd_abort(card, old_req);
-			mmc_blk_rw_start_new(mq, card, new_req);
+			mmc_blk_rw_try_restart(mq, new_req);
 			return;
 		case MMC_BLK_DATA_ERR: {
 			int err;
@@ -1730,7 +1737,7 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 				break;
 			if (err == -ENODEV) {
 				mmc_blk_rw_cmd_abort(card, old_req);
-				mmc_blk_rw_start_new(mq, card, new_req);
+				mmc_blk_rw_try_restart(mq, new_req);
 				return;
 			}
 			/* Fall through */
@@ -1751,19 +1758,19 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 			ret = blk_end_request(old_req, -EIO,
 						brq->data.blksz);
 			if (!ret) {
-				mmc_blk_rw_start_new(mq, card, new_req);
+				mmc_blk_rw_try_restart(mq, new_req);
 				return;
 			}
 			break;
 		case MMC_BLK_NOMEDIUM:
 			mmc_blk_rw_cmd_abort(card, old_req);
-			mmc_blk_rw_start_new(mq, card, new_req);
+			mmc_blk_rw_try_restart(mq, new_req);
 			return;
 		default:
 			pr_err("%s: Unhandled return value (%d)",
 					old_req->rq_disk->disk_name, status);
 			mmc_blk_rw_cmd_abort(card, old_req);
-			mmc_blk_rw_start_new(mq, card, new_req);
+			mmc_blk_rw_try_restart(mq, new_req);
 			return;
 		}
 
-- 
2.9.3

