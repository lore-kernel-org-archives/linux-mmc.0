From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 5/6] mmc: block: Fix SD card stop cmd response type
Date: Tue, 23 Sep 2014 23:00:29 +0300
Message-ID: <1411502430-25535-6-git-send-email-adrian.hunter@intel.com>
References: <1411502430-25535-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:41324 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756188AbaIWUCB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 23 Sep 2014 16:02:01 -0400
In-Reply-To: <1411502430-25535-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Nowhere in the SD Association Specifications does
it state that the stop command has an R1 response
type.  It is always R1B.  Change accordingly.

Note that, for SD cards, this puts the situation back
to what it was prior to commit
bcc3e1726d827c2d6f62f0e0e7bbc99eed7ad925.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/card/block.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index c3770dd..0736efb 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -801,6 +801,9 @@ static int send_stop(struct mmc_card *card, unsigned int timeout_ms,
 	if (host->max_busy_timeout && (timeout_ms > host->max_busy_timeout))
 		use_r1b_resp = false;
 
+	if (!mmc_card_mmc(card))
+		use_r1b_resp = true;
+
 	cmd.opcode = MMC_STOP_TRANSMISSION;
 	if (use_r1b_resp) {
 		cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
@@ -1436,9 +1439,14 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 	if (rq_data_dir(req) == READ) {
 		brq->cmd.opcode = readcmd;
 		brq->data.flags |= MMC_DATA_READ;
-		if (brq->mrq.stop)
-			brq->stop.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 |
-					MMC_CMD_AC;
+		if (brq->mrq.stop) {
+			if (mmc_card_mmc(card))
+				brq->stop.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 |
+						  MMC_CMD_AC;
+			else
+				brq->stop.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1B |
+						  MMC_CMD_AC;
+		}
 	} else {
 		brq->cmd.opcode = writecmd;
 		brq->data.flags |= MMC_DATA_WRITE;
-- 
1.8.3.2

