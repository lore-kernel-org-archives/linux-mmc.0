From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH] mmc: core: Revert "skip card initialization if power class selection fails"
Date: Mon, 2 Jul 2012 12:26:34 +0530
Message-ID: <1341212194-24650-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50576 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753352Ab2GBG51 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 2 Jul 2012 02:57:27 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, girish.shivananjappa@linaro.org, marvin24@gmx.de, Venkatraman S <svenkatr@ti.com>, Ulf Hansson <ulf.hansson@stericsson.com>, Subhash Jadavani <subhashj@codeaurora.org>, Saugata Das <saugata.das@linaro.org>

This reverts commit 3d93576e(skip card initialization if
power class selection fails).
Problem has been reported when this is used with eMMC4.41
card with Tegra Platform. Till the issue is root caused,
bus width selection failure should not be treated as fatal.

Reported-by: Marc Dietrich <marvin24@gmx.de>
Signed-Off-by: Venkatraman S <svenkatr@ti.com>
CC: Ulf Hansson <ulf.hansson@stericsson.com>
CC: Subhash Jadavani <subhashj@codeaurora.org>
CC: Saugata Das <saugata.das@linaro.org>
---
 drivers/mmc/core/mmc.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 258b203..4f4489a 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -717,10 +717,6 @@ static int mmc_select_powerclass(struct mmc_card *card,
 				 card->ext_csd.generic_cmd6_time);
 	}
 
-	if (err)
-		pr_err("%s: power class selection for ext_csd_bus_width %d"
-		       " failed\n", mmc_hostname(card->host), bus_width);
-
 	return err;
 }
 
@@ -1104,7 +1100,9 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 				EXT_CSD_BUS_WIDTH_8 : EXT_CSD_BUS_WIDTH_4;
 		err = mmc_select_powerclass(card, ext_csd_bits, ext_csd);
 		if (err)
-			goto err;
+			pr_warning("%s: power class selection to bus width %d"
+				   " failed\n", mmc_hostname(card->host),
+				   1 << bus_width);
 	}
 
 	/*
@@ -1136,7 +1134,10 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 			err = mmc_select_powerclass(card, ext_csd_bits[idx][0],
 						    ext_csd);
 			if (err)
-				goto err;
+				pr_warning("%s: power class selection to "
+					   "bus width %d failed\n",
+					   mmc_hostname(card->host),
+					   1 << bus_width);
 
 			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 					 EXT_CSD_BUS_WIDTH,
@@ -1164,7 +1165,10 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 			err = mmc_select_powerclass(card, ext_csd_bits[idx][1],
 						    ext_csd);
 			if (err)
-				goto err;
+				pr_warning("%s: power class selection to "
+					   "bus width %d ddr %d failed\n",
+					   mmc_hostname(card->host),
+					   1 << bus_width, ddr);
 
 			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 					 EXT_CSD_BUS_WIDTH,
-- 
1.7.11.1.25.g0e18bef

