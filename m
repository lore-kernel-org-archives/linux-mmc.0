From: Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v3 1/2] mmc: core: Add discard support to sd
Date: Tue, 26 Feb 2019 17:10:24 +0200
Message-ID: <1551193825-31074-2-git-send-email-avri.altman@wdc.com>
References: <1551193825-31074-1-git-send-email-avri.altman@wdc.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551193825-31074-1-git-send-email-avri.altman@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Shawn Lin <shawn.lin@rock-chips.com>, Avi Shchislowski <avi.shchislowski@wdc.com>, Alex Lemberg <alex.lemberg@wdc.com>, linux-kernel@vger.kernel.org, Avri Altman <avri.altman@wdc.com>
List-Id: linux-mmc@vger.kernel.org

SD spec v5.1 adds discard support. The flows and commands are similar to
mmc, so just set the discard arg in CMD38.

A host which supports DISCARD shall check if the DISCARD_SUPPORT (b313)
is set in the SD_STATUS register.  If the card does not support discard,
the host shall not issue DISCARD command, but ERASE command instead.

Post the DISCARD operation, the card may de-allocate the discarded
blocks partially or completely. So the host mustn't make any assumptions
concerning the content of the discarded region. This is unlike ERASE
command, in which the region is guaranteed to contain either '0's or
'1's, depends on the content of DATA_STAT_AFTER_ERASE (b55) in the scr
register.

One more important difference compared to ERASE is the busy timeout
which we will address on the next patch.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/core.c |  8 ++++----
 drivers/mmc/core/sd.c   | 10 +++++++++-
 include/linux/mmc/sd.h  |  1 +
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 0950edf..b7367ac 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1847,7 +1847,7 @@ static unsigned int mmc_align_erase_size(struct mmc_card *card,
  * @card: card to erase
  * @from: first sector to erase
  * @nr: number of sectors to erase
- * @arg: erase command argument (SD supports only %SD_ERASE_ARG)
+ * @arg: erase command argument
  *
  * Caller must claim host before calling this function.
  */
@@ -1864,14 +1864,14 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
 	if (!card->erase_size)
 		return -EOPNOTSUPP;
 
-	if (mmc_card_sd(card) && arg != SD_ERASE_ARG)
+	if (mmc_card_sd(card) && arg != SD_ERASE_ARG && arg != SD_DISCARD_ARG)
 		return -EOPNOTSUPP;
 
-	if ((arg & MMC_SECURE_ARGS) &&
+	if (mmc_card_mmc(card) && (arg & MMC_SECURE_ARGS) &&
 	    !(card->ext_csd.sec_feature_support & EXT_CSD_SEC_ER_EN))
 		return -EOPNOTSUPP;
 
-	if ((arg & MMC_TRIM_ARGS) &&
+	if (mmc_card_mmc(card) && (arg & MMC_TRIM_ARGS) &&
 	    !(card->ext_csd.sec_feature_support & EXT_CSD_SEC_GB_CL_EN))
 		return -EOPNOTSUPP;
 
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index c2db94d..2b4fc22 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -231,6 +231,8 @@ static int mmc_read_ssr(struct mmc_card *card)
 {
 	unsigned int au, es, et, eo;
 	__be32 *raw_ssr;
+	u32 resp[4] = {};
+	u8 discard_support;
 	int i;
 
 	if (!(card->csd.cmdclass & CCC_APP_SPEC)) {
@@ -276,7 +278,13 @@ static int mmc_read_ssr(struct mmc_card *card)
 		}
 	}
 
-	card->erase_arg = SD_ERASE_ARG;
+	/*
+	 * starting SD5.1 discard is supported if DISCARD_SUPPORT (b313) is set
+	 */
+	resp[3] = card->raw_ssr[6];
+	discard_support = UNSTUFF_BITS(resp, 313 - 288, 1);
+	card->erase_arg = (card->scr.sda_specx && discard_support) ?
+			    SD_DISCARD_ARG : SD_ERASE_ARG;
 
 	return 0;
 }
diff --git a/include/linux/mmc/sd.h b/include/linux/mmc/sd.h
index 1a6d10f..ec94a5a 100644
--- a/include/linux/mmc/sd.h
+++ b/include/linux/mmc/sd.h
@@ -95,5 +95,6 @@
  * Erase/discard
  */
 #define SD_ERASE_ARG			0x00000000
+#define SD_DISCARD_ARG			0x00000001
 
 #endif /* LINUX_MMC_SD_H */
-- 
1.9.1
