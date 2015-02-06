From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 08/11] mmc: mmc: Add driver strength selection
Date: Fri,  6 Feb 2015 14:12:58 +0200
Message-ID: <1423224781-27076-9-git-send-email-adrian.hunter@intel.com>
References: <1423224781-27076-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:14440 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757414AbbBFMPK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 6 Feb 2015 07:15:10 -0500
In-Reply-To: <1423224781-27076-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Philip Rakity <prakity@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>

Add the ability to set eMMC driver strength
for HS200 and HS400.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/mmc.c  | 45 ++++++++++++++++++++++++++++++++++++++-------
 include/linux/mmc/mmc.h |  3 +++
 2 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 3222d4a..23cc737 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1033,6 +1033,7 @@ static int mmc_select_hs400(struct mmc_card *card)
 {
 	struct mmc_host *host = card->host;
 	int err = 0;
+	u8 val;
 
 	/*
 	 * HS400 mode requires 8-bit bus width
@@ -1048,8 +1049,10 @@ static int mmc_select_hs400(struct mmc_card *card)
 	mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
 	mmc_set_bus_speed(card);
 
+	val = EXT_CSD_TIMING_HS |
+	      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-			   EXT_CSD_HS_TIMING, EXT_CSD_TIMING_HS,
+			   EXT_CSD_HS_TIMING, val,
 			   card->ext_csd.generic_cmd6_time,
 			   true, true, true);
 	if (err) {
@@ -1068,8 +1071,10 @@ static int mmc_select_hs400(struct mmc_card *card)
 		return err;
 	}
 
+	val = EXT_CSD_TIMING_HS400 |
+	      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-			   EXT_CSD_HS_TIMING, EXT_CSD_TIMING_HS400,
+			   EXT_CSD_HS_TIMING, val,
 			   card->ext_csd.generic_cmd6_time,
 			   true, true, true);
 	if (err) {
@@ -1108,6 +1113,7 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 	bool send_status = true;
 	unsigned int max_dtr;
 	int err;
+	u8 val;
 
 	if (host->caps & MMC_CAP_WAIT_WHILE_BUSY)
 		send_status = false;
@@ -1117,8 +1123,10 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 	mmc_set_clock(host, max_dtr);
 
 	/* Switch HS400 to HS DDR */
+	val = EXT_CSD_TIMING_HS |
+	      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
-			   EXT_CSD_TIMING_HS, card->ext_csd.generic_cmd6_time,
+			   val, card->ext_csd.generic_cmd6_time,
 			   true, send_status, true);
 	if (err)
 		goto out_err;
@@ -1147,10 +1155,11 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 	}
 
 	/* Switch HS to HS200 */
+	val = EXT_CSD_TIMING_HS200 |
+	      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
-			   EXT_CSD_TIMING_HS200,
-			   card->ext_csd.generic_cmd6_time, true, send_status,
-			   true);
+			   val, card->ext_csd.generic_cmd6_time, true,
+			   send_status, true);
 	if (err)
 		goto out_err;
 
@@ -1172,6 +1181,23 @@ out_err:
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
 /*
  * For device supporting HS200 mode, the following sequence
  * should be done before executing the tuning process.
@@ -1183,6 +1209,7 @@ static int mmc_select_hs200(struct mmc_card *card)
 {
 	struct mmc_host *host = card->host;
 	int err = -EINVAL;
+	u8 val;
 
 	if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200_1_2V)
 		err = __mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120);
@@ -1194,14 +1221,18 @@ static int mmc_select_hs200(struct mmc_card *card)
 	if (err)
 		goto err;
 
+	mmc_select_driver_type(card);
+
 	/*
 	 * Set the bus width(4 or 8) with host's support and
 	 * switch to HS200 mode if bus width is set successfully.
 	 */
 	err = mmc_select_bus_width(card);
 	if (!IS_ERR_VALUE(err)) {
+		val = EXT_CSD_TIMING_HS200 |
+		      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
 		err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-				   EXT_CSD_HS_TIMING, EXT_CSD_TIMING_HS200,
+				   EXT_CSD_HS_TIMING, val,
 				   card->ext_csd.generic_cmd6_time,
 				   true, true, true);
 		if (!err)
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 4819cfb..15f2c4a 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -391,6 +391,7 @@ struct _mmc_csd {
 #define EXT_CSD_TIMING_HS	1	/* High speed */
 #define EXT_CSD_TIMING_HS200	2	/* HS200 */
 #define EXT_CSD_TIMING_HS400	3	/* HS400 */
+#define EXT_CSD_DRV_STR_SHIFT	4	/* Driver Strength shift */
 
 #define EXT_CSD_SEC_ER_EN	BIT(0)
 #define EXT_CSD_SEC_BD_BLK_EN	BIT(2)
@@ -442,4 +443,6 @@ struct _mmc_csd {
 #define MMC_SWITCH_MODE_CLEAR_BITS	0x02	/* Clear bits which are 1 in value */
 #define MMC_SWITCH_MODE_WRITE_BYTE	0x03	/* Set target to value */
 
+#define mmc_driver_type_mask(n)		(1 << (n))
+
 #endif /* LINUX_MMC_MMC_H */
-- 
1.9.1

