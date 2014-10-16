From: Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2] mmc: core: Report firmware version for eMMC 5.0 devices.
Date: Thu, 16 Oct 2014 11:27:16 -0700
Message-ID: <1413484036-21476-1-git-send-email-gwendal@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yh0-f73.google.com ([209.85.213.73]:57043 "EHLO
	mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752038AbaJPS1V (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Oct 2014 14:27:21 -0400
Received: by mail-yh0-f73.google.com with SMTP id i57so312301yha.4
        for <linux-mmc@vger.kernel.org>; Thu, 16 Oct 2014 11:27:21 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>

For eMMC 5.0 compliant device, firmware version is stored in ext_csd.
Report firmware as a 64bit hexa decimal. Vendor can use hexa or ascii
string to report firmware version.
Also add FFU related EXT_CSD register and note if the device is FFU capable.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/mmc/core/mmc.c   | 27 ++++++++++++++++++++++++++-
 include/linux/mmc/card.h |  3 +++
 include/linux/mmc/mmc.h  |  3 +++
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 1eda8dd..9a7663a 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -603,6 +603,14 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 		card->ext_csd.data_sector_size = 512;
 	}
 
+	/* eMMC v5 or later */
+	if (card->ext_csd.rev >= 7) {
+		memcpy(card->ext_csd.fwrev, &ext_csd[EXT_CSD_FIRMWARE_VERSION],
+		       MMC_FIRMWARE_LEN);
+		card->ext_csd.ffu_capable =
+			(ext_csd[EXT_CSD_SUPPORTED_MODE] & 1) &&
+			!(ext_csd[EXT_CSD_FW_CONFIG] & 1);
+	}
 out:
 	return err;
 }
@@ -697,7 +705,7 @@ MMC_DEV_ATTR(csd, "%08x%08x%08x%08x\n", card->raw_csd[0], card->raw_csd[1],
 MMC_DEV_ATTR(date, "%02d/%04d\n", card->cid.month, card->cid.year);
 MMC_DEV_ATTR(erase_size, "%u\n", card->erase_size << 9);
 MMC_DEV_ATTR(preferred_erase_size, "%u\n", card->pref_erase << 9);
-MMC_DEV_ATTR(fwrev, "0x%x\n", card->cid.fwrev);
+MMC_DEV_ATTR(ffu_capable, "%d\n", card->ext_csd.ffu_capable);
 MMC_DEV_ATTR(hwrev, "0x%x\n", card->cid.hwrev);
 MMC_DEV_ATTR(manfid, "0x%06x\n", card->cid.manfid);
 MMC_DEV_ATTR(name, "%s\n", card->cid.prod_name);
@@ -710,6 +718,22 @@ MMC_DEV_ATTR(enhanced_area_size, "%u\n", card->ext_csd.enhanced_area_size);
 MMC_DEV_ATTR(raw_rpmb_size_mult, "%#x\n", card->ext_csd.raw_rpmb_size_mult);
 MMC_DEV_ATTR(rel_sectors, "%#x\n", card->ext_csd.rel_sectors);
 
+static ssize_t mmc_fwrev_show(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	struct mmc_card *card = mmc_dev_to_card(dev);
+
+	if (card->ext_csd.rev < 7) {
+		return sprintf(buf, "0x%x\n", card->cid.fwrev);
+	} else {
+		return sprintf(buf, "0x%*phN\n", MMC_FIRMWARE_LEN,
+			       card->ext_csd.fwrev);
+	}
+}
+
+static DEVICE_ATTR(fwrev, S_IRUGO, mmc_fwrev_show, NULL);
+
 static struct attribute *mmc_std_attrs[] = {
 	&dev_attr_cid.attr,
 	&dev_attr_csd.attr,
@@ -717,6 +741,7 @@ static struct attribute *mmc_std_attrs[] = {
 	&dev_attr_erase_size.attr,
 	&dev_attr_preferred_erase_size.attr,
 	&dev_attr_fwrev.attr,
+	&dev_attr_ffu_capable.attr,
 	&dev_attr_hwrev.attr,
 	&dev_attr_manfid.attr,
 	&dev_attr_name.attr,
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index d424b9d..14b54ff 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -87,6 +87,9 @@ struct mmc_ext_csd {
 	unsigned int            data_tag_unit_size;     /* DATA TAG UNIT size */
 	unsigned int		boot_ro_lock;		/* ro lock support */
 	bool			boot_ro_lockable;
+	bool			ffu_capable;	/* Firmware upgrade support */
+#define MMC_FIRMWARE_LEN 8
+	u8			fwrev[MMC_FIRMWARE_LEN];  /* FW version */
 	u8			raw_exception_status;	/* 54 */
 	u8			raw_partition_support;	/* 160 */
 	u8			raw_rpmb_size_mult;	/* 168 */
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 64ec963..1af1dff 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -290,6 +290,7 @@ struct _mmc_csd {
 #define EXT_CSD_SANITIZE_START		165     /* W */
 #define EXT_CSD_WR_REL_PARAM		166	/* RO */
 #define EXT_CSD_RPMB_MULT		168	/* RO */
+#define EXT_CSD_FW_CONFIG		169	/* R/W */
 #define EXT_CSD_BOOT_WP			173	/* R/W */
 #define EXT_CSD_ERASE_GROUP_DEF		175	/* R/W */
 #define EXT_CSD_PART_CONFIG		179	/* R/W */
@@ -326,6 +327,8 @@ struct _mmc_csd {
 #define EXT_CSD_GENERIC_CMD6_TIME	248	/* RO */
 #define EXT_CSD_CACHE_SIZE		249	/* RO, 4 bytes */
 #define EXT_CSD_PWR_CL_DDR_200_360	253	/* RO */
+#define EXT_CSD_FIRMWARE_VERSION	254	/* RO, 8 bytes */
+#define EXT_CSD_SUPPORTED_MODE		493	/* RO */
 #define EXT_CSD_TAG_UNIT_SIZE		498	/* RO */
 #define EXT_CSD_DATA_TAG_SUPPORT	499	/* RO */
 #define EXT_CSD_MAX_PACKED_WRITES	500	/* RO */
-- 
2.1.0.rc2.206.gedb03e5

