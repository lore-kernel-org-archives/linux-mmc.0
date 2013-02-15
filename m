From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: core: remove the duplicate  variable at ext_csd structure
Date: Fri, 15 Feb 2013 22:11:20 +0900
Message-ID: <511E33F8.6090109@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:26115 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936007Ab3BONLU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Feb 2013 08:11:20 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MI9006N6JAMN910@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 15 Feb 2013 22:11:18 +0900 (KST)
Received: from [10.90.51.55] by mmp1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0MI9007A8JAU4Y70@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 15 Feb 2013 22:11:18 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>

Some ext_csd's variable have been defined the unnecessarily.
sec_erase_mult/sec_trim_mult/sec_feature_support would not be changed.
Then we can use the just "_raw_" variable.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/core/core.c  |   14 +++++++-------
 drivers/mmc/core/mmc.c   |    6 ------
 include/linux/mmc/card.h |    3 ---
 3 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 08a3cf2..5385689 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1757,9 +1757,9 @@ static unsigned int mmc_mmc_erase_timeout(struct mmc_card *card,
 	/* Multiplier for secure operations */
 	if (arg & MMC_SECURE_ARGS) {
 		if (arg == MMC_SECURE_ERASE_ARG)
-			erase_timeout *= card->ext_csd.sec_erase_mult;
+			erase_timeout *= card->ext_csd.raw_sec_erase_mult;
 		else
-			erase_timeout *= card->ext_csd.sec_trim_mult;
+			erase_timeout *= card->ext_csd.raw_sec_trim_mult;
 	}
 
 	erase_timeout *= qty;
@@ -1948,11 +1948,11 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
 		return -EOPNOTSUPP;
 
 	if ((arg & MMC_SECURE_ARGS) &&
-	    !(card->ext_csd.sec_feature_support & EXT_CSD_SEC_ER_EN))
+	    !(card->ext_csd.raw_sec_feature_support & EXT_CSD_SEC_ER_EN))
 		return -EOPNOTSUPP;
 
 	if ((arg & MMC_TRIM_ARGS) &&
-	    !(card->ext_csd.sec_feature_support & EXT_CSD_SEC_GB_CL_EN))
+	    !(card->ext_csd.raw_sec_feature_support & EXT_CSD_SEC_GB_CL_EN))
 		return -EOPNOTSUPP;
 
 	if (arg == MMC_SECURE_ERASE_ARG) {
@@ -2001,7 +2001,7 @@ EXPORT_SYMBOL(mmc_can_erase);
 
 int mmc_can_trim(struct mmc_card *card)
 {
-	if (card->ext_csd.sec_feature_support & EXT_CSD_SEC_GB_CL_EN)
+	if (card->ext_csd.raw_sec_feature_support & EXT_CSD_SEC_GB_CL_EN)
 		return 1;
 	return 0;
 }
@@ -2023,7 +2023,7 @@ int mmc_can_sanitize(struct mmc_card *card)
 {
 	if (!mmc_can_trim(card) && !mmc_can_erase(card))
 		return 0;
-	if (card->ext_csd.sec_feature_support & EXT_CSD_SEC_SANITIZE)
+	if (card->ext_csd.raw_sec_feature_support & EXT_CSD_SEC_SANITIZE)
 		return 1;
 	return 0;
 }
@@ -2031,7 +2031,7 @@ EXPORT_SYMBOL(mmc_can_sanitize);
 
 int mmc_can_secure_erase_trim(struct mmc_card *card)
 {
-	if (card->ext_csd.sec_feature_support & EXT_CSD_SEC_ER_EN)
+	if (card->ext_csd.raw_sec_feature_support & EXT_CSD_SEC_ER_EN)
 		return 1;
 	return 0;
 }
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index c8f3d6e..0c66c0c 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -444,12 +444,6 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 					MMC_BLK_DATA_AREA_GP);
 			}
 		}
-		card->ext_csd.sec_trim_mult =
-			ext_csd[EXT_CSD_SEC_TRIM_MULT];
-		card->ext_csd.sec_erase_mult =
-			ext_csd[EXT_CSD_SEC_ERASE_MULT];
-		card->ext_csd.sec_feature_support =
-			ext_csd[EXT_CSD_SEC_FEATURE_SUPPORT];
 		card->ext_csd.trim_timeout = 300 *
 			ext_csd[EXT_CSD_TRIM_MULT];
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 61b2c30..f481983 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -47,7 +47,6 @@ struct mmc_csd {
 struct mmc_ext_csd {
 	u8			rev;
 	u8			erase_group_def;
-	u8			sec_feature_support;
 	u8			rel_sectors;
 	u8			rel_param;
 	u8			part_config;
@@ -70,8 +69,6 @@ struct mmc_ext_csd {
 	unsigned int		card_type;
 	unsigned int		hc_erase_size;		/* In sectors */
 	unsigned int		hc_erase_timeout;	/* In milliseconds */
-	unsigned int		sec_trim_mult;	/* Secure trim multiplier  */
-	unsigned int		sec_erase_mult;	/* Secure erase multiplier */
 	unsigned int		trim_timeout;		/* In milliseconds */
 	bool			enhanced_area_en;	/* enable bit */
 	unsigned long long	enhanced_area_offset;	/* Units: Byte */
-- 
1.7.9.5
