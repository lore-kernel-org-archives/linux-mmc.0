From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 2/4] mmc: mmc: Fix HS setting in mmc_select_hs400()
Date: Wed, 28 Oct 2015 14:25:41 +0200
Message-ID: <1446035143-4949-3-git-send-email-adrian.hunter@intel.com>
References: <1446035143-4949-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:57266 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932187AbbJ1M3M (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 28 Oct 2015 08:29:12 -0400
In-Reply-To: <1446035143-4949-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chaotian Jing <chaotian.jing@mediatek.com>

mmc_select_hs400() begins with the card and host in HS200 mode.
Therefore, any commands sent to the card should use HS200 timing.
It is incorrect to set the host to High Speed (HS) timing before
sending the switch command.  Doing so is unreliable because
the timing parameters for HS mode are tighter than the timing
parameters for HS200 mode.  Thus the HS timings should be set
only after the card has switched mode.

However, it is not unreasonable first to reduce the frequency to
the HS mode frequency, which should make the switch command and
subsequent CMD13 commands more reliable.

This patch does that.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/mmc.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 2cef40ce9851..14fb767ee8dd 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1043,6 +1043,7 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
 static int mmc_select_hs400(struct mmc_card *card)
 {
 	struct mmc_host *host = card->host;
+	unsigned int max_dtr;
 	int err = 0;
 	u8 val;
 
@@ -1053,13 +1054,11 @@ static int mmc_select_hs400(struct mmc_card *card)
 	      host->ios.bus_width == MMC_BUS_WIDTH_8))
 		return 0;
 
-	/*
-	 * Before switching to dual data rate operation for HS400,
-	 * it is required to convert from HS200 mode to HS mode.
-	 */
-	mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
-	mmc_set_bus_speed(card);
+	/* Reduce frequency to HS frequency */
+	max_dtr = card->ext_csd.hs_max_dtr;
+	mmc_set_clock(host, max_dtr);
 
+	/* Switch card to HS mode */
 	val = EXT_CSD_TIMING_HS |
 	      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
@@ -1072,6 +1071,9 @@ static int mmc_select_hs400(struct mmc_card *card)
 		return err;
 	}
 
+	/* Set host controller to HS timing */
+	mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
+
 	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			 EXT_CSD_BUS_WIDTH,
 			 EXT_CSD_DDR_BUS_WIDTH_8,
-- 
1.9.1

