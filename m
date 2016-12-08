From: Jungseung Lee <js07.lee@samsung.com>
Subject: [PATCH] mmc: core: Export device lifetime information through sysfs
Date: Thu, 08 Dec 2016 19:40:28 +0900
Message-ID: <20161208104028.11816-1-js07.lee@samsung.com>
References: <CGME20161208104055eucas1p1dfc3b9f17f136aa8d099875938722707@eucas1p1.samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39524 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751396AbcLHKlD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Dec 2016 05:41:03 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OHV0017L4C8MY30@mailout1.w1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 08 Dec 2016 10:40:56 +0000 (GMT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org, js07.lee@gmail.com
Cc: Jungseung Lee <js07.lee@samsung.com>

In the eMMC 5.0 version of the spec, several EXT_CSD fields
about device lifetime are added.

 Two type of estimated indications reflected by averaged wear out of memory
 An indication reflected by average reserved blocks

Export the information through sysfs.

Signed-off-by: Jungseung Lee <js07.lee@samsung.com>
---
 drivers/mmc/core/mmc.c   | 12 ++++++++++++
 include/linux/mmc/card.h |  3 +++
 include/linux/mmc/mmc.h  |  3 +++
 3 files changed, 18 insertions(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index df19777..37589eb 100644
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
 out:
 	return err;
@@ -746,6 +752,10 @@ MMC_DEV_ATTR(manfid, "0x%06x\n", card->cid.manfid);
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
@@ -799,6 +809,8 @@ static struct attribute *mmc_std_attrs[] = {
 	&dev_attr_name.attr,
 	&dev_attr_oemid.attr,
 	&dev_attr_prv.attr,
+	&dev_attr_pre_eol_info.attr,
+	&dev_attr_life_time.attr,
 	&dev_attr_serial.attr,
 	&dev_attr_enhanced_area_offset.attr,
 	&dev_attr_enhanced_area_size.attr,
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 73fad83..510a73a 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -119,6 +119,9 @@ struct mmc_ext_csd {
 	u8			raw_pwr_cl_ddr_200_360;	/* 253 */
 	u8			raw_bkops_status;	/* 246 */
 	u8			raw_sectors[4];		/* 212 - 4 bytes */
+	u8			pre_eol_info;		/* 267 */
+	u8			device_life_time_est_typ_a;	/* 268 */
+	u8			device_life_time_est_typ_b;	/* 269 */
 
 	unsigned int            feature_support;
 #define MMC_DISCARD_FEATURE	BIT(0)                  /* CMD38 feature */
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index c376209..a034d07 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -331,6 +331,9 @@ struct _mmc_csd {
 #define EXT_CSD_CACHE_SIZE		249	/* RO, 4 bytes */
 #define EXT_CSD_PWR_CL_DDR_200_360	253	/* RO */
 #define EXT_CSD_FIRMWARE_VERSION	254	/* RO, 8 bytes */
+#define EXT_CSD_PRE_EOL_INFO		267	/* RO */
+#define EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A	268	/* RO */
+#define EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B	269	/* RO */
 #define EXT_CSD_SUPPORTED_MODE		493	/* RO */
 #define EXT_CSD_TAG_UNIT_SIZE		498	/* RO */
 #define EXT_CSD_DATA_TAG_SUPPORT	499	/* RO */
-- 
2.10.1

