From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 09/13] mmc: block: Implement card_busy_detect() for busy detection
Date: Wed, 29 Jan 2014 23:38:01 +0100
Message-ID: <1391035085-2747-10-git-send-email-ulf.hansson@linaro.org>
References: <1391035085-2747-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:63425 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744AbaA2Wia (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Jan 2014 17:38:30 -0500
Received: by mail-lb0-f173.google.com with SMTP id y6so1951007lbh.4
        for <linux-mmc@vger.kernel.org>; Wed, 29 Jan 2014 14:38:29 -0800 (PST)
In-Reply-To: <1391035085-2747-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>
Cc: Dong Aisheng <b29396@freescale.com>, Stephen Warren <swarren@nvidia.com>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>

To complete a data write request we poll for the card's status register
by sending CMD13. The are other scenarios when this polling method are
needed, which is why we here moves this code to it's own function. No
functional change.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/card/block.c |   82 ++++++++++++++++++++++++++--------------------
 1 file changed, 47 insertions(+), 35 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 87cd2b0..9568999 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -750,6 +750,49 @@ static int get_card_status(struct mmc_card *card, u32 *status, int retries)
 	return err;
 }
 
+static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
+		struct request *req, int *gen_err)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
+	int err = 0;
+	u32 status;
+
+	do {
+		err = get_card_status(card, &status, 5);
+		if (err) {
+			pr_err("%s: error %d requesting status\n",
+			       req->rq_disk->disk_name, err);
+			return err;
+		}
+
+		if (status & R1_ERROR) {
+			pr_err("%s: %s: error sending status cmd, status %#x\n",
+				req->rq_disk->disk_name, __func__, status);
+			*gen_err = 1;
+		}
+
+		/*
+		 * Timeout if the device never becomes ready for data and never
+		 * leaves the program state.
+		 */
+		if (time_after(jiffies, timeout)) {
+			pr_err("%s: Card stuck in programming state! %s %s\n",
+				mmc_hostname(card->host),
+				req->rq_disk->disk_name, __func__);
+			return -ETIMEDOUT;
+		}
+
+		/*
+		 * Some cards mishandle the status bits,
+		 * so make sure to check both the busy
+		 * indication and the card state.
+		 */
+	} while (!(status & R1_READY_FOR_DATA) ||
+		 (R1_CURRENT_STATE(status) == R1_STATE_PRG));
+
+	return err;
+}
+
 #define ERR_NOMEDIUM	3
 #define ERR_RETRY	2
 #define ERR_ABORT	1
@@ -1157,8 +1200,7 @@ static int mmc_blk_err_check(struct mmc_card *card,
 	 * program mode, which we have to wait for it to complete.
 	 */
 	if (!mmc_host_is_spi(card->host) && rq_data_dir(req) != READ) {
-		u32 status;
-		unsigned long timeout;
+		int err;
 
 		/* Check stop command response */
 		if (brq->stop.resp[0] & R1_ERROR) {
@@ -1168,39 +1210,9 @@ static int mmc_blk_err_check(struct mmc_card *card,
 			gen_err = 1;
 		}
 
-		timeout = jiffies + msecs_to_jiffies(MMC_BLK_TIMEOUT_MS);
-		do {
-			int err = get_card_status(card, &status, 5);
-			if (err) {
-				pr_err("%s: error %d requesting status\n",
-				       req->rq_disk->disk_name, err);
-				return MMC_BLK_CMD_ERR;
-			}
-
-			if (status & R1_ERROR) {
-				pr_err("%s: %s: general error sending status command, card status %#x\n",
-				       req->rq_disk->disk_name, __func__,
-				       status);
-				gen_err = 1;
-			}
-
-			/* Timeout if the device never becomes ready for data
-			 * and never leaves the program state.
-			 */
-			if (time_after(jiffies, timeout)) {
-				pr_err("%s: Card stuck in programming state!"\
-					" %s %s\n", mmc_hostname(card->host),
-					req->rq_disk->disk_name, __func__);
-
-				return MMC_BLK_CMD_ERR;
-			}
-			/*
-			 * Some cards mishandle the status bits,
-			 * so make sure to check both the busy
-			 * indication and the card state.
-			 */
-		} while (!(status & R1_READY_FOR_DATA) ||
-			 (R1_CURRENT_STATE(status) == R1_STATE_PRG));
+		err = card_busy_detect(card, MMC_BLK_TIMEOUT_MS, req, &gen_err);
+		if (err)
+			return MMC_BLK_CMD_ERR;
 	}
 
 	/* if general error occurs, retry the write operation. */
-- 
1.7.9.5

