From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 01/10] mmc: block: inline the command abort and start new goto:s
Date: Wed,  1 Feb 2017 13:47:51 +0100
Message-ID: <20170201124800.13865-2-linus.walleij@linaro.org>
References: <20170201124800.13865-1-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:34775 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750936AbdBAMsj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Feb 2017 07:48:39 -0500
Received: by mail-lf0-f50.google.com with SMTP id v186so227905821lfa.1
        for <linux-mmc@vger.kernel.org>; Wed, 01 Feb 2017 04:48:38 -0800 (PST)
In-Reply-To: <20170201124800.13865-1-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Linus Walleij <linus.walleij@linaro.org>

The goto statements sprinkled over the mmc_blk_issue_rw_rq()
function has grown over the years and makes the code pretty hard
to read.

Inline the calls such that:

goto cmd_abort; ->
mmc_blk_rw_cmd_abort(card, req);
mmc_blk_rw_start_new(mq, card, rqc);
return;

goto start_new_req; ->
mmc_blk_rw_start_new(mq, card, rqc);
return;

After this it is more clear how we exit the do {} while
loop in this function, and it gets possible to split the
code apart.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/block.c | 46 +++++++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 6c8be1a80551..0e23dba62613 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1701,10 +1701,15 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 			break;
 		case MMC_BLK_CMD_ERR:
 			ret = mmc_blk_cmd_err(md, card, brq, req, ret);
-			if (mmc_blk_reset(md, card->host, type))
-				goto cmd_abort;
-			if (!ret)
-				goto start_new_req;
+			if (mmc_blk_reset(md, card->host, type)) {
+				mmc_blk_rw_cmd_abort(card, req);
+				mmc_blk_rw_start_new(mq, card, rqc);
+				return;
+			}
+			if (!ret) {
+				mmc_blk_rw_start_new(mq, card, rqc);
+				return;
+			}
 			break;
 		case MMC_BLK_RETRY:
 			retune_retry_done = brq->retune_retry_done;
@@ -1714,15 +1719,20 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 		case MMC_BLK_ABORT:
 			if (!mmc_blk_reset(md, card->host, type))
 				break;
-			goto cmd_abort;
+			mmc_blk_rw_cmd_abort(card, req);
+			mmc_blk_rw_start_new(mq, card, rqc);
+			return;
 		case MMC_BLK_DATA_ERR: {
 			int err;
 
 			err = mmc_blk_reset(md, card->host, type);
 			if (!err)
 				break;
-			if (err == -ENODEV)
-				goto cmd_abort;
+			if (err == -ENODEV) {
+				mmc_blk_rw_cmd_abort(card, req);
+				mmc_blk_rw_start_new(mq, card, rqc);
+				return;
+			}
 			/* Fall through */
 		}
 		case MMC_BLK_ECC_ERR:
@@ -1740,15 +1750,21 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 			 */
 			ret = blk_end_request(req, -EIO,
 						brq->data.blksz);
-			if (!ret)
-				goto start_new_req;
+			if (!ret) {
+				mmc_blk_rw_start_new(mq, card, rqc);
+				return;
+			}
 			break;
 		case MMC_BLK_NOMEDIUM:
-			goto cmd_abort;
+			mmc_blk_rw_cmd_abort(card, req);
+			mmc_blk_rw_start_new(mq, card, rqc);
+			return;
 		default:
 			pr_err("%s: Unhandled return value (%d)",
 					req->rq_disk->disk_name, status);
-			goto cmd_abort;
+			mmc_blk_rw_cmd_abort(card, req);
+			mmc_blk_rw_start_new(mq, card, rqc);
+			return;
 		}
 
 		if (ret) {
@@ -1763,14 +1779,6 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 			mq_rq->brq.retune_retry_done = retune_retry_done;
 		}
 	} while (ret);
-
-	return;
-
- cmd_abort:
-	mmc_blk_rw_cmd_abort(card, req);
-
- start_new_req:
-	mmc_blk_rw_start_new(mq, card, rqc);
 }
 
 void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
-- 
2.9.3

