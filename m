From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/3] mmc: core: use enum mmc_blk_status properly
Date: Fri,  4 Nov 2016 11:05:19 +0100
Message-ID: <1478253919-2469-4-git-send-email-linus.walleij@linaro.org>
References: <1478253919-2469-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:34620 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761072AbcKDKFe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Nov 2016 06:05:34 -0400
Received: by mail-lf0-f51.google.com with SMTP id b81so59772020lfe.1
        for <linux-mmc@vger.kernel.org>; Fri, 04 Nov 2016 03:05:33 -0700 (PDT)
In-Reply-To: <1478253919-2469-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Linus Walleij <linus.walleij@linaro.org>

There were several instances of code using the
enum mmc_blk_status by arbitrarily converting it to an int and
throwing it around to different functions. This makes the code
hard to understand to may give rise to strange errors.

Especially the function prototype mmc_start_req() had to be
modified to take a pointer to an enum mmc_blk_status and the
function pointer .err_check() inside struct mmc_async_req
needed to return an enum mmc_blk_status.

In every case: instead of assigning the block layer error code
to an int, use the enum, also change the signature of all
functions actually passing this enum to use the enum.

To make it possible to use the enum everywhere applicable, move
it to <linux/mmc/core.h> so that all code actually using it can
also see it.

An interesting case was encountered in the MMC test code which
did not return a enum mmc_blk_status at all in the .err_check
function supposed to check whether asynchronous requests worked
or not: instead it returned a normal -ERROR or even the test
frameworks internal error codes.

The test code would also pass on enum mmc_blk_status codes as
error codes inside the test code instead of converting them
to the local RESULT_* codes.

I have tried to fix all instances properly and run some tests
on the result.

Cc: Chunyan Zhang <zhang.chunyan@linaro.org>
Cc: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/card/block.c    | 13 +++++++------
 drivers/mmc/card/mmc_test.c | 44 ++++++++++++++++++++++++++++++++++----------
 drivers/mmc/core/core.c     | 35 ++++++++++++++++++-----------------
 include/linux/mmc/card.h    | 12 ------------
 include/linux/mmc/core.h    | 15 ++++++++++++++-
 include/linux/mmc/host.h    |  2 +-
 6 files changed, 74 insertions(+), 47 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 016cc22f448e..4c397b9684e5 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1319,8 +1319,8 @@ static inline void mmc_apply_rel_rw(struct mmc_blk_request *brq,
 	 R1_CC_ERROR |		/* Card controller error */		\
 	 R1_ERROR)		/* General/unknown error */
 
-static int mmc_blk_err_check(struct mmc_card *card,
-			     struct mmc_async_req *areq)
+static enum mmc_blk_status mmc_blk_err_check(struct mmc_card *card,
+					     struct mmc_async_req *areq)
 {
 	struct mmc_queue_req *mq_mrq = container_of(areq, struct mmc_queue_req,
 						    mmc_active);
@@ -1432,14 +1432,15 @@ static int mmc_blk_err_check(struct mmc_card *card,
 	return MMC_BLK_SUCCESS;
 }
 
-static int mmc_blk_packed_err_check(struct mmc_card *card,
-				    struct mmc_async_req *areq)
+static enum mmc_blk_status mmc_blk_packed_err_check(struct mmc_card *card,
+						    struct mmc_async_req *areq)
 {
 	struct mmc_queue_req *mq_rq = container_of(areq, struct mmc_queue_req,
 			mmc_active);
 	struct request *req = mq_rq->req;
 	struct mmc_packed *packed = mq_rq->packed;
-	int err, check, status;
+	enum mmc_blk_status status, check;
+	int err;
 	u8 *ext_csd;
 
 	packed->retries--;
@@ -1994,7 +1995,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 			areq = &mq->mqrq_cur->mmc_active;
 		} else
 			areq = NULL;
-		areq = mmc_start_req(card->host, areq, (int *) &status);
+		areq = mmc_start_req(card->host, areq, &status);
 		if (!areq) {
 			if (status == MMC_BLK_NEW_REQUEST)
 				mq->flags |= MMC_QUEUE_NEW_REQUEST;
diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
index 5a8dc5a76e0d..010e7d874471 100644
--- a/drivers/mmc/card/mmc_test.c
+++ b/drivers/mmc/card/mmc_test.c
@@ -736,15 +736,28 @@ static int mmc_test_check_result(struct mmc_test_card *test,
 	return ret;
 }
 
-static int mmc_test_check_result_async(struct mmc_card *card,
+static enum mmc_blk_status mmc_test_check_result_async(struct mmc_card *card,
 				       struct mmc_async_req *areq)
 {
 	struct mmc_test_async_req *test_async =
 		container_of(areq, struct mmc_test_async_req, areq);
+	int ret;
 
 	mmc_test_wait_busy(test_async->test);
 
-	return mmc_test_check_result(test_async->test, areq->mrq);
+	/*
+	 * FIXME: this would earlier just casts a regular error code,
+	 * either of the kernel type -ERRORCODE or the local test framework
+	 * RESULT_* errorcode, into an enum mmc_blk_status and return as
+	 * result check. Instead, convert it to some reasonable type by just
+	 * returning either MMC_BLK_SUCCESS or MMC_BLK_CMD_ERR.
+	 * If possible, a reasonable error code should be returned.
+	 */
+	ret = mmc_test_check_result(test_async->test, areq->mrq);
+	if (ret)
+		return MMC_BLK_CMD_ERR;
+
+	return MMC_BLK_SUCCESS;
 }
 
 /*
@@ -817,6 +830,7 @@ static int mmc_test_nonblock_transfer(struct mmc_test_card *test,
 	struct mmc_async_req *done_areq;
 	struct mmc_async_req *cur_areq = &test_areq[0].areq;
 	struct mmc_async_req *other_areq = &test_areq[1].areq;
+	enum mmc_blk_status status;
 	int i;
 	int ret;
 
@@ -834,10 +848,12 @@ static int mmc_test_nonblock_transfer(struct mmc_test_card *test,
 	for (i = 0; i < count; i++) {
 		mmc_test_prepare_mrq(test, cur_areq->mrq, sg, sg_len, dev_addr,
 				     blocks, blksz, write);
-		done_areq = mmc_start_req(test->card->host, cur_areq, &ret);
+		done_areq = mmc_start_req(test->card->host, cur_areq, &status);
 
-		if (ret || (!done_areq && i > 0))
+		if (status != MMC_BLK_SUCCESS || (!done_areq && i > 0)) {
+			ret = RESULT_FAIL;
 			goto err;
+		}
 
 		if (done_areq) {
 			if (done_areq->mrq == &mrq2)
@@ -851,7 +867,9 @@ static int mmc_test_nonblock_transfer(struct mmc_test_card *test,
 		dev_addr += blocks;
 	}
 
-	done_areq = mmc_start_req(test->card->host, NULL, &ret);
+	done_areq = mmc_start_req(test->card->host, NULL, &status);
+	if (status != MMC_BLK_SUCCESS)
+		ret = RESULT_FAIL;
 
 	return ret;
 err:
@@ -2351,6 +2369,7 @@ static int mmc_test_ongoing_transfer(struct mmc_test_card *test,
 	struct mmc_request *mrq;
 	unsigned long timeout;
 	bool expired = false;
+	enum mmc_blk_status blkstat = MMC_BLK_SUCCESS;
 	int ret = 0, cmd_ret;
 	u32 status = 0;
 	int count = 0;
@@ -2378,9 +2397,11 @@ static int mmc_test_ongoing_transfer(struct mmc_test_card *test,
 
 	/* Start ongoing data request */
 	if (use_areq) {
-		mmc_start_req(host, &areq, &ret);
-		if (ret)
+		mmc_start_req(host, &areq, &blkstat);
+		if (blkstat != MMC_BLK_SUCCESS) {
+			ret = RESULT_FAIL;
 			goto out_free;
+		}
 	} else {
 		mmc_wait_for_req(host, mrq);
 	}
@@ -2413,10 +2434,13 @@ static int mmc_test_ongoing_transfer(struct mmc_test_card *test,
 	} while (repeat_cmd && R1_CURRENT_STATE(status) != R1_STATE_TRAN);
 
 	/* Wait for data request to complete */
-	if (use_areq)
-		mmc_start_req(host, NULL, &ret);
-	else
+	if (use_areq) {
+		mmc_start_req(host, NULL, &blkstat);
+		if (blkstat != MMC_BLK_SUCCESS)
+			ret = RESULT_FAIL;
+	} else {
 		mmc_wait_for_req_done(test->card->host, mrq);
+	}
 
 	/*
 	 * For cap_cmd_during_tfr request, upper layer must send stop if
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 2553d903a82b..67e262315a50 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -497,13 +497,13 @@ static int __mmc_start_req(struct mmc_host *host, struct mmc_request *mrq)
  *
  * Returns enum mmc_blk_status after checking errors.
  */
-static int mmc_wait_for_data_req_done(struct mmc_host *host,
+static enum mmc_blk_status mmc_wait_for_data_req_done(struct mmc_host *host,
 				      struct mmc_request *mrq,
 				      struct mmc_async_req *next_req)
 {
 	struct mmc_command *cmd;
 	struct mmc_context_info *context_info = &host->context_info;
-	int err;
+	enum mmc_blk_status status;
 	unsigned long flags;
 
 	while (1) {
@@ -520,9 +520,9 @@ static int mmc_wait_for_data_req_done(struct mmc_host *host,
 
 			if (!cmd->error || !cmd->retries ||
 			    mmc_card_removed(host->card)) {
-				err = host->areq->err_check(host->card,
-							    host->areq);
-				break; /* return err */
+				status = host->areq->err_check(host->card,
+							       host->areq);
+				break; /* return status */
 			} else {
 				mmc_retune_recheck(host);
 				pr_info("%s: req failed (CMD%u): %d, retrying...\n",
@@ -540,7 +540,7 @@ static int mmc_wait_for_data_req_done(struct mmc_host *host,
 		}
 	}
 	mmc_retune_release(host);
-	return err;
+	return status;
 }
 
 void mmc_wait_for_req_done(struct mmc_host *host, struct mmc_request *mrq)
@@ -658,9 +658,10 @@ static void mmc_post_req(struct mmc_host *host, struct mmc_request *mrq,
  *	is returned without waiting. NULL is not an error condition.
  */
 struct mmc_async_req *mmc_start_req(struct mmc_host *host,
-				    struct mmc_async_req *areq, int *error)
+				    struct mmc_async_req *areq,
+				    enum mmc_blk_status *ret_stat)
 {
-	int err = 0;
+	enum mmc_blk_status status = MMC_BLK_SUCCESS;
 	int start_err = 0;
 	struct mmc_async_req *data = host->areq;
 
@@ -669,10 +670,10 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
 		mmc_pre_req(host, areq->mrq, !host->areq);
 
 	if (host->areq) {
-		err = mmc_wait_for_data_req_done(host, host->areq->mrq,	areq);
-		if (err == MMC_BLK_NEW_REQUEST) {
-			if (error)
-				*error = err;
+		status = mmc_wait_for_data_req_done(host, host->areq->mrq, areq);
+		if (status == MMC_BLK_NEW_REQUEST) {
+			if (ret_stat)
+				*ret_stat = status;
 			/*
 			 * The previous request was not completed,
 			 * nothing to return
@@ -699,23 +700,23 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
 		}
 	}
 
-	if (!err && areq)
+	if (status == MMC_BLK_SUCCESS && areq)
 		start_err = __mmc_start_data_req(host, areq->mrq);
 
 	if (host->areq)
 		mmc_post_req(host, host->areq->mrq, 0);
 
 	 /* Cancel a prepared request if it was not started. */
-	if ((err || start_err) && areq)
+	if ((status != MMC_BLK_SUCCESS || start_err) && areq)
 		mmc_post_req(host, areq->mrq, -EINVAL);
 
-	if (err)
+	if (status != MMC_BLK_SUCCESS)
 		host->areq = NULL;
 	else
 		host->areq = areq;
 
-	if (error)
-		*error = err;
+	if (ret_stat)
+		*ret_stat = status;
 	return data;
 }
 EXPORT_SYMBOL(mmc_start_req);
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 73fad83acbcb..e49a3ff9d0e0 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -207,18 +207,6 @@ struct sdio_func_tuple;
 
 #define SDIO_MAX_FUNCS		7
 
-enum mmc_blk_status {
-	MMC_BLK_SUCCESS = 0,
-	MMC_BLK_PARTIAL,
-	MMC_BLK_CMD_ERR,
-	MMC_BLK_RETRY,
-	MMC_BLK_ABORT,
-	MMC_BLK_DATA_ERR,
-	MMC_BLK_ECC_ERR,
-	MMC_BLK_NOMEDIUM,
-	MMC_BLK_NEW_REQUEST,
-};
-
 /* The number of MMC physical partitions.  These consist of:
  * boot partitions (2), general purpose partitions (4) and
  * RPMB partition (1) in MMC v4.4.
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 2b953eb8ceae..0ce928b3ce90 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -15,6 +15,18 @@ struct request;
 struct mmc_data;
 struct mmc_request;
 
+enum mmc_blk_status {
+	MMC_BLK_SUCCESS = 0,
+	MMC_BLK_PARTIAL,
+	MMC_BLK_CMD_ERR,
+	MMC_BLK_RETRY,
+	MMC_BLK_ABORT,
+	MMC_BLK_DATA_ERR,
+	MMC_BLK_ECC_ERR,
+	MMC_BLK_NOMEDIUM,
+	MMC_BLK_NEW_REQUEST,
+};
+
 struct mmc_command {
 	u32			opcode;
 	u32			arg;
@@ -150,7 +162,8 @@ struct mmc_async_req;
 extern int mmc_stop_bkops(struct mmc_card *);
 extern int mmc_read_bkops_status(struct mmc_card *);
 extern struct mmc_async_req *mmc_start_req(struct mmc_host *,
-					   struct mmc_async_req *, int *);
+					   struct mmc_async_req *,
+					   enum mmc_blk_status *);
 extern int mmc_interrupt_hpi(struct mmc_card *);
 extern void mmc_wait_for_req(struct mmc_host *, struct mmc_request *);
 extern void mmc_wait_for_req_done(struct mmc_host *host,
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 0b2439441cc8..5310f94be0ab 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -173,7 +173,7 @@ struct mmc_async_req {
 	 * Check error status of completed mmc request.
 	 * Returns 0 if success otherwise non zero.
 	 */
-	int (*err_check) (struct mmc_card *, struct mmc_async_req *);
+	enum mmc_blk_status (*err_check)(struct mmc_card *, struct mmc_async_req *);
 };
 
 /**
-- 
2.7.4

