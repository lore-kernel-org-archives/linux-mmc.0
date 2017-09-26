From: Chanho Min <chanho.min@lge.com>
Subject: [PATCH v2] mmc: core: add driver strength selection when selecting hs400es
Date: Tue, 26 Sep 2017 09:03:40 +0900
Message-ID: <1506384220-5108-1-git-send-email-chanho.min@lge.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>, Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Uri Yanai <uri.yanai@sandisk.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Hankyung Yu <hankyung.yu@lge.com>, Gunho Lee <gunho.lee@lge.com>, stable@vger.kernel.org, Chanho Min <chanho.min@lge.com>
List-Id: linux-mmc@vger.kernel.org

The driver strength selection is missed and required when selecting
hs400es. So, It is added here.

v2: add stable tag.

Fixes: 81ac2af65793ecf ("mmc: core: implement enhanced strobe support")
Cc: stable@vger.kernel.org
Signed-off-by: Hankyung Yu <hankyung.yu@lge.com>
Signed-off-by: Chanho Min <chanho.min@lge.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/mmc.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index a7eb623..36217ad 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1286,6 +1286,23 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
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
@@ -1341,6 +1358,8 @@ static int mmc_select_hs400es(struct mmc_card *card)
 		goto out_err;
 	}
 
+	mmc_select_driver_type(card);
+
 	/* Switch card to HS400 */
 	val = EXT_CSD_TIMING_HS400 |
 	      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
@@ -1374,23 +1393,6 @@ static int mmc_select_hs400es(struct mmc_card *card)
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
