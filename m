From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH] RFC: mmc: subtract boot sectors from disk size on quirky cards
Date: Thu, 28 Apr 2011 12:58:34 +0200
Message-ID: <1303988314-30316-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog109.obsmtp.com ([207.126.144.127]:60574 "EHLO
	eu1sys200aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752575Ab1D1K7B (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Apr 2011 06:59:01 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Gary King <gking@nvidia.com>, Ulf Hansson <ulf.hansson@stericsson.com>, Colin Cross <ccross@android.com>, Andrei Warkentin <andreiw@motorola.com>

From: Linus Walleij <linus.walleij@linaro.org>

The csd sector count reported by some problematic eMMC 4.3+ cards
includes the boot partition size; subtract this from the size
reported to the disk since the boot partition is inaccessible.

Cc: Gary King <gking@nvidia.com>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: Colin Cross <ccross@android.com>
Cc: Andrei Warkentin <andreiw@motorola.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
GARY: can you provide the VID+PID numbers for the problematic
card, so we can handle this properly?
---
 drivers/mmc/core/mmc.c    |   13 +++++++++++++
 drivers/mmc/core/quirks.c |    3 +++
 include/linux/mmc/card.h  |    1 +
 include/linux/mmc/mmc.h   |    1 +
 4 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 772d0d0..0833d15 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -255,6 +255,19 @@ static int mmc_read_ext_csd(struct mmc_card *card)
 		/* Cards with density > 2GiB are sector addressed */
 		if (card->ext_csd.sectors > (2u * 1024 * 1024 * 1024) / 512)
 			mmc_card_set_blockaddr(card);
+
+		/*
+		 * Some cards require that you remove the boot sectors from the
+		 * total amount of sectors on the card. This is not defined
+		 * by the spec so needs to be a per-card quirk.
+		 */
+		if (card->ext_csd.sectors &&
+		    (card->quirks & MMC_QUIRK_SUBTRACT_BOOTSECS)) {
+			unsigned boot_sectors;
+			/* size is in 128K chunks, i.e. 256 sectors each */
+			boot_sectors = ext_csd[EXT_CSD_BOOT_SIZE_MULTI] * 256;
+			card->ext_csd.sectors -= boot_sectors;
+		}
 	}
 
 	switch (ext_csd[EXT_CSD_CARD_TYPE] & EXT_CSD_CARD_TYPE_MASK) {
diff --git a/drivers/mmc/core/quirks.c b/drivers/mmc/core/quirks.c
index 11118b74..fb1f528 100644
--- a/drivers/mmc/core/quirks.c
+++ b/drivers/mmc/core/quirks.c
@@ -64,6 +64,9 @@ static const struct mmc_fixup mmc_fixup_methods[] = {
 		add_quirk_for_sdio_devices, MMC_QUIRK_BROKEN_CLK_GATING },
 	{ SDIO_VENDOR_ID_TI, SDIO_DEVICE_ID_TI_WL1271,
 		remove_quirk, MMC_QUIRK_BROKEN_CLK_GATING },
+	/* TODO: fill in problematic card VID/PID here */
+	{ 0x0000, 0x0000,
+		add_quirk, MMC_QUIRK_SUBTRACT_BOOTSECS },
 	{ 0 }
 };
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index adb4888..f860eea 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -125,6 +125,7 @@ struct mmc_card {
 #define MMC_QUIRK_NONSTD_SDIO	(1<<2)		/* non-standard SDIO card attached */
 						/* (missing CIA registers) */
 #define MMC_QUIRK_BROKEN_CLK_GATING (1<<3)	/* clock gating the sdio bus will make card fail */
+#define MMC_QUIRK_SUBTRACT_BOOTSECS (1<<4)	/* remove any boot sectors from the sector allocation pool */
 
 	unsigned int		erase_size;	/* erase size in sectors */
  	unsigned int		erase_shift;	/* if erase unit is power 2 */
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 264ba54..4516fc1 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -267,6 +267,7 @@ struct _mmc_csd {
 #define EXT_CSD_HC_WP_GRP_SIZE		221	/* RO */
 #define EXT_CSD_ERASE_TIMEOUT_MULT	223	/* RO */
 #define EXT_CSD_HC_ERASE_GRP_SIZE	224	/* RO */
+#define EXT_CSD_BOOT_SIZE_MULTI		226	/* RO */
 #define EXT_CSD_SEC_TRIM_MULT		229	/* RO */
 #define EXT_CSD_SEC_ERASE_MULT		230	/* RO */
 #define EXT_CSD_SEC_FEATURE_SUPPORT	231	/* RO */
-- 
1.7.3.2

