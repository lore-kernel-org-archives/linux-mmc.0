From: Jungseung Lee <js07.lee@samsung.com>
Subject: [PATCH v2] mmc: core: Export device lifetime information through sysf
Date: Fri, 09 Dec 2016 14:53:09 +0900
Message-ID: <20161209055309.10976-1-js07.lee@samsung.com>
References: <CGME20161209055329eucas1p1f0718317b23071fe732cb40ed1c65fd3@eucas1p1.samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:21892 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750944AbcLIFxe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Dec 2016 00:53:34 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, js07.lee@gmail.com
Cc: Jungseung Lee <js07.lee@samsung.com>

In the eMMC 5.0 version of the spec, several EXT_CSD fields about
device lifetime are added.

 - Two types of estimated indications reflected by averaged wear out of memory
 - An indication reflected by average reserved blocks

Export the information through sysfs.

Signed-off-by: Jungseung Lee <js07.lee@samsung.com>
---
 drivers/mmc/core/mmc.c   | 12 ++++++++++++
 include/linux/mmc/card.h |  3 +++
 include/linux/mmc/mmc.h  |  3 +++
 3 files changed, 18 insertions(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index b61b52f9..c0e2507 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -617,6 +617,12 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 		card->ext_csd.ffu_capable =
 			(ext_csd[EXT_CSD_SUPPORTED_MODE] & 0x1) &&
 			!(ext_csd[EXT_CSD_FW_CONFIG] & 0x1);
+
+		card->ext_csd.pre_eol_info = ext_csd[EXT_CSD_PRE_EOL_INFO];
+		card->ext_csd.device_life_time_est_typ_a =
+			ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A];
+		card->ext_csd.device_life_time_est_typ_b =
+			ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B];
 	}
 
 	/* eMMC v5.1 or later */
@@ -764,6 +770,10 @@ MMC_DEV_ATTR(manfid, "0x%06x\n", card->cid.manfid);
 MMC_DEV_ATTR(name, "%s\n", card->cid.prod_name);
 MMC_DEV_ATTR(oemid, "0x%04x\n", card->cid.oemid);
 MMC_DEV_ATTR(prv, "0x%x\n", card->cid.prv);
+MMC_DEV_ATTR(pre_eol_info, "%02x\n", card->ext_csd.pre_eol_info);
+MMC_DEV_ATTR(life_time, "0x%02x 0x%02x\n",
+	card->ext_csd.device_life_time_est_typ_a,
+	card->ext_csd.device_life_time_est_typ_b);
 MMC_DEV_ATTR(serial, "0x%08x\n", card->cid.serial);
 MMC_DEV_ATTR(enhanced_area_offset, "%llu\n",
 		card->ext_csd.enhanced_area_offset);
@@ -817,6 +827,8 @@ static struct attribute *mmc_std_attrs[] = {
 	&dev_attr_name.attr,
 	&dev_attr_oemid.attr,
 	&dev_attr_prv.attr,
+	&dev_attr_pre_eol_info.attr,
+	&dev_attr_life_time.attr,
 	&dev_attr_serial.attr,
 	&dev_attr_enhanced_area_offset.attr,
 	&dev_attr_enhanced_area_size.attr,
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 95d69d4..00449e5 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -121,6 +121,9 @@ struct mmc_ext_csd {
 	u8			raw_pwr_cl_ddr_200_360;	/* 253 */
 	u8			raw_bkops_status;	/* 246 */
 	u8			raw_sectors[4];		/* 212 - 4 bytes */
+	u8			pre_eol_info;		/* 267 */
+	u8			device_life_time_est_typ_a;	/* 268 */
+	u8			device_life_time_est_typ_b;	/* 269 */
 
 	unsigned int            feature_support;
 #define MMC_DISCARD_FEATURE	BIT(0)                  /* CMD38 feature */
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 672730a..a074082 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -339,6 +339,9 @@ struct _mmc_csd {
 #define EXT_CSD_CACHE_SIZE		249	/* RO, 4 bytes */
 #define EXT_CSD_PWR_CL_DDR_200_360	253	/* RO */
 #define EXT_CSD_FIRMWARE_VERSION	254	/* RO, 8 bytes */
+#define EXT_CSD_PRE_EOL_INFO		267	/* RO */
+#define EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A	268	/* RO */
+#define EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B	269	/* RO */
 #define EXT_CSD_CMDQ_DEPTH		307	/* RO */
 #define EXT_CSD_CMDQ_SUPPORT		308	/* RO */
 #define EXT_CSD_SUPPORTED_MODE		493	/* RO */
-- 
2.10.1

