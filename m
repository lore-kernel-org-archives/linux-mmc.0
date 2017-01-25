From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4/6] mmc: core: Invent MMC_CAP_3_3V_DDR
Date: Wed, 25 Jan 2017 16:12:21 +0100
Message-ID: <1485357143-23280-5-git-send-email-ulf.hansson@linaro.org>
References: <1485357143-23280-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:33415 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751498AbdAYPMk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Jan 2017 10:12:40 -0500
Received: by mail-lf0-f48.google.com with SMTP id x1so43803642lff.0
        for <linux-mmc@vger.kernel.org>; Wed, 25 Jan 2017 07:12:39 -0800 (PST)
In-Reply-To: <1485357143-23280-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Stefan Wahren <stefan.wahren@i2se.com>, Fabio Estevam <festevam@gmail.com>, Jan Glauber <jan.glauber@caviumnetworks.com>

According the JEDEC specification an eMMC card supporting 1.8V vccq in DDR
mode should also be capable of 3.3V. However, it's been reported that some
mmc hosts supports 3.3V, but not 1.8V.

Currently the mmc core implements an error handling when the host fails to
set 1.8V for vccq, by falling back to 3.3V. Unfortunate, this seems to be
insufficient for some mmc hosts. To enable these to use eMMC DDR mode let's
invent a new mmc cap, MMC_CAP_3_3V_DDR, which tells whether they support
the eMMC 3.3V DDR mode.

In case MMC_CAP_3_3V_DDR is set, but not MMC_CAP_1_8V_DDR, let's change to
remain on the 3.3V, as it's the default voltage level for vccq, set by the
earlier power up sequence.

As this change introduces MMC_CAP_3_3V_DDR, let's take the opportunity to
do some re-formatting of the related defines in the header file.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc.c   | 11 +++++++----
 include/linux/mmc/host.h | 21 ++++++++++-----------
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 5844f29..f1a451e 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -213,7 +213,7 @@ static void mmc_select_card_type(struct mmc_card *card)
 		avail_type |= EXT_CSD_CARD_TYPE_HS_52;
 	}
 
-	if (caps & MMC_CAP_1_8V_DDR &&
+	if (caps & (MMC_CAP_1_8V_DDR | MMC_CAP_3_3V_DDR) &&
 	    card_type & EXT_CSD_CARD_TYPE_DDR_1_8V) {
 		hs_max_dtr = MMC_HIGH_DDR_MAX_DTR;
 		avail_type |= EXT_CSD_CARD_TYPE_DDR_1_8V;
@@ -1120,11 +1120,14 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
 	 *
 	 * WARNING: eMMC rules are NOT the same as SD DDR
 	 */
-	err = -EINVAL;
-	if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_DDR_1_2V)
+	if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_DDR_1_2V) {
 		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120);
+		if (!err)
+			return 0;
+	}
 
-	if (err && (card->mmc_avail_type & EXT_CSD_CARD_TYPE_DDR_1_8V))
+	if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_DDR_1_8V &&
+	    host->caps & MMC_CAP_1_8V_DDR)
 		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180);
 
 	/* make sure vccq is 3.3v after switching disaster */
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 97699d5..83f1c4a 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -259,17 +259,16 @@ struct mmc_host {
 #define MMC_CAP_NONREMOVABLE	(1 << 8)	/* Nonremovable e.g. eMMC */
 #define MMC_CAP_WAIT_WHILE_BUSY	(1 << 9)	/* Waits while card is busy */
 #define MMC_CAP_ERASE		(1 << 10)	/* Allow erase/trim commands */
-#define MMC_CAP_1_8V_DDR	(1 << 11)	/* can support */
-						/* DDR mode at 1.8V */
-#define MMC_CAP_1_2V_DDR	(1 << 12)	/* can support */
-						/* DDR mode at 1.2V */
-#define MMC_CAP_POWER_OFF_CARD	(1 << 13)	/* Can power off after boot */
-#define MMC_CAP_BUS_WIDTH_TEST	(1 << 14)	/* CMD14/CMD19 bus width ok */
-#define MMC_CAP_UHS_SDR12	(1 << 15)	/* Host supports UHS SDR12 mode */
-#define MMC_CAP_UHS_SDR25	(1 << 16)	/* Host supports UHS SDR25 mode */
-#define MMC_CAP_UHS_SDR50	(1 << 17)	/* Host supports UHS SDR50 mode */
-#define MMC_CAP_UHS_SDR104	(1 << 18)	/* Host supports UHS SDR104 mode */
-#define MMC_CAP_UHS_DDR50	(1 << 19)	/* Host supports UHS DDR50 mode */
+#define MMC_CAP_3_3V_DDR	(1 << 11)	/* Host supports eMMC DDR 3.3V */
+#define MMC_CAP_1_8V_DDR	(1 << 12)	/* Host supports eMMC DDR 1.8V */
+#define MMC_CAP_1_2V_DDR	(1 << 13)	/* Host supports eMMC DDR 1.2V */
+#define MMC_CAP_POWER_OFF_CARD	(1 << 14)	/* Can power off after boot */
+#define MMC_CAP_BUS_WIDTH_TEST	(1 << 15)	/* CMD14/CMD19 bus width ok */
+#define MMC_CAP_UHS_SDR12	(1 << 16)	/* Host supports UHS SDR12 mode */
+#define MMC_CAP_UHS_SDR25	(1 << 17)	/* Host supports UHS SDR25 mode */
+#define MMC_CAP_UHS_SDR50	(1 << 18)	/* Host supports UHS SDR50 mode */
+#define MMC_CAP_UHS_SDR104	(1 << 19)	/* Host supports UHS SDR104 mode */
+#define MMC_CAP_UHS_DDR50	(1 << 20)	/* Host supports UHS DDR50 mode */
 #define MMC_CAP_DRIVER_TYPE_A	(1 << 23)	/* Host supports Driver Type A */
 #define MMC_CAP_DRIVER_TYPE_C	(1 << 24)	/* Host supports Driver Type C */
 #define MMC_CAP_DRIVER_TYPE_D	(1 << 25)	/* Host supports Driver Type D */
-- 
1.9.1

