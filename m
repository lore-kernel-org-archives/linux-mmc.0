From: Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v2 3/3] mmc: core: Add discard support to sd
Date: Wed,  6 Feb 2019 13:28:07 +0200
Message-ID: <1549452487-17193-4-git-send-email-avri.altman@wdc.com>
References: <1549452487-17193-1-git-send-email-avri.altman@wdc.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1549452487-17193-1-git-send-email-avri.altman@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Shawn Lin <shawn.lin@rock-chips.com>, Avi Shchislowski <avi.shchislowski@wdc.com>, Alex Lemberg <alex.lemberg@wdc.com>, linux-kernel@vger.kernel.org, Avri Altman <avri.altman@wdc.com>
List-Id: linux-mmc@vger.kernel.org

SD spec v5.1 adds discard support. The flows and commands are similar to
mmc, so just set the discard arg in CMD38.

Actually, there is no need to check for the spec version like we are
doing, as it is assured that the reserved bits in earlier versions are
null. Do that anyway to document the spec version that introduce it.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/core.c |  6 +++++-
 drivers/mmc/core/sd.c   | 10 +++++++++-
 include/linux/mmc/sd.h  |  1 +
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index de0f1a1..4d62f28 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2164,7 +2164,7 @@ static unsigned int mmc_align_erase_size(struct mmc_card *card,
  * @card: card to erase
  * @from: first sector to erase
  * @nr: number of sectors to erase
- * @arg: erase command argument (SD supports only %SD_ERASE_ARG)
+ * @arg: erase command argument
  *
  * Caller must claim host before calling this function.
  */
@@ -2181,6 +2181,9 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
 	if (!card->erase_size)
 		return -EOPNOTSUPP;
 
+	if (mmc_card_sd(card) && arg == SD_DISCARD_ARG)
+		goto skip_arg_testing;
+
 	if (mmc_card_sd(card) && arg != SD_ERASE_ARG)
 		return -EOPNOTSUPP;
 
@@ -2200,6 +2203,7 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
 	if (arg == MMC_ERASE_ARG)
 		nr = mmc_align_erase_size(card, &from, &to, nr);
 
+skip_arg_testing:
 	if (nr == 0)
 		return 0;
 
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
