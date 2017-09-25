From: Chanho Min <chanho.min@lge.com>
Subject: [PATCH] mmc: core: add driver strength selection when selecting hs400es
Date: Mon, 25 Sep 2017 17:56:25 +0900
Message-ID: <1506329785-12340-1-git-send-email-chanho.min@lge.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from LGEAMRELO12.lge.com ([156.147.23.52]:50548 "EHLO
        lgeamrelo12.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753788AbdIYI4r (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Sep 2017 04:56:47 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>, Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Uri Yanai <uri.yanai@sandisk.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Hankyung Yu <hankyung.yu@lge.com>, Gunho Lee <gunho.lee@lge.com>, Chanho Min <chanho.min@lge.com>

From: "hankyung.yu" <hankyung.yu@lge.com>

The drive strength setting is missed and required when selecting
hs400es. So, It is added here.

Signed-off-by: Hankyung Yu <hankyung.yu@lge.com>
Signed-off-by: Chanho Min <chanho.min@lge.com>
---
 drivers/mmc/core/mmc.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 07516f3..bc7586c 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1249,6 +1249,23 @@ out_err:
 	return err;
 }
 
+static void mmc_select_driver_type(struct mmc_card *card)
+{
+	int card_drv_type, drive_strength, drv_type;
+
+	card_drv_type = card->ext_csd.raw_driver_strength |
+			mmc_driver_type_mask(0);
+
+	drive_strength = mmc_select_drive_strength(card,
+						   card->ext_csd.hs200_max_dtr,
+						   card_drv_type, &drv_type);
+
+	card->drive_strength = drive_strength;
+
+	if (drv_type)
+		mmc_set_driver_type(card->host, drv_type);
+}
+
 static int mmc_select_hs400es(struct mmc_card *card)
 {
 	struct mmc_host *host = card->host;
@@ -1300,6 +1317,8 @@ static int mmc_select_hs400es(struct mmc_card *card)
 		goto out_err;
 	}
 
+	mmc_select_driver_type(card);
+
 	/* Switch card to HS400 */
 	val = EXT_CSD_TIMING_HS400 |
 	      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
@@ -1333,23 +1352,6 @@ out_err:
 	return err;
 }
 
-static void mmc_select_driver_type(struct mmc_card *card)
-{
-	int card_drv_type, drive_strength, drv_type;
-
-	card_drv_type = card->ext_csd.raw_driver_strength |
-			mmc_driver_type_mask(0);
-
-	drive_strength = mmc_select_drive_strength(card,
-						   card->ext_csd.hs200_max_dtr,
-						   card_drv_type, &drv_type);
-
-	card->drive_strength = drive_strength;
-
-	if (drv_type)
-		mmc_set_driver_type(card->host, drv_type);
-}
-
 /*
  * For device supporting HS200 mode, the following sequence
  * should be done before executing the tuning process.
-- 
2.1.4

