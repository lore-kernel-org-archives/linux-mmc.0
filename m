From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 11/13] mmc: block: Fixup busy detection while invoking stop cmd at recovery
Date: Wed, 29 Jan 2014 23:38:03 +0100
Message-ID: <1391035085-2747-12-git-send-email-ulf.hansson@linaro.org>
References: <1391035085-2747-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:49106 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744AbaA2Wie (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Jan 2014 17:38:34 -0500
Received: by mail-la0-f42.google.com with SMTP id hr13so2017307lab.29
        for <linux-mmc@vger.kernel.org>; Wed, 29 Jan 2014 14:38:33 -0800 (PST)
In-Reply-To: <1391035085-2747-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>
Cc: Dong Aisheng <b29396@freescale.com>, Stephen Warren <swarren@nvidia.com>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>

When sending a stop command at the recovery path, use a R1B response
when the failing data request are a WRITE. Thus we also care about the
busy detection completion in this case.

For a failing READ request, we use a R1 response for the stop command,
since we don't need to care about busy detection in this case.

To align behavior between hosts supporting MMC_CAP_WAIT_WHILE_BUSY and
those who are not, we add a CMD13 polling method for the card's status.

We also respect whether the host has specified the max_busy_timeout,
which means we may fallback to CMD13 polling if the timeout is greater
than what the host are able to support.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/card/block.c |   83 ++++++++++++++++++++++++++++++----------------
 1 file changed, 55 insertions(+), 28 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index fec5e98..17cd0fc 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -722,19 +722,6 @@ static u32 mmc_sd_num_wr_blocks(struct mmc_card *card)
 	return result;
 }
 
-static int send_stop(struct mmc_card *card, u32 *status)
-{
-	struct mmc_command cmd = {0};
-	int err;
-
-	cmd.opcode = MMC_STOP_TRANSMISSION;
-	cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
-	err = mmc_wait_for_cmd(card->host, &cmd, 5);
-	if (err == 0)
-		*status = cmd.resp[0];
-	return err;
-}
-
 static int get_card_status(struct mmc_card *card, u32 *status, int retries)
 {
 	struct mmc_command cmd = {0};
@@ -798,6 +785,51 @@ static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
 	return err;
 }
 
+static int send_stop(struct mmc_card *card, unsigned int timeout_ms,
+		struct request *req, int *gen_err, u32 *stop_status)
+{
+	struct mmc_host *host = card->host;
+	struct mmc_command cmd = {0};
+	int err;
+	bool use_r1b_resp = rq_data_dir(req) == WRITE;
+
+	/*
+	 * Normally we use R1B responses for WRITE, but in cases where the host
+	 * has specified a max_busy_timeout we need to validate it. A failure
+	 * means we need to prevent the host from doing hw busy detection, which
+	 * is done by converting to a R1 response instead.
+	 */
+	if (host->max_busy_timeout && (timeout_ms > host->max_busy_timeout))
+		use_r1b_resp = false;
+
+	cmd.opcode = MMC_STOP_TRANSMISSION;
+	if (use_r1b_resp) {
+		cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
+		cmd.busy_timeout = timeout_ms;
+	} else {
+		cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
+	}
+
+	err = mmc_wait_for_cmd(host, &cmd, 5);
+	if (err)
+		return err;
+
+	*stop_status = cmd.resp[0];
+
+	/* No need to check card status in case of READ. */
+	if (rq_data_dir(req) == READ)
+		return 0;
+
+	if (!mmc_host_is_spi(host) &&
+		(*stop_status & R1_ERROR)) {
+		pr_err("%s: %s: general error sending stop command, resp %#x\n",
+			req->rq_disk->disk_name, __func__, *stop_status);
+		*gen_err = 1;
+	}
+
+	return card_busy_detect(card, timeout_ms, use_r1b_resp, req, gen_err);
+}
+
 #define ERR_NOMEDIUM	3
 #define ERR_RETRY	2
 #define ERR_ABORT	1
@@ -914,26 +946,21 @@ static int mmc_blk_cmd_recovery(struct mmc_card *card, struct request *req,
 	 */
 	if (R1_CURRENT_STATE(status) == R1_STATE_DATA ||
 	    R1_CURRENT_STATE(status) == R1_STATE_RCV) {
-		err = send_stop(card, &stop_status);
-		if (err)
+		err = send_stop(card,
+			DIV_ROUND_UP(brq->data.timeout_ns, 1000000),
+			req, gen_err, &stop_status);
+		if (err) {
 			pr_err("%s: error %d sending stop command\n",
 			       req->rq_disk->disk_name, err);
-
-		/*
-		 * If the stop cmd also timed out, the card is probably
-		 * not present, so abort.  Other errors are bad news too.
-		 */
-		if (err)
+			/*
+			 * If the stop cmd also timed out, the card is probably
+			 * not present, so abort. Other errors are bad news too.
+			 */
 			return ERR_ABORT;
+		}
+
 		if (stop_status & R1_CARD_ECC_FAILED)
 			*ecc_err = 1;
-		if (!mmc_host_is_spi(card->host) && rq_data_dir(req) != READ)
-			if (stop_status & R1_ERROR) {
-				pr_err("%s: %s: general error sending stop command, stop cmd response %#x\n",
-				       req->rq_disk->disk_name, __func__,
-				       stop_status);
-				*gen_err = 1;
-			}
 	}
 
 	/* Check for set block count errors */
-- 
1.7.9.5

