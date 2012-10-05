From: Balaji T K <balajitk@ti.com>
Subject: [RFT/PATCH] mmc: core: Fix to enable DDR on MMC for non-UHS controllers
Date: Fri, 5 Oct 2012 21:03:40 +0530
Message-ID: <1349451220-24484-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48147 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756606Ab2JEPd5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 5 Oct 2012 11:33:57 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: prakity@marvell.com, Viswanath Puttagunta <vishp@ti.com>, Balaji T K <balajitk@ti.com>

From: Viswanath Puttagunta <vishp@ti.com>

MMC_CAP_UHS_DDR50 is SD card feature and not
eMMC feature. We don't have to check for this flag
to enable DDR on MMC. Checking for MMC_CAP_1_8V_DDR host capability
is sufficient.

This patch is needed for OMAP4 platforms as hsmmc can support DDR
with eMMC but does not support UHS speed mode for SD card.

Signed-off-by: Viswanath Puttagunta <vishp@ti.com>
Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/core/mmc.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 7509de1..9937c91 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1062,14 +1062,12 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	 */
 	if (mmc_card_highspeed(card)) {
 		if ((card->ext_csd.card_type & EXT_CSD_CARD_TYPE_DDR_1_8V)
-			&& ((host->caps & (MMC_CAP_1_8V_DDR |
-			     MMC_CAP_UHS_DDR50))
-				== (MMC_CAP_1_8V_DDR | MMC_CAP_UHS_DDR50)))
+			&& (host->caps & (MMC_CAP_1_8V_DDR |
+			     MMC_CAP_UHS_DDR50)))
 				ddr = MMC_1_8V_DDR_MODE;
 		else if ((card->ext_csd.card_type & EXT_CSD_CARD_TYPE_DDR_1_2V)
-			&& ((host->caps & (MMC_CAP_1_2V_DDR |
-			     MMC_CAP_UHS_DDR50))
-				== (MMC_CAP_1_2V_DDR | MMC_CAP_UHS_DDR50)))
+			&& (host->caps & (MMC_CAP_1_2V_DDR |
+			     MMC_CAP_UHS_DDR50)))
 				ddr = MMC_1_2V_DDR_MODE;
 	}
 
-- 
1.7.5.4

