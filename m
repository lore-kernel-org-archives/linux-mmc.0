From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 4/5] mmc: core: move all quirks together into quirks.h
Date: Wed, 15 Feb 2017 16:35:31 +0800
Message-ID: <1487147732-81724-5-git-send-email-shawn.lin@rock-chips.com>
References: <1487147732-81724-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:45877 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750964AbdBOIiq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2017 03:38:46 -0500
In-Reply-To: <1487147732-81724-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

It's not appreciated to place quirks everywhere, let's
put them together just like what we do for USB, PCI etc.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v3: None
Changes in v2:
- move INAND quirks together

 drivers/mmc/core/block.c  | 80 -----------------------------------------
 drivers/mmc/core/mmc.c    | 11 ------
 drivers/mmc/core/quirks.h | 91 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+), 91 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index ce5e2a2..c5116f4 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -61,12 +61,6 @@
 #endif
 #define MODULE_PARAM_PREFIX "mmcblk."
 
-#define INAND_CMD38_ARG_EXT_CSD  113
-#define INAND_CMD38_ARG_ERASE    0x00
-#define INAND_CMD38_ARG_TRIM     0x01
-#define INAND_CMD38_ARG_SECERASE 0x80
-#define INAND_CMD38_ARG_SECTRIM1 0x81
-#define INAND_CMD38_ARG_SECTRIM2 0x88
 #define MMC_BLK_TIMEOUT_MS  (10 * 60 * 1000)        /* 10 minute timeout */
 #define MMC_SANITIZE_REQ_TIMEOUT 240000
 #define MMC_EXTRACT_INDEX_FROM_ARG(x) ((x & 0x00FF0000) >> 16)
@@ -2108,80 +2102,6 @@ static int mmc_add_disk(struct mmc_blk_data *md)
 	return ret;
 }
 
-static const struct mmc_fixup blk_fixups[] =
-{
-	MMC_FIXUP("SEM02G", CID_MANFID_SANDISK, 0x100, add_quirk,
-		  MMC_QUIRK_INAND_CMD38),
-	MMC_FIXUP("SEM04G", CID_MANFID_SANDISK, 0x100, add_quirk,
-		  MMC_QUIRK_INAND_CMD38),
-	MMC_FIXUP("SEM08G", CID_MANFID_SANDISK, 0x100, add_quirk,
-		  MMC_QUIRK_INAND_CMD38),
-	MMC_FIXUP("SEM16G", CID_MANFID_SANDISK, 0x100, add_quirk,
-		  MMC_QUIRK_INAND_CMD38),
-	MMC_FIXUP("SEM32G", CID_MANFID_SANDISK, 0x100, add_quirk,
-		  MMC_QUIRK_INAND_CMD38),
-
-	/*
-	 * Some MMC cards experience performance degradation with CMD23
-	 * instead of CMD12-bounded multiblock transfers. For now we'll
-	 * black list what's bad...
-	 * - Certain Toshiba cards.
-	 *
-	 * N.B. This doesn't affect SD cards.
-	 */
-	MMC_FIXUP("SDMB-32", CID_MANFID_SANDISK, CID_OEMID_ANY, add_quirk_mmc,
-		  MMC_QUIRK_BLK_NO_CMD23),
-	MMC_FIXUP("SDM032", CID_MANFID_SANDISK, CID_OEMID_ANY, add_quirk_mmc,
-		  MMC_QUIRK_BLK_NO_CMD23),
-	MMC_FIXUP("MMC08G", CID_MANFID_TOSHIBA, CID_OEMID_ANY, add_quirk_mmc,
-		  MMC_QUIRK_BLK_NO_CMD23),
-	MMC_FIXUP("MMC16G", CID_MANFID_TOSHIBA, CID_OEMID_ANY, add_quirk_mmc,
-		  MMC_QUIRK_BLK_NO_CMD23),
-	MMC_FIXUP("MMC32G", CID_MANFID_TOSHIBA, CID_OEMID_ANY, add_quirk_mmc,
-		  MMC_QUIRK_BLK_NO_CMD23),
-
-	/*
-	 * Some MMC cards need longer data read timeout than indicated in CSD.
-	 */
-	MMC_FIXUP(CID_NAME_ANY, CID_MANFID_MICRON, 0x200, add_quirk_mmc,
-		  MMC_QUIRK_LONG_READ_TIME),
-	MMC_FIXUP("008GE0", CID_MANFID_TOSHIBA, CID_OEMID_ANY, add_quirk_mmc,
-		  MMC_QUIRK_LONG_READ_TIME),
-
-	/*
-	 * On these Samsung MoviNAND parts, performing secure erase or
-	 * secure trim can result in unrecoverable corruption due to a
-	 * firmware bug.
-	 */
-	MMC_FIXUP("M8G2FA", CID_MANFID_SAMSUNG, CID_OEMID_ANY, add_quirk_mmc,
-		  MMC_QUIRK_SEC_ERASE_TRIM_BROKEN),
-	MMC_FIXUP("MAG4FA", CID_MANFID_SAMSUNG, CID_OEMID_ANY, add_quirk_mmc,
-		  MMC_QUIRK_SEC_ERASE_TRIM_BROKEN),
-	MMC_FIXUP("MBG8FA", CID_MANFID_SAMSUNG, CID_OEMID_ANY, add_quirk_mmc,
-		  MMC_QUIRK_SEC_ERASE_TRIM_BROKEN),
-	MMC_FIXUP("MCGAFA", CID_MANFID_SAMSUNG, CID_OEMID_ANY, add_quirk_mmc,
-		  MMC_QUIRK_SEC_ERASE_TRIM_BROKEN),
-	MMC_FIXUP("VAL00M", CID_MANFID_SAMSUNG, CID_OEMID_ANY, add_quirk_mmc,
-		  MMC_QUIRK_SEC_ERASE_TRIM_BROKEN),
-	MMC_FIXUP("VYL00M", CID_MANFID_SAMSUNG, CID_OEMID_ANY, add_quirk_mmc,
-		  MMC_QUIRK_SEC_ERASE_TRIM_BROKEN),
-	MMC_FIXUP("KYL00M", CID_MANFID_SAMSUNG, CID_OEMID_ANY, add_quirk_mmc,
-		  MMC_QUIRK_SEC_ERASE_TRIM_BROKEN),
-	MMC_FIXUP("VZL00M", CID_MANFID_SAMSUNG, CID_OEMID_ANY, add_quirk_mmc,
-		  MMC_QUIRK_SEC_ERASE_TRIM_BROKEN),
-
-	/*
-	 *  On Some Kingston eMMCs, performing trim can result in
-	 *  unrecoverable data conrruption occasionally due to a firmware bug.
-	 */
-	MMC_FIXUP("V10008", CID_MANFID_KINGSTON, CID_OEMID_ANY, add_quirk_mmc,
-		  MMC_QUIRK_TRIM_BROKEN),
-	MMC_FIXUP("V10016", CID_MANFID_KINGSTON, CID_OEMID_ANY, add_quirk_mmc,
-		  MMC_QUIRK_TRIM_BROKEN),
-
-	END_FIXUP
-};
-
 static int mmc_blk_probe(struct mmc_card *card)
 {
 	struct mmc_blk_data *md, *part_md;
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index d0e6b6f..721bb01 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -49,17 +49,6 @@
 	35,	40,	45,	50,	55,	60,	70,	80,
 };
 
-static const struct mmc_fixup mmc_ext_csd_fixups[] = {
-	/*
-	 * Certain Hynix eMMC 4.41 cards might get broken when HPI feature
-	 * is used so disable the HPI feature for such buggy cards.
-	 */
-	MMC_FIXUP_EXT_CSD_REV(CID_NAME_ANY, CID_MANFID_HYNIX,
-			      0x014a, add_quirk, MMC_QUIRK_BROKEN_HPI, 5),
-
-	END_FIXUP
-};
-
 #define UNSTUFF_BITS(resp,start,size)					\
 	({								\
 		const int __size = size;				\
diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index f6d7217..7c195e7 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -13,6 +13,97 @@
 
 #include "card.h"
 
+static const struct mmc_fixup blk_fixups[] = {
+#define INAND_CMD38_ARG_EXT_CSD  113
+#define INAND_CMD38_ARG_ERASE    0x00
+#define INAND_CMD38_ARG_TRIM     0x01
+#define INAND_CMD38_ARG_SECERASE 0x80
+#define INAND_CMD38_ARG_SECTRIM1 0x81
+#define INAND_CMD38_ARG_SECTRIM2 0x88
+	/* CMD38 argument is passed through EXT_CSD[113] */
+	MMC_FIXUP("SEM02G", CID_MANFID_SANDISK, 0x100, add_quirk,
+		  MMC_QUIRK_INAND_CMD38),
+	MMC_FIXUP("SEM04G", CID_MANFID_SANDISK, 0x100, add_quirk,
+		  MMC_QUIRK_INAND_CMD38),
+	MMC_FIXUP("SEM08G", CID_MANFID_SANDISK, 0x100, add_quirk,
+		  MMC_QUIRK_INAND_CMD38),
+	MMC_FIXUP("SEM16G", CID_MANFID_SANDISK, 0x100, add_quirk,
+		  MMC_QUIRK_INAND_CMD38),
+	MMC_FIXUP("SEM32G", CID_MANFID_SANDISK, 0x100, add_quirk,
+		  MMC_QUIRK_INAND_CMD38),
+
+	/*
+	 * Some MMC cards experience performance degradation with CMD23
+	 * instead of CMD12-bounded multiblock transfers. For now we'll
+	 * black list what's bad...
+	 * - Certain Toshiba cards.
+	 *
+	 * N.B. This doesn't affect SD cards.
+	 */
+	MMC_FIXUP("SDMB-32", CID_MANFID_SANDISK, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_BLK_NO_CMD23),
+	MMC_FIXUP("SDM032", CID_MANFID_SANDISK, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_BLK_NO_CMD23),
+	MMC_FIXUP("MMC08G", CID_MANFID_TOSHIBA, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_BLK_NO_CMD23),
+	MMC_FIXUP("MMC16G", CID_MANFID_TOSHIBA, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_BLK_NO_CMD23),
+	MMC_FIXUP("MMC32G", CID_MANFID_TOSHIBA, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_BLK_NO_CMD23),
+
+	/*
+	 * Some MMC cards need longer data read timeout than indicated in CSD.
+	 */
+	MMC_FIXUP(CID_NAME_ANY, CID_MANFID_MICRON, 0x200, add_quirk_mmc,
+		  MMC_QUIRK_LONG_READ_TIME),
+	MMC_FIXUP("008GE0", CID_MANFID_TOSHIBA, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_LONG_READ_TIME),
+
+	/*
+	 * On these Samsung MoviNAND parts, performing secure erase or
+	 * secure trim can result in unrecoverable corruption due to a
+	 * firmware bug.
+	 */
+	MMC_FIXUP("M8G2FA", CID_MANFID_SAMSUNG, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_SEC_ERASE_TRIM_BROKEN),
+	MMC_FIXUP("MAG4FA", CID_MANFID_SAMSUNG, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_SEC_ERASE_TRIM_BROKEN),
+	MMC_FIXUP("MBG8FA", CID_MANFID_SAMSUNG, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_SEC_ERASE_TRIM_BROKEN),
+	MMC_FIXUP("MCGAFA", CID_MANFID_SAMSUNG, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_SEC_ERASE_TRIM_BROKEN),
+	MMC_FIXUP("VAL00M", CID_MANFID_SAMSUNG, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_SEC_ERASE_TRIM_BROKEN),
+	MMC_FIXUP("VYL00M", CID_MANFID_SAMSUNG, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_SEC_ERASE_TRIM_BROKEN),
+	MMC_FIXUP("KYL00M", CID_MANFID_SAMSUNG, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_SEC_ERASE_TRIM_BROKEN),
+	MMC_FIXUP("VZL00M", CID_MANFID_SAMSUNG, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_SEC_ERASE_TRIM_BROKEN),
+
+	/*
+	 *  On Some Kingston eMMCs, performing trim can result in
+	 *  unrecoverable data conrruption occasionally due to a firmware bug.
+	 */
+	MMC_FIXUP("V10008", CID_MANFID_KINGSTON, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_TRIM_BROKEN),
+	MMC_FIXUP("V10016", CID_MANFID_KINGSTON, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_TRIM_BROKEN),
+
+	END_FIXUP
+};
+
+static const struct mmc_fixup mmc_ext_csd_fixups[] = {
+	/*
+	 * Certain Hynix eMMC 4.41 cards might get broken when HPI feature
+	 * is used so disable the HPI feature for such buggy cards.
+	 */
+	MMC_FIXUP_EXT_CSD_REV(CID_NAME_ANY, CID_MANFID_HYNIX,
+			      0x014a, add_quirk, MMC_QUIRK_BROKEN_HPI, 5),
+
+	END_FIXUP
+};
+
 static const struct mmc_fixup sdio_fixup_methods[] = {
 	SDIO_FIXUP(SDIO_VENDOR_ID_TI, SDIO_DEVICE_ID_TI_WL1271,
 		   add_quirk, MMC_QUIRK_NONSTD_FUNC_IF),
-- 
1.9.1


