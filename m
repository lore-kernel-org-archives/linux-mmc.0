From: Subhash Jadavani <subhashj@codeaurora.org>
Subject: [PATCH v1 1/1] mmc: core: hs200 fixes
Date: Tue,  6 Mar 2012 12:54:55 +0530
Message-ID: <1331018695-13150-1-git-send-email-subhashj@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:52060 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757910Ab2CFHdt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Mar 2012 02:33:49 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, girish.shivananjappa@linaro.org, cjb@laptop.org, Subhash Jadavani <subhashj@codeaurora.org>

This patch fixes following issues when HS200 is enabled:

1. If executing_tuning() host ops is called without mmc_host_clk_hold(),
   card clocks might get turned off (if MMC_CLK_GATING is enabled)
   while execute_tuning() is in progress. So this patch makes sure
   that execute_tuning() is called with mmc_host_clk_hold().

2. If host timing mode is set to HS200 mode, there should not be
   any communication with the card until execute_tuning() is completed.
   But there is a chance that CMD6 might be sent to enable set HPI_EN
   (of HPI_MGMT field in EXT_CSD) before execute_tuning() is called.
   So this patch moves this operation after execute_tuning() is completed.

Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
---
 drivers/mmc/core/mmc.c |   37 ++++++++++++++++++++-----------------
 1 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index a480663..08574ae 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1030,22 +1030,6 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	}
 
 	/*
-	 * Enable HPI feature (if supported)
-	 */
-	if (card->ext_csd.hpi) {
-		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-			EXT_CSD_HPI_MGMT, 1, 0);
-		if (err && err != -EBADMSG)
-			goto free_card;
-		if (err) {
-			pr_warning("%s: Enabling HPI failed\n",
-				   mmc_hostname(card->host));
-			err = 0;
-		} else
-			card->ext_csd.hpi_en = 1;
-	}
-
-	/*
 	 * Compute bus speed.
 	 */
 	max_dtr = (unsigned int)-1;
@@ -1094,9 +1078,12 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 		 * 4. execute tuning for HS200
 		 */
 		if ((host->caps2 & MMC_CAP2_HS200) &&
-		    card->host->ops->execute_tuning)
+		    card->host->ops->execute_tuning) {
+			mmc_host_clk_hold(card->host);
 			err = card->host->ops->execute_tuning(card->host,
 				MMC_SEND_TUNING_BLOCK_HS200);
+			mmc_host_clk_release(card->host);
+		}
 		if (err) {
 			pr_warning("%s: tuning execution failed\n",
 				   mmc_hostname(card->host));
@@ -1216,6 +1203,22 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	}
 
 	/*
+	 * Enable HPI feature (if supported)
+	 */
+	if (card->ext_csd.hpi) {
+		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+			EXT_CSD_HPI_MGMT, 1, 0);
+		if (err && err != -EBADMSG)
+			goto free_card;
+		if (err) {
+			pr_warning("%s: Enabling HPI failed\n",
+				   mmc_hostname(card->host));
+			err = 0;
+		} else
+			card->ext_csd.hpi_en = 1;
+	}
+
+	/*
 	 * If cache size is higher than 0, this indicates
 	 * the existence of cache and it can be turned on.
 	 */
-- 
1.7.1.1

--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

