From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 07/11] mmc: mmc: Read card's valid driver strength mask
Date: Fri,  6 Feb 2015 14:12:57 +0200
Message-ID: <1423224781-27076-8-git-send-email-adrian.hunter@intel.com>
References: <1423224781-27076-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:51343 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757412AbbBFMPK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 6 Feb 2015 07:15:10 -0500
In-Reply-To: <1423224781-27076-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Philip Rakity <prakity@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>

In preparation for supporing drive strength selection
for eMMC, read the card's valid driver strengths.

Note that though the SD spec uses the term "drive strength",
the JEDEC eMMC spec uses the term "driver strength".

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/mmc.c   | 1 +
 include/linux/mmc/card.h | 1 +
 include/linux/mmc/mmc.h  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 03577be..3222d4a 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -426,6 +426,7 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 	card->ext_csd.raw_trim_mult =
 		ext_csd[EXT_CSD_TRIM_MULT];
 	card->ext_csd.raw_partition_support = ext_csd[EXT_CSD_PARTITION_SUPPORT];
+	card->ext_csd.raw_driver_strength = ext_csd[EXT_CSD_DRIVER_STRENGTH];
 	if (card->ext_csd.rev >= 4) {
 		if (ext_csd[EXT_CSD_PARTITION_SETTING_COMPLETED] &
 		    EXT_CSD_PART_SETTING_COMPLETED)
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index ad54861..ebfb3c9 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -97,6 +97,7 @@ struct mmc_ext_csd {
 	u8			raw_erased_mem_count;	/* 181 */
 	u8			raw_ext_csd_structure;	/* 194 */
 	u8			raw_card_type;		/* 196 */
+	u8			raw_driver_strength;	/* 197 */
 	u8			out_of_int_time;	/* 198 */
 	u8			raw_pwr_cl_52_195;	/* 200 */
 	u8			raw_pwr_cl_26_195;	/* 201 */
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 124f562..4819cfb 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -302,6 +302,7 @@ struct _mmc_csd {
 #define EXT_CSD_REV			192	/* RO */
 #define EXT_CSD_STRUCTURE		194	/* RO */
 #define EXT_CSD_CARD_TYPE		196	/* RO */
+#define EXT_CSD_DRIVER_STRENGTH		197	/* RO */
 #define EXT_CSD_OUT_OF_INTERRUPT_TIME	198	/* RO */
 #define EXT_CSD_PART_SWITCH_TIME        199     /* RO */
 #define EXT_CSD_PWR_CL_52_195		200	/* RO */
-- 
1.9.1

