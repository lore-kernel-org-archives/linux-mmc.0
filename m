From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 03/10] mmc: core: rename mmc_start_req() to *areq()
Date: Wed,  1 Feb 2017 13:47:53 +0100
Message-ID: <20170201124800.13865-4-linus.walleij@linaro.org>
References: <20170201124800.13865-1-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33802 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750942AbdBAMst (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Feb 2017 07:48:49 -0500
Received: by mail-lf0-f54.google.com with SMTP id v186so227908015lfa.1
        for <linux-mmc@vger.kernel.org>; Wed, 01 Feb 2017 04:48:48 -0800 (PST)
In-Reply-To: <20170201124800.13865-1-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Linus Walleij <linus.walleij@linaro.org>

With the coexisting __mmc_start_request(), mmc_start_request()
and __mmc_start_req() it is a bit confusing that mmc_start_req()
actually does not start a normal request, but an asynchronous
request.

Rename it to mmc_start_areq() to make it explicit what the
function is doing, also fix the kerneldoc for this function
while we're at it.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/block.c    |  8 ++++----
 drivers/mmc/core/core.c     | 14 +++++++-------
 drivers/mmc/core/mmc_test.c |  8 ++++----
 include/linux/mmc/core.h    |  2 +-
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index e1479f114247..3246cd396c77 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1614,8 +1614,8 @@ static void mmc_blk_rw_start_new(struct mmc_queue *mq, struct mmc_card *card,
 		blk_end_request_all(req, -EIO);
 	} else {
 		mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
-		mmc_start_req(card->host,
-			      &mq->mqrq_cur->mmc_active, NULL);
+		mmc_start_areq(card->host,
+			       &mq->mqrq_cur->mmc_active, NULL);
 	}
 }
 
@@ -1653,7 +1653,7 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 		} else
 			new_areq = NULL;
 
-		old_areq = mmc_start_req(card->host, new_areq, &status);
+		old_areq = mmc_start_areq(card->host, new_areq, &status);
 		if (!old_areq) {
 			/*
 			 * We have just put the first request into the pipeline
@@ -1774,7 +1774,7 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 			 */
 			mmc_blk_rw_rq_prep(mq_rq, card,
 					disable_multi, mq);
-			mmc_start_req(card->host,
+			mmc_start_areq(card->host,
 					&mq_rq->mmc_active, NULL);
 			mq_rq->brq.retune_retry_done = retune_retry_done;
 		}
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 0faa2ee613be..a160c3a7777a 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -631,10 +631,10 @@ static void mmc_post_req(struct mmc_host *host, struct mmc_request *mrq,
 }
 
 /**
- *	mmc_start_req - start a non-blocking request
+ *	mmc_start_areq - start an asynchronous request
  *	@host: MMC host to start command
- *	@areq: async request to start
- *	@error: out parameter returns 0 for success, otherwise non zero
+ *	@areq: asynchronous request to start
+ *	@ret_stat: out parameter for status
  *
  *	Start a new MMC custom command request for a host.
  *	If there is on ongoing async request wait for completion
@@ -646,9 +646,9 @@ static void mmc_post_req(struct mmc_host *host, struct mmc_request *mrq,
  *	return the completed request. If there is no ongoing request, NULL
  *	is returned without waiting. NULL is not an error condition.
  */
-struct mmc_async_req *mmc_start_req(struct mmc_host *host,
-				    struct mmc_async_req *areq,
-				    enum mmc_blk_status *ret_stat)
+struct mmc_async_req *mmc_start_areq(struct mmc_host *host,
+				     struct mmc_async_req *areq,
+				     enum mmc_blk_status *ret_stat)
 {
 	enum mmc_blk_status status = MMC_BLK_SUCCESS;
 	int start_err = 0;
@@ -699,7 +699,7 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
 		*ret_stat = status;
 	return data;
 }
-EXPORT_SYMBOL(mmc_start_req);
+EXPORT_SYMBOL(mmc_start_areq);
 
 /**
  *	mmc_wait_for_req - start a request and wait for completion
diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index 83d193c09d98..f99ac3123fd2 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -853,7 +853,7 @@ static int mmc_test_nonblock_transfer(struct mmc_test_card *test,
 	for (i = 0; i < count; i++) {
 		mmc_test_prepare_mrq(test, cur_areq->mrq, sg, sg_len, dev_addr,
 				     blocks, blksz, write);
-		done_areq = mmc_start_req(test->card->host, cur_areq, &status);
+		done_areq = mmc_start_areq(test->card->host, cur_areq, &status);
 
 		if (status != MMC_BLK_SUCCESS || (!done_areq && i > 0)) {
 			ret = RESULT_FAIL;
@@ -872,7 +872,7 @@ static int mmc_test_nonblock_transfer(struct mmc_test_card *test,
 		dev_addr += blocks;
 	}
 
-	done_areq = mmc_start_req(test->card->host, NULL, &status);
+	done_areq = mmc_start_areq(test->card->host, NULL, &status);
 	if (status != MMC_BLK_SUCCESS)
 		ret = RESULT_FAIL;
 
@@ -2402,7 +2402,7 @@ static int mmc_test_ongoing_transfer(struct mmc_test_card *test,
 
 	/* Start ongoing data request */
 	if (use_areq) {
-		mmc_start_req(host, &test_areq.areq, &blkstat);
+		mmc_start_areq(host, &test_areq.areq, &blkstat);
 		if (blkstat != MMC_BLK_SUCCESS) {
 			ret = RESULT_FAIL;
 			goto out_free;
@@ -2440,7 +2440,7 @@ static int mmc_test_ongoing_transfer(struct mmc_test_card *test,
 
 	/* Wait for data request to complete */
 	if (use_areq) {
-		mmc_start_req(host, NULL, &blkstat);
+		mmc_start_areq(host, NULL, &blkstat);
 		if (blkstat != MMC_BLK_SUCCESS)
 			ret = RESULT_FAIL;
 	} else {
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 6dcb339fcd45..a0c63ea28796 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -158,7 +158,7 @@ struct mmc_request {
 struct mmc_card;
 struct mmc_async_req;
 
-struct mmc_async_req *mmc_start_req(struct mmc_host *host,
+struct mmc_async_req *mmc_start_areq(struct mmc_host *host,
 				struct mmc_async_req *areq,
 				enum mmc_blk_status *ret_stat);
 void mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq);
-- 
2.9.3

