From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 10/10] mmc: core: start to break apart mmc_start_areq()
Date: Wed,  1 Feb 2017 13:48:00 +0100
Message-ID: <20170201124800.13865-11-linus.walleij@linaro.org>
References: <20170201124800.13865-1-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:35998 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750984AbdBAMtQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Feb 2017 07:49:16 -0500
Received: by mail-lf0-f50.google.com with SMTP id z134so227869759lff.3
        for <linux-mmc@vger.kernel.org>; Wed, 01 Feb 2017 04:49:15 -0800 (PST)
In-Reply-To: <20170201124800.13865-1-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Linus Walleij <linus.walleij@linaro.org>

This function is doing to many clever things at the same time under
too many various conditions.

Start to make things clearer by refactoring: break out the
finalization of the previous asynchronous request to its own
function mmc_finalize_areq(). We can get rid of the default
assignment of status and let the call deal with this.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/core.c | 65 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index a160c3a7777a..41b4cd01fccc 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -631,6 +631,37 @@ static void mmc_post_req(struct mmc_host *host, struct mmc_request *mrq,
 }
 
 /**
+ * mmc_finalize_areq() - finalize an asynchronous request
+ * @host: MMC host to finalize any ongoing request on
+ * @ret_stat: the status of the ongoing asynchronous request:
+ *	will return MMC_BLK_SUCCESS if no request was
+ *	going on.
+ */
+static enum mmc_blk_status mmc_finalize_areq(struct mmc_host *host)
+{
+	enum mmc_blk_status status;
+
+	if (!host->areq)
+		return MMC_BLK_SUCCESS;
+
+	status = mmc_wait_for_data_req_done(host, host->areq->mrq);
+	if (status == MMC_BLK_NEW_REQUEST)
+		return status;
+
+	/*
+	 * Check BKOPS urgency for each R1 response
+	 */
+	if (host->card && mmc_card_mmc(host->card) &&
+	    ((mmc_resp_type(host->areq->mrq->cmd) == MMC_RSP_R1) ||
+	     (mmc_resp_type(host->areq->mrq->cmd) == MMC_RSP_R1B)) &&
+	    (host->areq->mrq->cmd->resp[0] & R1_EXCEPTION_EVENT)) {
+		mmc_start_bkops(host->card, true);
+	}
+
+	return status;
+}
+
+/**
  *	mmc_start_areq - start an asynchronous request
  *	@host: MMC host to start command
  *	@areq: asynchronous request to start
@@ -650,7 +681,7 @@ struct mmc_async_req *mmc_start_areq(struct mmc_host *host,
 				     struct mmc_async_req *areq,
 				     enum mmc_blk_status *ret_stat)
 {
-	enum mmc_blk_status status = MMC_BLK_SUCCESS;
+	enum mmc_blk_status status;
 	int start_err = 0;
 	struct mmc_async_req *data = host->areq;
 
@@ -658,35 +689,25 @@ struct mmc_async_req *mmc_start_areq(struct mmc_host *host,
 	if (areq)
 		mmc_pre_req(host, areq->mrq);
 
-	if (host->areq) {
-		status = mmc_wait_for_data_req_done(host, host->areq->mrq);
-		if (status == MMC_BLK_NEW_REQUEST) {
-			if (ret_stat)
-				*ret_stat = status;
-			/*
-			 * The previous request was not completed,
-			 * nothing to return
-			 */
-			return NULL;
-		}
-		/*
-		 * Check BKOPS urgency for each R1 response
-		 */
-		if (host->card && mmc_card_mmc(host->card) &&
-		    ((mmc_resp_type(host->areq->mrq->cmd) == MMC_RSP_R1) ||
-		     (mmc_resp_type(host->areq->mrq->cmd) == MMC_RSP_R1B)) &&
-		    (host->areq->mrq->cmd->resp[0] & R1_EXCEPTION_EVENT)) {
-			mmc_start_bkops(host->card, true);
-		}
+	/* Finalize previous request */
+	status = mmc_finalize_areq(host);
+
+	/* The previous request is still going on... */
+	if (status == MMC_BLK_NEW_REQUEST) {
+		if (ret_stat)
+			*ret_stat = status;
+		return NULL;
 	}
 
+	/* Fine so far, start the new request! */
 	if (status == MMC_BLK_SUCCESS && areq)
 		start_err = __mmc_start_data_req(host, areq->mrq);
 
+	/* Postprocess the old request at this point */
 	if (host->areq)
 		mmc_post_req(host, host->areq->mrq, 0);
 
-	 /* Cancel a prepared request if it was not started. */
+	/* Cancel a prepared request if it was not started. */
 	if ((status != MMC_BLK_SUCCESS || start_err) && areq)
 		mmc_post_req(host, areq->mrq, -EINVAL);
 
-- 
2.9.3

