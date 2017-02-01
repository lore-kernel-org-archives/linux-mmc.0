From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 05/10] mmc: block: rename mmc_active to areq
Date: Wed,  1 Feb 2017 13:47:55 +0100
Message-ID: <20170201124800.13865-6-linus.walleij@linaro.org>
References: <20170201124800.13865-1-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:33844 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbdBAMs6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Feb 2017 07:48:58 -0500
Received: by mail-lf0-f52.google.com with SMTP id v186so227909920lfa.1
        for <linux-mmc@vger.kernel.org>; Wed, 01 Feb 2017 04:48:57 -0800 (PST)
In-Reply-To: <20170201124800.13865-1-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Linus Walleij <linus.walleij@linaro.org>

The mmc_active member of struct mmc_queue_req has a very
confusing name: this is certainly not always "active", it is
the asynchronous request associated by the mmc_queue_req
but it is not guaranteed to be "active" in any sense, such
as being running on the host.

Simply rename this member to "areq".

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/block.c | 14 +++++++-------
 drivers/mmc/core/queue.h |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 8216ce3874b9..7dcc27763381 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1302,7 +1302,7 @@ static enum mmc_blk_status mmc_blk_err_check(struct mmc_card *card,
 					     struct mmc_async_req *areq)
 {
 	struct mmc_queue_req *mq_mrq = container_of(areq, struct mmc_queue_req,
-						    mmc_active);
+						    areq);
 	struct mmc_blk_request *brq = &mq_mrq->brq;
 	struct request *req = mq_mrq->req;
 	int need_retune = card->host->need_retune;
@@ -1558,8 +1558,8 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 		brq->data.sg_len = i;
 	}
 
-	mqrq->mmc_active.mrq = &brq->mrq;
-	mqrq->mmc_active.err_check = mmc_blk_err_check;
+	mqrq->areq.mrq = &brq->mrq;
+	mqrq->areq.err_check = mmc_blk_err_check;
 
 	mmc_queue_bounce_pre(mqrq);
 }
@@ -1623,7 +1623,7 @@ static void mmc_blk_rw_try_restart(struct mmc_queue *mq, struct request *req)
 	}
 	/* Else proceed and try to restart the current async request */
 	mmc_blk_rw_rq_prep(mq->mqrq_cur, mq->card, 0, mq);
-	mmc_start_areq(mq->card->host, &mq->mqrq_cur->mmc_active, NULL);
+	mmc_start_areq(mq->card->host, &mq->mqrq_cur->areq, NULL);
 }
 
 static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
@@ -1656,7 +1656,7 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 			}
 
 			mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
-			new_areq = &mq->mqrq_cur->mmc_active;
+			new_areq = &mq->mqrq_cur->areq;
 		} else
 			new_areq = NULL;
 
@@ -1676,7 +1676,7 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 		 * An asynchronous request has been completed and we proceed
 		 * to handle the result of it.
 		 */
-		mq_rq =	container_of(old_areq, struct mmc_queue_req, mmc_active);
+		mq_rq =	container_of(old_areq, struct mmc_queue_req, areq);
 		brq = &mq_rq->brq;
 		old_req = mq_rq->req;
 		type = rq_data_dir(old_req) == READ ? MMC_BLK_READ : MMC_BLK_WRITE;
@@ -1782,7 +1782,7 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 			mmc_blk_rw_rq_prep(mq_rq, card,
 					disable_multi, mq);
 			mmc_start_areq(card->host,
-					&mq_rq->mmc_active, NULL);
+					&mq_rq->areq, NULL);
 			mq_rq->brq.retune_retry_done = retune_retry_done;
 		}
 	} while (ret);
diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index 0cea02af79d1..e0cd5b1f40ee 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -33,7 +33,7 @@ struct mmc_queue_req {
 	char			*bounce_buf;
 	struct scatterlist	*bounce_sg;
 	unsigned int		bounce_sg_len;
-	struct mmc_async_req	mmc_active;
+	struct mmc_async_req	areq;
 };
 
 struct mmc_queue {
-- 
2.9.3

