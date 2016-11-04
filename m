From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/3] mmc: block: convert ecc_err to a bool
Date: Fri,  4 Nov 2016 11:05:18 +0100
Message-ID: <1478253919-2469-3-git-send-email-linus.walleij@linaro.org>
References: <1478253919-2469-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:34605 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761027AbcKDKFb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Nov 2016 06:05:31 -0400
Received: by mail-lf0-f54.google.com with SMTP id b81so59771429lfe.1
        for <linux-mmc@vger.kernel.org>; Fri, 04 Nov 2016 03:05:31 -0700 (PDT)
In-Reply-To: <1478253919-2469-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Linus Walleij <linus.walleij@linaro.org>

The ecc_err flag is only assigned 0 or 1 and treated as a bool,
so convert it to a bool.

Cc: Chunyan Zhang <zhang.chunyan@linaro.org>
Cc: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/card/block.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 54532580ef3d..016cc22f448e 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1013,7 +1013,7 @@ static int mmc_blk_cmd_error(struct request *req, const char *name, int error,
  * Otherwise we don't understand what happened, so abort.
  */
 static int mmc_blk_cmd_recovery(struct mmc_card *card, struct request *req,
-	struct mmc_blk_request *brq, int *ecc_err, bool *gen_err)
+	struct mmc_blk_request *brq, bool *ecc_err, bool *gen_err)
 {
 	bool prev_cmd_status_valid = true;
 	u32 status, stop_status = 0;
@@ -1052,7 +1052,7 @@ static int mmc_blk_cmd_recovery(struct mmc_card *card, struct request *req,
 	if ((status & R1_CARD_ECC_FAILED) ||
 	    (brq->stop.resp[0] & R1_CARD_ECC_FAILED) ||
 	    (brq->cmd.resp[0] & R1_CARD_ECC_FAILED))
-		*ecc_err = 1;
+		*ecc_err = true;
 
 	/* Flag General errors */
 	if (!mmc_host_is_spi(card->host) && rq_data_dir(req) != READ)
@@ -1084,7 +1084,7 @@ static int mmc_blk_cmd_recovery(struct mmc_card *card, struct request *req,
 		}
 
 		if (stop_status & R1_CARD_ECC_FAILED)
-			*ecc_err = 1;
+			*ecc_err = true;
 	}
 
 	/* Check for set block count errors */
@@ -1327,7 +1327,7 @@ static int mmc_blk_err_check(struct mmc_card *card,
 	struct mmc_blk_request *brq = &mq_mrq->brq;
 	struct request *req = mq_mrq->req;
 	int need_retune = card->host->need_retune;
-	int ecc_err = 0;
+	bool ecc_err = false;
 	bool gen_err = false;
 
 	/*
-- 
2.7.4

