From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v1] mmc: block: skip trim for some kingston eMMCs
Date: Wed, 12 Aug 2015 13:08:32 +0800
Message-ID: <1439356112-10734-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.137]:33182 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753716AbbHLFMs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Aug 2015 01:12:48 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

For some mass production of kingston eMMCs which adopt Phison's
firmware will meet an unrecoverable data conrruption occasionally
if performing trim due to a firmware bug confirmed by vendor. We
found it on Intel-C3230RK platform. So we add fixup of broken trim
for it.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

 drivers/mmc/card/block.c | 11 +++++++++++
 drivers/mmc/core/core.c  |  3 ++-
 include/linux/mmc/card.h |  2 ++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index a58287e..48be57b 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -2389,6 +2389,7 @@ force_ro_fail:
 #define CID_MANFID_TOSHIBA	0x11
 #define CID_MANFID_MICRON	0x13
 #define CID_MANFID_SAMSUNG	0x15
+#define CID_MANFID_KINGSTON	0x70
 
 static const struct mmc_fixup blk_fixups[] =
 {
@@ -2422,6 +2423,7 @@ static const struct mmc_fixup blk_fixups[] =
 	MMC_FIXUP("MMC32G", CID_MANFID_TOSHIBA, CID_OEMID_ANY, add_quirk_mmc,
 		  MMC_QUIRK_BLK_NO_CMD23),
 
+
 	/*
 	 * Some Micron MMC cards needs longer data read timeout than
 	 * indicated in CSD.
@@ -2451,6 +2453,15 @@ static const struct mmc_fixup blk_fixups[] =
 	MMC_FIXUP("VZL00M", CID_MANFID_SAMSUNG, CID_OEMID_ANY, add_quirk_mmc,
 		  MMC_QUIRK_SEC_ERASE_TRIM_BROKEN),
 
+	/*
+	 *  On Some Kingston eMMCs, performing trim can result in
+	 *  unrecoverable data conrruption occasionally due to a firmware bug.
+	 */
+	MMC_FIXUP("V10008", CID_MANFID_KINGSTON, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_TRIM_BROKEN),
+	MMC_FIXUP("V10016", CID_MANFID_KINGSTON, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_TRIM_BROKEN),
+
 	END_FIXUP
 };
 
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 083cade..8bbcc42 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2251,7 +2251,8 @@ EXPORT_SYMBOL(mmc_can_erase);
 
 int mmc_can_trim(struct mmc_card *card)
 {
-	if (card->ext_csd.sec_feature_support & EXT_CSD_SEC_GB_CL_EN)
+	if ((card->ext_csd.sec_feature_support & EXT_CSD_SEC_GB_CL_EN) &&
+	    (!(card->quirks & MMC_QUIRK_TRIM_BROKEN)))
 		return 1;
 	return 0;
 }
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 8fcbcd1..fdd0779 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -279,6 +279,8 @@ struct mmc_card {
 #define MMC_QUIRK_LONG_READ_TIME (1<<9)		/* Data read time > CSD says */
 #define MMC_QUIRK_SEC_ERASE_TRIM_BROKEN (1<<10)	/* Skip secure for erase/trim */
 #define MMC_QUIRK_BROKEN_IRQ_POLLING	(1<<11)	/* Polling SDIO_CCCR_INTx could create a fake interrupt */
+#define MMC_QUIRK_TRIM_BROKEN	(1<<12)		/* Skip trim */
+
 
 	unsigned int		erase_size;	/* erase size in sectors */
  	unsigned int		erase_shift;	/* if erase unit is power 2 */
-- 
2.3.7


