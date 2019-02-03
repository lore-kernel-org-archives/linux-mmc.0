From: Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 3/3] mmc: core: Add discard support to sd
Date: Sun,  3 Feb 2019 10:50:28 +0200
Message-ID: <1549183828-17316-4-git-send-email-avri.altman@wdc.com>
References: <1549183828-17316-1-git-send-email-avri.altman@wdc.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1549183828-17316-1-git-send-email-avri.altman@wdc.com>
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
 drivers/mmc/core/sd.c   | 10 ++++++++++
 include/linux/mmc/sd.h  |  6 ++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 5bd58b9..c495935 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2181,7 +2181,10 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
 	if (!card->erase_size)
 		return -EOPNOTSUPP;
 
-	if (mmc_card_sd(card) && arg != MMC_ERASE_ARG)
+	if (mmc_card_sd(card) && arg == SD_DISCARD_ARG)
+		goto skip_arg_testing;
+
+	if (mmc_card_sd(card) && arg != SD_ERASE_ARG)
 		return -EOPNOTSUPP;
 
 	if ((arg & MMC_SECURE_ARGS) &&
@@ -2200,6 +2203,7 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
 	if (arg == MMC_ERASE_ARG)
 		nr = mmc_align_erase_size(card, &from, &to, nr);
 
+skip_arg_testing:
 	if (nr == 0)
 		return 0;
 
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 44f4cbc..b554a17 100644
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
@@ -276,6 +278,14 @@ static int mmc_read_ssr(struct mmc_card *card)
 		}
 	}
 
+	/*
+	 * starting SD5.1 discard is supported if DISCARD_SUPPORT (b313) is set
+	 */
+	resp[3] = card->raw_ssr[6];
+	discard_support = UNSTUFF_BITS(resp, 313 - 288, 1);
+	card->discard_arg = (card->scr.sda_specx && discard_support) ?
+			    SD_DISCARD_ARG : SD_ERASE_ARG;
+
 	return 0;
 }
 
diff --git a/include/linux/mmc/sd.h b/include/linux/mmc/sd.h
index 1ebcf9b..ec94a5a 100644
--- a/include/linux/mmc/sd.h
+++ b/include/linux/mmc/sd.h
@@ -91,4 +91,10 @@
 #define SD_SWITCH_ACCESS_DEF	0
 #define SD_SWITCH_ACCESS_HS	1
 
+/*
+ * Erase/discard
+ */
+#define SD_ERASE_ARG			0x00000000
+#define SD_DISCARD_ARG			0x00000001
+
 #endif /* LINUX_MMC_SD_H */
-- 
1.9.1
