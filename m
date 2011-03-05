From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH] mmc: subtract boot sectors from disk size for eMMC 4.3+ devices
Date: Sat, 5 Mar 2011 13:15:44 +0100
Message-ID: <1299327344-12462-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog105.obsmtp.com ([207.126.144.119]:36933 "EHLO
	eu1sys200aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752692Ab1CEMQZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 5 Mar 2011 07:16:25 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@stericsson.com>, Gary King <gking@nvidia.com>, Ulf Hansson <ulf.hansson@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

This patch is a squash of patches from Gary King and Ulf
Hansson done in Android trees, hopefully fixing the issue properly.

The csd sector count reported by eMMC 4.3+ cards includes the boot
partition size; subtract this from the size reported to the disk
since the boot partition is inaccessible.

Signed-off-by: Gary King <gking@nvidia.com>
Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/mmc.c  |    7 +++++++
 include/linux/mmc/mmc.h |    1 +
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 14e95f3..03c3283 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -255,6 +255,13 @@ static int mmc_read_ext_csd(struct mmc_card *card)
 		/* Cards with density > 2GiB are sector addressed */
 		if (card->ext_csd.sectors > (2u * 1024 * 1024 * 1024) / 512)
 			mmc_card_set_blockaddr(card);
+
+		if (card->ext_csd.sectors) {
+			unsigned boot_sectors;
+			/* size is in 256K chunks, i.e. 512 sectors each */
+			boot_sectors = ext_csd[EXT_CSD_BOOT_SIZE_MULTI] * 512;
+			card->ext_csd.sectors -= boot_sectors;
+		}
 	}
 
 	switch (ext_csd[EXT_CSD_CARD_TYPE] & EXT_CSD_CARD_TYPE_MASK) {
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

