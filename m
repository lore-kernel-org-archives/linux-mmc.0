From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 4/5] mmc: core: move all quirks together into quirks.h
Date: Tue,  7 Feb 2017 16:28:28 +0800
Message-ID: <1486456108-106007-1-git-send-email-shawn.lin@rock-chips.com>
References: <1486456043-105954-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:60437 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752323AbdBGIaj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Feb 2017 03:30:39 -0500
In-Reply-To: <1486456043-105954-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

It's appreciated to place quirks everywhere, let's
put them together just like what we do for USB, PCI etc.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/core/block.c  | 74 -----------------------------------------
 drivers/mmc/core/mmc.c    | 11 -------
 drivers/mmc/core/quirks.h | 84 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 84 insertions(+), 85 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index ce5e2a2..0c558f8 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2108,80 +2108,6 @@ static int mmc_add_disk(struct mmc_blk_data *md)
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
index 5f72b99..083dac3 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -17,6 +17,90 @@
 
 #include "card.h"
 
+static const struct mmc_fixup blk_fixups[] = {
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


