From: Subhash Jadavani <subhashj@codeaurora.org>
Subject: [PATCH v2 1/1] mmc: core: skip card initialization if power class selection fails
Date: Wed, 11 Apr 2012 17:05:22 +0530
Message-ID: <1334144122-20647-1-git-send-email-subhashj@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, Subhash Jadavani <subhashj@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

With current implementation of power class selection,
mmc_select_powerclass() should never fail. So treat any error
returned by this function as serious enough to skip the card
initialization.

Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
---
 drivers/mmc/core/mmc.c |   26 +++++++++++++++-----------
 1 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index f34afbd..5f9d98e 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -722,6 +722,18 @@ static int mmc_select_powerclass(struct mmc_card *card,
 				 card->ext_csd.generic_cmd6_time);
 	}
 
+	if (err) {
+		int width = 4;
+		int ddr = (bus_width <= EXT_CSD_BUS_WIDTH_8) ? 0 : 1;
+
+		if ((bus_width == EXT_CSD_BUS_WIDTH_8) ||
+		    (bus_width == EXT_CSD_DDR_BUS_WIDTH_8))
+			width = 8;
+
+		pr_err("%s: power class selection to bus width %d ddr %d"
+		       " failed\n", mmc_hostname(card->host), width, ddr);
+	}
+
 	return err;
 }
 
@@ -1115,9 +1127,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 				EXT_CSD_BUS_WIDTH_8 : EXT_CSD_BUS_WIDTH_4;
 		err = mmc_select_powerclass(card, ext_csd_bits, ext_csd);
 		if (err)
-			pr_warning("%s: power class selection to bus width %d"
-				   " failed\n", mmc_hostname(card->host),
-				   1 << bus_width);
+			goto err;
 	}
 
 	/*
@@ -1149,10 +1159,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 			err = mmc_select_powerclass(card, ext_csd_bits[idx][0],
 						    ext_csd);
 			if (err)
-				pr_warning("%s: power class selection to "
-					   "bus width %d failed\n",
-					   mmc_hostname(card->host),
-					   1 << bus_width);
+				goto err;
 
 			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 					 EXT_CSD_BUS_WIDTH,
@@ -1180,10 +1187,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 			err = mmc_select_powerclass(card, ext_csd_bits[idx][1],
 						    ext_csd);
 			if (err)
-				pr_warning("%s: power class selection to "
-					   "bus width %d ddr %d failed\n",
-					   mmc_hostname(card->host),
-					   1 << bus_width, ddr);
+				goto err;
 
 			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 					 EXT_CSD_BUS_WIDTH,
-- 
1.7.1.1

--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
