From: Subhash Jadavani <subhashj@codeaurora.org>
Subject: [PATCH v1 1/1] mmc: core: fix power class selection
Date: Tue,  3 Apr 2012 12:25:58 +0530
Message-ID: <1333436158-4762-1-git-send-email-subhashj@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:10562 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825Ab2DCG40 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Apr 2012 02:56:26 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, girish.shivananjappa@linaro.org, Subhash Jadavani <subhashj@codeaurora.org>

mmc_select_powerclass() function returns error if eMMC
VDD level supported by host is between 2.7v to 3.2v.

According to eMMC specification, valid voltage for high
voltage cards is 2.7v to 3.6v. This patch ensures that
2.7v to 3.6v VDD range is treated as valid range.

Also, failure to set the power class shouldn't be treated
as fatal error because even if setting the power class
fails, card can still work in default power class.
If mmc_select_powerclass() returns error, just print
the warning message and go ahead with rest of the card
initialization.

Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
---
 drivers/mmc/core/mmc.c |   30 +++++++++++++++++-------------
 1 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 02914d6..54df5ad 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -695,6 +695,11 @@ static int mmc_select_powerclass(struct mmc_card *card,
 		else if (host->ios.clock <= 200000000)
 			index = EXT_CSD_PWR_CL_200_195;
 		break;
+	case MMC_VDD_27_28:
+	case MMC_VDD_28_29:
+	case MMC_VDD_29_30:
+	case MMC_VDD_30_31:
+	case MMC_VDD_31_32:
 	case MMC_VDD_32_33:
 	case MMC_VDD_33_34:
 	case MMC_VDD_34_35:
@@ -1111,11 +1116,10 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 		ext_csd_bits = (bus_width == MMC_BUS_WIDTH_8) ?
 				EXT_CSD_BUS_WIDTH_8 : EXT_CSD_BUS_WIDTH_4;
 		err = mmc_select_powerclass(card, ext_csd_bits, ext_csd);
-		if (err) {
-			pr_err("%s: power class selection to bus width %d failed\n",
-				mmc_hostname(card->host), 1 << bus_width);
-			goto err;
-		}
+		if (err)
+			pr_warning("%s: power class selection to bus width %d"
+				   " failed\n", mmc_hostname(card->host),
+				   1 << bus_width);
 	}
 
 	/*
@@ -1147,10 +1151,10 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 			err = mmc_select_powerclass(card, ext_csd_bits[idx][0],
 						    ext_csd);
 			if (err)
-				pr_err("%s: power class selection to "
-				       "bus width %d failed\n",
-				       mmc_hostname(card->host),
-				       1 << bus_width);
+				pr_warning("%s: power class selection to "
+					   "bus width %d failed\n",
+					   mmc_hostname(card->host),
+					   1 << bus_width);
 
 			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 					 EXT_CSD_BUS_WIDTH,
@@ -1178,10 +1182,10 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 			err = mmc_select_powerclass(card, ext_csd_bits[idx][1],
 						    ext_csd);
 			if (err)
-				pr_err("%s: power class selection to "
-				       "bus width %d ddr %d failed\n",
-				       mmc_hostname(card->host),
-				       1 << bus_width, ddr);
+				pr_warning("%s: power class selection to "
+					   "bus width %d ddr %d failed\n",
+					   mmc_hostname(card->host),
+					   1 << bus_width, ddr);
 
 			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 					 EXT_CSD_BUS_WIDTH,
-- 
1.7.1.1

--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
