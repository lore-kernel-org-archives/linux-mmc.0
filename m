From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 1/7] mmc: mmc: Fix incorrect use of driver strength switching HS200 and HS400
Date: Thu, 26 Nov 2015 14:00:44 +0200
Message-ID: <1448539250-18769-2-git-send-email-adrian.hunter@intel.com>
References: <1448539250-18769-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:21455 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751046AbbKZMED (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 26 Nov 2015 07:04:03 -0500
In-Reply-To: <1448539250-18769-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Wenkai Du <wenkai.du@intel.com>

From: Wenkai Du <wenkai.du@intel.com>

Commit cc4f414c885c ("mmc: mmc: Add driver strength selection")
added driver strength selection for eMMC HS200 and HS400 modes.
That patch also set the driver stength when transitioning through
High Speed mode to HS200/HS400, but driver strength is not defined
for High Speed mode.  While the JEDEC specification is not clear
on this point it has been observed to cause problems for some eMMC,
and removing the driver strength setting in this case makes it
consistent with the normal use of High Speed mode.

Signed-off-by: Wenkai Du <wenkai.du@intel.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org # v4.2+
---
 drivers/mmc/core/mmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 66957addf9e4..549c56e8cf6b 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1076,8 +1076,7 @@ static int mmc_select_hs400(struct mmc_card *card)
 	mmc_set_clock(host, max_dtr);
 
 	/* Switch card to HS mode */
-	val = EXT_CSD_TIMING_HS |
-	      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
+	val = EXT_CSD_TIMING_HS;
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			   EXT_CSD_HS_TIMING, val,
 			   card->ext_csd.generic_cmd6_time,
@@ -1160,8 +1159,7 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 	mmc_set_clock(host, max_dtr);
 
 	/* Switch HS400 to HS DDR */
-	val = EXT_CSD_TIMING_HS |
-	      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
+	val = EXT_CSD_TIMING_HS;
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
 			   val, card->ext_csd.generic_cmd6_time,
 			   true, send_status, true);
-- 
1.9.1

