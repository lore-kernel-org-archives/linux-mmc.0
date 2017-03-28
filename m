From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/3] mmc: core: refactor asynchronous request finalization
Date: Tue, 28 Mar 2017 10:40:30 +0200
Message-ID: <20170328084031.11995-3-linus.walleij@linaro.org>
References: <20170328084031.11995-1-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:33805 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754673AbdC1Il3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Mar 2017 04:41:29 -0400
Received: by mail-lf0-f51.google.com with SMTP id z15so33934089lfd.1
        for <linux-mmc@vger.kernel.org>; Tue, 28 Mar 2017 01:40:50 -0700 (PDT)
In-Reply-To: <20170328084031.11995-1-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linus Walleij <linus.walleij@linaro.org>

mmc_wait_for_data_req_done() is called in exactly one place,
and having it spread out is making things hard to oversee.
Factor this function into mmc_finalize_areq().

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/core.c | 86 +++++++++++++++++++------------------------------
 1 file changed, 33 insertions(+), 53 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index b8468950e59d..c0b3f80c1f39 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -485,56 +485,6 @@ static int __mmc_start_req(struct mmc_host *host, struct mmc_request *mrq)
 	return err;
 }
 
-/*
- * mmc_wait_for_data_req_done() - wait for request completed
- * @host: MMC host to prepare the command.
- * @mrq: MMC request to wait for
- *
- * Blocks MMC context till host controller will ack end of data request
- * execution or new request notification arrives from the block layer.
- * Handles command retries.
- *
- * Returns enum mmc_blk_status after checking errors.
- */
-static enum mmc_blk_status mmc_wait_for_data_req_done(struct mmc_host *host,
-						      struct mmc_request *mrq)
-{
-	struct mmc_command *cmd;
-	struct mmc_context_info *context_info = &host->context_info;
-	enum mmc_blk_status status;
-
-	while (1) {
-		wait_event_interruptible(context_info->wait,
-				(context_info->is_done_rcv ||
-				 context_info->is_new_req));
-
-		if (context_info->is_done_rcv) {
-			context_info->is_done_rcv = false;
-			cmd = mrq->cmd;
-
-			if (!cmd->error || !cmd->retries ||
-			    mmc_card_removed(host->card)) {
-				status = host->areq->err_check(host->card,
-							       host->areq);
-				break; /* return status */
-			} else {
-				mmc_retune_recheck(host);
-				pr_info("%s: req failed (CMD%u): %d, retrying...\n",
-					mmc_hostname(host),
-					cmd->opcode, cmd->error);
-				cmd->retries--;
-				cmd->error = 0;
-				__mmc_start_request(host, mrq);
-				continue; /* wait for done/new event again */
-			}
-		}
-
-		return MMC_BLK_NEW_REQUEST;
-	}
-	mmc_retune_release(host);
-	return status;
-}
-
 void mmc_wait_for_req_done(struct mmc_host *host, struct mmc_request *mrq)
 {
 	struct mmc_command *cmd;
@@ -639,14 +589,44 @@ static void mmc_post_req(struct mmc_host *host, struct mmc_request *mrq,
  */
 static enum mmc_blk_status mmc_finalize_areq(struct mmc_host *host)
 {
+	struct mmc_context_info *context_info = &host->context_info;
 	enum mmc_blk_status status;
 
 	if (!host->areq)
 		return MMC_BLK_SUCCESS;
 
-	status = mmc_wait_for_data_req_done(host, host->areq->mrq);
-	if (status == MMC_BLK_NEW_REQUEST)
-		return status;
+	while (1) {
+		wait_event_interruptible(context_info->wait,
+				(context_info->is_done_rcv ||
+				 context_info->is_new_req));
+
+		if (context_info->is_done_rcv) {
+			struct mmc_command *cmd;
+
+			context_info->is_done_rcv = false;
+			cmd = host->areq->mrq->cmd;
+
+			if (!cmd->error || !cmd->retries ||
+			    mmc_card_removed(host->card)) {
+				status = host->areq->err_check(host->card,
+							       host->areq);
+				break; /* return status */
+			} else {
+				mmc_retune_recheck(host);
+				pr_info("%s: req failed (CMD%u): %d, retrying...\n",
+					mmc_hostname(host),
+					cmd->opcode, cmd->error);
+				cmd->retries--;
+				cmd->error = 0;
+				__mmc_start_request(host, host->areq->mrq);
+				continue; /* wait for done/new event again */
+			}
+		}
+
+		return MMC_BLK_NEW_REQUEST;
+	}
+
+	mmc_retune_release(host);
 
 	/*
 	 * Check BKOPS urgency for each R1 response
-- 
2.9.3

