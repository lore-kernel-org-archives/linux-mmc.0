From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/3] mmc: block: make gen_err a bool variable
Date: Fri,  4 Nov 2016 11:05:17 +0100
Message-ID: <1478253919-2469-2-git-send-email-linus.walleij@linaro.org>
References: <1478253919-2469-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:35319 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761027AbcKDKFa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Nov 2016 06:05:30 -0400
Received: by mail-lf0-f43.google.com with SMTP id b14so59818810lfg.2
        for <linux-mmc@vger.kernel.org>; Fri, 04 Nov 2016 03:05:29 -0700 (PDT)
In-Reply-To: <1478253919-2469-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Linus Walleij <linus.walleij@linaro.org>

This gen_err flag is only assigned 0 or 1 and treated as a bool,
so convert it to a bool.

Cc: Chunyan Zhang <zhang.chunyan@linaro.org>
Cc: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/card/block.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index c3335112e68c..54532580ef3d 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -853,7 +853,7 @@ static int get_card_status(struct mmc_card *card, u32 *status, int retries)
 }
 
 static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
-		bool hw_busy_detect, struct request *req, int *gen_err)
+		bool hw_busy_detect, struct request *req, bool *gen_err)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
 	int err = 0;
@@ -870,7 +870,7 @@ static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
 		if (status & R1_ERROR) {
 			pr_err("%s: %s: error sending status cmd, status %#x\n",
 				req->rq_disk->disk_name, __func__, status);
-			*gen_err = 1;
+			*gen_err = true;
 		}
 
 		/* We may rely on the host hw to handle busy detection.*/
@@ -901,7 +901,7 @@ static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
 }
 
 static int send_stop(struct mmc_card *card, unsigned int timeout_ms,
-		struct request *req, int *gen_err, u32 *stop_status)
+		struct request *req, bool *gen_err, u32 *stop_status)
 {
 	struct mmc_host *host = card->host;
 	struct mmc_command cmd = {0};
@@ -939,7 +939,7 @@ static int send_stop(struct mmc_card *card, unsigned int timeout_ms,
 		(*stop_status & R1_ERROR)) {
 		pr_err("%s: %s: general error sending stop command, resp %#x\n",
 			req->rq_disk->disk_name, __func__, *stop_status);
-		*gen_err = 1;
+		*gen_err = true;
 	}
 
 	return card_busy_detect(card, timeout_ms, use_r1b_resp, req, gen_err);
@@ -1013,7 +1013,7 @@ static int mmc_blk_cmd_error(struct request *req, const char *name, int error,
  * Otherwise we don't understand what happened, so abort.
  */
 static int mmc_blk_cmd_recovery(struct mmc_card *card, struct request *req,
-	struct mmc_blk_request *brq, int *ecc_err, int *gen_err)
+	struct mmc_blk_request *brq, int *ecc_err, bool *gen_err)
 {
 	bool prev_cmd_status_valid = true;
 	u32 status, stop_status = 0;
@@ -1061,7 +1061,7 @@ static int mmc_blk_cmd_recovery(struct mmc_card *card, struct request *req,
 			pr_err("%s: %s: general error sending stop or status command, stop cmd response %#x, card status %#x\n",
 			       req->rq_disk->disk_name, __func__,
 			       brq->stop.resp[0], status);
-			*gen_err = 1;
+			*gen_err = true;
 		}
 
 	/*
@@ -1327,7 +1327,8 @@ static int mmc_blk_err_check(struct mmc_card *card,
 	struct mmc_blk_request *brq = &mq_mrq->brq;
 	struct request *req = mq_mrq->req;
 	int need_retune = card->host->need_retune;
-	int ecc_err = 0, gen_err = 0;
+	int ecc_err = 0;
+	bool gen_err = false;
 
 	/*
 	 * sbc.error indicates a problem with the set block count
@@ -1377,7 +1378,7 @@ static int mmc_blk_err_check(struct mmc_card *card,
 			pr_err("%s: %s: general error sending stop command, stop cmd response %#x\n",
 			       req->rq_disk->disk_name, __func__,
 			       brq->stop.resp[0]);
-			gen_err = 1;
+			gen_err = true;
 		}
 
 		err = card_busy_detect(card, MMC_BLK_TIMEOUT_MS, false, req,
-- 
2.7.4

