From: Subhash Jadavani <subhashj@codeaurora.org>
Subject: [PATCH v1 1/1] mmc: core: skip card initialization if power class selection fails
Date: Mon,  9 Apr 2012 18:30:19 +0530
Message-ID: <1333976419-2018-1-git-send-email-subhashj@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:21598 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701Ab2DINAa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Apr 2012 09:00:30 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: saugata.das@linaro.org, Subhash Jadavani <subhashj@codeaurora.org>

With current implementation of power class selection,
mmc_select_powerclass() should never fail. So treat any error
returned by this function as serious enough to skip the card
initialization.

Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
---
 drivers/mmc/core/mmc.c |   34 ++++++++++++++++++++--------------
 1 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 54df5ad..d5ff192 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1116,10 +1116,12 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 		ext_csd_bits = (bus_width == MMC_BUS_WIDTH_8) ?
 				EXT_CSD_BUS_WIDTH_8 : EXT_CSD_BUS_WIDTH_4;
 		err = mmc_select_powerclass(card, ext_csd_bits, ext_csd);
-		if (err)
-			pr_warning("%s: power class selection to bus width %d"
-				   " failed\n", mmc_hostname(card->host),
-				   1 << bus_width);
+		if (err) {
+			pr_err("%s: power class selection to bus width %d"
+			       " failed\n", mmc_hostname(card->host),
+			       1 << bus_width);
+			goto err;
+		}
 	}
 
 	/*
@@ -1150,11 +1152,13 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 				ddr = 0; /* no DDR for 1-bit width */
 			err = mmc_select_powerclass(card, ext_csd_bits[idx][0],
 						    ext_csd);
-			if (err)
-				pr_warning("%s: power class selection to "
-					   "bus width %d failed\n",
-					   mmc_hostname(card->host),
-					   1 << bus_width);
+			if (err) {
+				pr_err("%s: power class selection to "
+				       "bus width %d failed\n",
+				       mmc_hostname(card->host),
+				       1 << bus_width);
+				goto err;
+			}
 
 			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 					 EXT_CSD_BUS_WIDTH,
@@ -1181,11 +1185,13 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 		if (!err && ddr) {
 			err = mmc_select_powerclass(card, ext_csd_bits[idx][1],
 						    ext_csd);
-			if (err)
-				pr_warning("%s: power class selection to "
-					   "bus width %d ddr %d failed\n",
-					   mmc_hostname(card->host),
-					   1 << bus_width, ddr);
+			if (err) {
+				pr_err("%s: power class selection to "
+				       "bus width %d ddr %d failed\n",
+				       mmc_hostname(card->host),
+				       1 << bus_width, ddr);
+				goto err;
+			}
 
 			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 					 EXT_CSD_BUS_WIDTH,
-- 
1.7.1.1

--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
