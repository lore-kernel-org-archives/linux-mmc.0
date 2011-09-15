From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH] mmc: sdio: Workaround for dev with broken CMD53
Date: Thu, 15 Sep 2011 17:43:04 +0200
Message-ID: <1316101384-21009-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog120.obsmtp.com ([207.126.144.149]:56084 "EHLO
	eu1sys200aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934046Ab1IOPoD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Sep 2011 11:44:03 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>

From: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>

Adds a quirk which can be turned on for SDIO devices
that do not support 512 byte requests in byte mode during
CMD53. These requests will always be sent in block mode
instead.

This patch also enables this quirk for ST-Ericsson
CW1200 WLAN device.

Change-Id: Id31787fcbfeb0b97ba2e8c583e9363a7c08811d2
Signed-off-by: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
Signed-off-by: Ulf HANSSON <ulf.hansson@stericsson.com>
---
 drivers/mmc/core/quirks.c   |   11 +++++++++++
 drivers/mmc/core/sdio_ops.c |    7 +++++--
 include/linux/mmc/card.h    |    7 +++++++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/quirks.c b/drivers/mmc/core/quirks.c
index 3a59621..6c3cf98 100644
--- a/drivers/mmc/core/quirks.c
+++ b/drivers/mmc/core/quirks.c
@@ -21,6 +21,14 @@
 #define SDIO_DEVICE_ID_TI_WL1271	0x4076
 #endif
 
+#ifndef SDIO_VENDOR_ID_STE
+#define SDIO_VENDOR_ID_STE		0x0020
+#endif
+
+#ifndef SDIO_DEVICE_ID_STE_CW1200
+#define SDIO_DEVICE_ID_STE_CW1200	0x2280
+#endif
+
 /*
  * This hook just adds a quirk for all sdio devices
  */
@@ -46,6 +54,9 @@ static const struct mmc_fixup mmc_fixup_methods[] = {
 	SDIO_FIXUP(SDIO_VENDOR_ID_TI, SDIO_DEVICE_ID_TI_WL1271,
 		   add_quirk, MMC_QUIRK_DISABLE_CD),
 
+	SDIO_FIXUP(SDIO_VENDOR_ID_STE, SDIO_DEVICE_ID_STE_CW1200,
+		   add_quirk, MMC_QUIRK_BROKEN_BYTE_MODE_512),
+
 	END_FIXUP
 };
 
diff --git a/drivers/mmc/core/sdio_ops.c b/drivers/mmc/core/sdio_ops.c
index f087d87..bcef326 100644
--- a/drivers/mmc/core/sdio_ops.c
+++ b/drivers/mmc/core/sdio_ops.c
@@ -144,8 +144,11 @@ int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
 	cmd.arg |= fn << 28;
 	cmd.arg |= incr_addr ? 0x04000000 : 0x00000000;
 	cmd.arg |= addr << 9;
-	if (blocks == 1 && blksz <= 512)
-		cmd.arg |= (blksz == 512) ? 0 : blksz;	/* byte mode */
+	if (blocks == 1 && blksz < 512)
+		cmd.arg |= blksz;			/* byte mode */
+	else if (blocks == 1 && blksz == 512 &&
+		 !(mmc_card_broken_byte_mode_512(card)))
+		cmd.arg |= 0;				/* byte mode, 0==512 */
 	else
 		cmd.arg |= 0x08000000 | blocks;		/* block mode */
 	cmd.flags = MMC_RSP_SPI_R5 | MMC_RSP_R5 | MMC_CMD_ADTC;
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index b460fc2..6dfb293 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -188,6 +188,8 @@ struct mmc_card {
 #define MMC_QUIRK_DISABLE_CD	(1<<5)		/* disconnect CD/DAT[3] resistor */
 #define MMC_QUIRK_INAND_CMD38	(1<<6)		/* iNAND devices have broken CMD38 */
 #define MMC_QUIRK_BLK_NO_CMD23	(1<<7)		/* Avoid CMD23 for regular multiblock */
+#define MMC_QUIRK_BROKEN_BYTE_MODE_512 (1<<8)	/* Avoid sending 512 bytes in */
+						/* byte mode */
 
 	unsigned int		erase_size;	/* erase size in sectors */
  	unsigned int		erase_shift;	/* if erase unit is power 2 */
@@ -377,6 +379,11 @@ static inline int mmc_card_nonstd_func_interface(const struct mmc_card *c)
 	return c->quirks & MMC_QUIRK_NONSTD_FUNC_IF;
 }
 
+static inline int mmc_card_broken_byte_mode_512(const struct mmc_card *c)
+{
+	return c->quirks & MMC_QUIRK_BROKEN_BYTE_MODE_512;
+}
+
 #define mmc_card_name(c)	((c)->cid.prod_name)
 #define mmc_card_id(c)		(dev_name(&(c)->dev))
 
-- 
1.7.5.4

